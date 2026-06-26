import 'package:flutter/material.dart';
import 'package:flyssh/services/sftp.dart';

class FileListItem extends StatelessWidget {
  final SftpFileEntry entry;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const FileListItem({
    super.key,
    required this.entry,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        entry.isDirectory ? Icons.folder : _fileIcon(entry.name),
        color: entry.isDirectory
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        entry.name,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        entry.isDirectory
            ? "Directory"
            : _formatSize(entry.size),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: entry.modifiedTime != null
          ? Text(
              _formatDate(entry.modifiedTime!),
              style: Theme.of(context).textTheme.labelSmall,
            )
          : null,
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  IconData _fileIcon(String name) {
    final ext = name.split('.').last.toLowerCase();
    switch (ext) {
      case 'txt':
      case 'md':
      case 'log':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'svg':
        return Icons.image;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'zip':
      case 'tar':
      case 'gz':
      case 'rar':
        return Icons.archive;
      case 'py':
      case 'js':
      case 'ts':
      case 'dart':
      case 'go':
      case 'rs':
      case 'java':
      case 'c':
      case 'cpp':
      case 'h':
        return Icons.code;
      case 'json':
      case 'yaml':
      case 'yml':
      case 'toml':
      case 'xml':
        return Icons.data_object;
      case 'sh':
      case 'bash':
      case 'zsh':
        return Icons.terminal;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
