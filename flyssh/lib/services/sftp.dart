import 'dart:io';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';

class SftpFileEntry {
  final String name;
  final bool isDirectory;
  final int size;
  final DateTime? modifiedTime;

  SftpFileEntry({
    required this.name,
    required this.isDirectory,
    required this.size,
    this.modifiedTime,
  });
}

class SftpService {
  final SSHClient _client;
  SftpClient? _sftp;

  SftpService(this._client);

  Future<void> init() async {
    _sftp = await _client.sftp();
  }

  Future<List<SftpFileEntry>> listDirectory(String path) async {
    final items = await _sftp!.listdir(path);

    return items
        .where((item) => item.filename != '.' && item.filename != '..')
        .map((item) => SftpFileEntry(
              name: item.filename,
              isDirectory: item.attr.isDirectory,
              size: item.attr.size ?? 0,
              modifiedTime: item.attr.modifyTime != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                      item.attr.modifyTime! * 1000)
                  : null,
            ))
        .toList()
      ..sort((a, b) {
        if (a.isDirectory && !b.isDirectory) return -1;
        if (!a.isDirectory && b.isDirectory) return 1;
        return a.name.compareTo(b.name);
      });
  }

  Future<void> mkdir(String path) async {
    await _sftp!.mkdir(path);
  }

  Future<void> delete(String path, {bool isDirectory = false}) async {
    if (isDirectory) {
      await _sftp!.rmdir(path);
    } else {
      await _sftp!.remove(path);
    }
  }

  Future<void> rename(String oldPath, String newPath) async {
    await _sftp!.rename(oldPath, newPath);
  }

  Future<void> uploadFile(String localPath, String remotePath) async {
    final file = File(localPath);
    final data = await file.readAsBytes();
    final remoteFile = await _sftp!.open(
      remotePath,
      mode: SftpFileOpenMode.create |
          SftpFileOpenMode.write |
          SftpFileOpenMode.truncate,
    );
    await remoteFile.writeBytes(data);
    await remoteFile.close();
  }

  Future<Uint8List> downloadFile(String remotePath) async {
    final file = await _sftp!.open(remotePath);
    final data = await file.readBytes();
    await file.close();
    return data;
  }

  Future<void> downloadToLocal(String remotePath, String localPath) async {
    final data = await downloadFile(remotePath);
    final file = File(localPath);
    await file.writeAsBytes(data);
  }

  Future<void> downloadToLocalWithProgress(
    String remotePath,
    String localPath, {
    void Function(int received, int total)? onProgress,
  }) async {
    final remoteFile = await _sftp!.open(remotePath);
    final stat = await remoteFile.stat();
    final totalSize = stat.size ?? 0;

    final localFile = File(localPath);
    final sink = localFile.openWrite();
    int received = 0;

    final stream = remoteFile.read();
    await for (final chunk in stream) {
      sink.add(chunk);
      received += chunk.length;
      onProgress?.call(received, totalSize);
    }

    await sink.close();
    await remoteFile.close();
  }

  void close() {
    _sftp?.close();
  }
}
