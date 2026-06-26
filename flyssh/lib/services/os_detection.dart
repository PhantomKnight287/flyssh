import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OsInfo {
  final String id;
  final String name;
  final String? version;
  final String? prettyName;

  OsInfo({
    required this.id,
    required this.name,
    this.version,
    this.prettyName,
  });

  String get displayName => prettyName ?? '$name ${version ?? ''}'.trim();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'version': version,
        'prettyName': prettyName,
      };

  factory OsInfo.fromJson(Map<String, dynamic> json) => OsInfo(
        id: json['id'] ?? 'unknown',
        name: json['name'] ?? 'Unknown',
        version: json['version'],
        prettyName: json['prettyName'],
      );

  factory OsInfo.unknown() => OsInfo(id: 'unknown', name: 'Unknown');

  IconData get icon => osIcons[id] ?? Icons.computer;

  String? get logoAsset => osLogos[id];

  static const Map<String, IconData> osIcons = {
    'debian': Icons.circle,
    'ubuntu': Icons.circle,
    'fedora': Icons.circle,
    'centos': Icons.circle,
    'rhel': Icons.circle,
    'arch': Icons.circle,
    'alpine': Icons.circle,
    'opensuse': Icons.circle,
    'sles': Icons.circle,
    'gentoo': Icons.circle,
    'manjaro': Icons.circle,
    'kali': Icons.circle,
    'raspbian': Icons.circle,
    'freebsd': Icons.circle,
    'openbsd': Icons.circle,
    'darwin': Icons.laptop_mac,
    'unknown': Icons.computer,
  };

  static const Map<String, String> osLogos = {
    'debian': '🐧',
    'ubuntu': '🟠',
    'fedora': '🔵',
    'centos': '🟣',
    'rhel': '🔴',
    'arch': '🔷',
    'alpine': '🏔️',
    'opensuse': '🦎',
    'sles': '🦎',
    'gentoo': '🐄',
    'manjaro': '🟢',
    'kali': '🐉',
    'raspbian': '🍓',
    'freebsd': '😈',
    'openbsd': '🐡',
    'darwin': '🍎',
  };

  /// Get a color associated with the OS for the avatar
  static Color getOsColor(String osId) {
    switch (osId) {
      case 'debian':
        return const Color(0xFFD70A53);
      case 'ubuntu':
        return const Color(0xFFE95420);
      case 'fedora':
        return const Color(0xFF3C6EB4);
      case 'centos':
        return const Color(0xFF932178);
      case 'rhel':
        return const Color(0xFFEE0000);
      case 'arch':
        return const Color(0xFF1793D1);
      case 'alpine':
        return const Color(0xFF0D597F);
      case 'opensuse':
      case 'sles':
        return const Color(0xFF73BA25);
      case 'gentoo':
        return const Color(0xFF54487A);
      case 'manjaro':
        return const Color(0xFF35BF5C);
      case 'kali':
        return const Color(0xFF557C94);
      case 'raspbian':
        return const Color(0xFFC51A4A);
      case 'freebsd':
        return const Color(0xFFAB2B28);
      case 'openbsd':
        return const Color(0xFFF2CA30);
      case 'darwin':
        return const Color(0xFF555555);
      default:
        return const Color(0xFF607D8B);
    }
  }
}

@singleton
class OsDetectionService extends ChangeNotifier {
  static const _cachePrefix = 'os_info_';
  SharedPreferences? _prefs;
  final Map<String, OsInfo> _cache = {};
  late final Future<void> _initFuture;

  OsDetectionService() {
    _initFuture = _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadCache();
  }

  Future<void> _ensureInitialized() => _initFuture;

  void _loadCache() {
    final prefs = _prefs;
    if (prefs == null) return;
    final keys = prefs.getKeys().where((k) => k.startsWith(_cachePrefix));
    for (final key in keys) {
      final hostId = key.substring(_cachePrefix.length);
      final json = prefs.getString(key);
      if (json != null) {
        try {
          _cache[hostId] = OsInfo.fromJson(
            Map<String, dynamic>.from(jsonDecode(json) as Map),
          );
        } catch (_) {}
      }
    }
  }

  OsInfo? getCachedOsInfo(String hostId) => _cache[hostId];

  Future<OsInfo> detectOs(SSHClient client, String hostId) async {
    await _ensureInitialized();
    try {
      final result = await client.run('cat /etc/os-release 2>/dev/null || '
          'sw_vers 2>/dev/null || '
          'uname -s 2>/dev/null');
      final output = utf8.decode(result, allowMalformed: true);
      final info = _parseOsRelease(output);

      _cache[hostId] = info;
      await _prefs?.setString(
        '$_cachePrefix$hostId',
        jsonEncode(info.toJson()),
      );
      notifyListeners();
      return info;
    } catch (_) {
      final unknown = OsInfo.unknown();
      _cache[hostId] = unknown;
      notifyListeners();
      return unknown;
    }
  }

  OsInfo _parseOsRelease(String output) {
    final lines = output.split('\n');
    final map = <String, String>{};

    for (final line in lines) {
      final idx = line.indexOf('=');
      if (idx > 0) {
        final key = line.substring(0, idx).trim();
        var value = line.substring(idx + 1).trim();
        if (value.startsWith('"') && value.endsWith('"')) {
          value = value.substring(1, value.length - 1);
        }
        map[key] = value;
      }
    }

    // Standard os-release fields
    if (map.containsKey('ID')) {
      return OsInfo(
        id: map['ID']!.toLowerCase(),
        name: map['NAME'] ?? map['ID']!,
        version: map['VERSION_ID'],
        prettyName: map['PRETTY_NAME'],
      );
    }

    // macOS sw_vers format
    if (map.containsKey('ProductName')) {
      return OsInfo(
        id: 'darwin',
        name: map['ProductName']!,
        version: map['ProductVersion'],
        prettyName: '${map['ProductName']} ${map['ProductVersion'] ?? ''}',
      );
    }

    // Fallback to uname
    final trimmed = output.trim();
    if (trimmed.toLowerCase().contains('darwin')) {
      return OsInfo(id: 'darwin', name: 'macOS');
    }
    if (trimmed.toLowerCase().contains('linux')) {
      return OsInfo(id: 'linux', name: 'Linux');
    }
    if (trimmed.toLowerCase().contains('freebsd')) {
      return OsInfo(id: 'freebsd', name: 'FreeBSD');
    }

    return OsInfo.unknown();
  }

  void clearCache(String hostId) {
    _cache.remove(hostId);
    _prefs?.remove('$_cachePrefix$hostId');
    notifyListeners();
  }
}
