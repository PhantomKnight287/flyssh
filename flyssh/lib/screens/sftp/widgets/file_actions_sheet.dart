import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flyssh/constants/main.dart';
import 'package:flyssh/services/sftp.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:toastification/toastification.dart';

class FileActionsSheet extends StatefulWidget {
  final SftpFileEntry entry;
  final String currentPath;
  final SftpService sftpService;
  final VoidCallback onDelete;
  final VoidCallback onRefresh;

  const FileActionsSheet({
    super.key,
    required this.entry,
    required this.currentPath,
    required this.sftpService,
    required this.onDelete,
    required this.onRefresh,
  });

  @override
  State<FileActionsSheet> createState() => _FileActionsSheetState();
}

class _FileActionsSheetState extends State<FileActionsSheet> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  Future<void> _download() async {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    try {
      final remotePath = widget.currentPath == '/'
          ? '/${widget.entry.name}'
          : '${widget.currentPath}/${widget.entry.name}';

      if (PlatformHelper.isDesktop) {
        final savePath = await FilePicker.platform.saveFile(
          dialogTitle: 'Save file',
          fileName: widget.entry.name,
        );
        if (savePath == null) {
          setState(() => _isDownloading = false);
          return;
        }
        await widget.sftpService.downloadToLocalWithProgress(
          remotePath,
          savePath,
          onProgress: (received, total) {
            if (total > 0) {
              setState(() => _downloadProgress = received / total);
            }
          },
        );
      } else {
        final tempDir = Directory.systemTemp;
        final localPath = '${tempDir.path}/${widget.entry.name}';
        await widget.sftpService.downloadToLocalWithProgress(
          remotePath,
          localPath,
          onProgress: (received, total) {
            if (total > 0) {
              setState(() => _downloadProgress = received / total);
            }
          },
        );
      }

      if (mounted) {
        Navigator.pop(context);
        toastification.show(
          title: Text("Downloaded ${widget.entry.name}"),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isDownloading = false);
        toastification.show(
          title: Text("Download failed: $e"),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              widget.entry.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: widget.entry.size > 0
                ? Text(_formatFileSize(widget.entry.size))
                : null,
          ),
          Divider(),
          if (_isDownloading) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: BASE_SPACE * 4,
                vertical: BASE_SPACE * 2,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: _downloadProgress > 0
                              ? _downloadProgress
                              : null,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(width: BASE_SPACE * 2),
                      Text(
                        "${(_downloadProgress * 100).toInt()}%",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: BASE_SPACE),
                  Text(
                    "Downloading...",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ] else ...[
            ListTile(
              leading: Icon(Icons.download),
              title: Text("Download"),
              onTap: _download,
            ),
            ListTile(
              leading: Icon(Icons.delete,
                  color: Theme.of(context).colorScheme.error),
              title: Text("Delete",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: widget.onDelete,
            ),
          ],
        ],
      ),
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
