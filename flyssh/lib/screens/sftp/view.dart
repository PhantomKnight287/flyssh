import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/services/sftp.dart';
import 'package:flyssh/services/ssh.dart';
import 'package:flyssh/screens/sftp/widgets/breadcrumb_bar.dart';
import 'package:flyssh/screens/sftp/widgets/file_list_item.dart';
import 'package:flyssh/screens/sftp/widgets/file_actions_sheet.dart';
import 'package:flyssh/screens/sftp/widgets/create_dialog.dart';
import 'package:flyssh/widgets/confirm_dialog.dart';
import 'package:flyssh/widgets/page_scaffold.dart';
import 'package:file_picker/file_picker.dart';
import 'package:toastification/toastification.dart';

class SftpView extends StatefulWidget {
  final String sessionId;

  const SftpView({super.key, required this.sessionId});

  @override
  State<SftpView> createState() => _SftpViewState();
}

class _SftpViewState extends State<SftpView> {
  final SshSessionManager _sessionManager = getIt<SshSessionManager>();
  SftpService? _sftpService;
  String _currentPath = '/';
  List<SftpFileEntry> _files = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initSftp();
  }

  Future<void> _initSftp() async {
    try {
      final session = _sessionManager.sessions[widget.sessionId];
      if (session == null || session.client == null) {
        setState(() {
          _error = 'Session not found or disconnected';
          _isLoading = false;
        });
        return;
      }
      _sftpService = SftpService(session.client!);
      await _sftpService!.init();
      await _loadDirectory('/');
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadDirectory(String path) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final files = await _sftpService!.listDirectory(path);
      setState(() {
        _currentPath = path;
        _files = files;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateTo(String name) async {
    final newPath = _currentPath == '/'
        ? '/$name'
        : '$_currentPath/$name';
    await _loadDirectory(newPath);
  }

  Future<void> _navigateUp() async {
    if (_currentPath == '/') return;
    final parts = _currentPath.split('/');
    parts.removeLast();
    final parentPath = parts.isEmpty ? '/' : parts.join('/');
    await _loadDirectory(parentPath.isEmpty ? '/' : parentPath);
  }

  Future<void> _uploadFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    if (file.path == null) return;

    setState(() => _isLoading = true);
    try {
      await _sftpService!.uploadFile(
        file.path!,
        '$_currentPath/${file.name}',
      );
      await _loadDirectory(_currentPath);
      if (mounted) {
        toastification.show(
          title: Text("File uploaded successfully"),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      if (mounted) {
        toastification.show(
          title: Text("Upload failed: $e"),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
    setState(() => _isLoading = false);
  }

  Future<void> _createDirectory() async {
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => const CreateDirectoryDialog(),
    );
    if (name == null || name.isEmpty) return;
    try {
      await _sftpService!.mkdir('$_currentPath/$name');
      await _loadDirectory(_currentPath);
    } catch (e) {
      if (mounted) {
        toastification.show(
          title: Text("Failed to create directory: $e"),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }

  Future<void> _deleteEntry(SftpFileEntry entry) async {
    final confirm = await showConfirmDialog(
      context: context,
      title: "Delete ${entry.name}?",
      message: "This action cannot be undone.",
    );
    if (confirm != true) return;
    try {
      final path = _currentPath == '/'
          ? '/${entry.name}'
          : '$_currentPath/${entry.name}';
      await _sftpService!.delete(path, isDirectory: entry.isDirectory);
      await _loadDirectory(_currentPath);
    } catch (e) {
      if (mounted) {
        toastification.show(
          title: Text("Delete failed: $e"),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  void dispose() {
    _sftpService?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: "SFTP",
      showBackButton: true,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: "mkdir",
            onPressed: _createDirectory,
            child: Icon(Icons.create_new_folder),
          ),
          SizedBox(height: BASE_SPACE * 2),
          FloatingActionButton(
            heroTag: "upload",
            onPressed: _uploadFile,
            child: Icon(Icons.upload_file),
          ),
        ],
      ),
      body: Column(
        children: [
          BreadcrumbBar(
            path: _currentPath,
            onNavigate: _loadDirectory,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(BASE_SPACE * 4),
                          child: Text(
                            _error!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _loadDirectory(_currentPath),
                        child: ListView.builder(
                          itemCount: _files.length + (_currentPath != '/' ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (_currentPath != '/' && index == 0) {
                              return ListTile(
                                leading: Icon(Icons.arrow_upward),
                                title: Text(".."),
                                onTap: _navigateUp,
                              );
                            }
                            final fileIndex = _currentPath != '/' ? index - 1 : index;
                            final file = _files[fileIndex];
                            return FileListItem(
                              entry: file,
                              onTap: () {
                                if (file.isDirectory) {
                                  _navigateTo(file.name);
                                } else {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) => FileActionsSheet(
                                      entry: file,
                                      currentPath: _currentPath,
                                      sftpService: _sftpService!,
                                      onDelete: () {
                                        Navigator.pop(ctx);
                                        _deleteEntry(file);
                                      },
                                      onRefresh: () => _loadDirectory(_currentPath),
                                    ),
                                  );
                                }
                              },
                              onLongPress: () => _deleteEntry(file),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
