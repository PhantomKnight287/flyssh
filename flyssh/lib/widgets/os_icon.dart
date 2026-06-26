import 'package:flutter/material.dart';
import 'package:flyssh/services/os_detection.dart';

/// A widget that displays a branded OS icon using custom painters.
/// Uses the OS brand color and a recognizable abbreviation or symbol.
class OsIcon extends StatelessWidget {
  final String osId;
  final double size;

  const OsIcon({super.key, required this.osId, this.size = 32});

  @override
  Widget build(BuildContext context) {
    final color = OsInfo.getOsColor(osId);
    final config = _osConfigs[osId] ?? _OsConfig('?', null);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      child: Center(
        child: config.iconData != null
            ? Icon(config.iconData, size: size * 0.55, color: color)
            : Text(
                config.abbr,
                style: TextStyle(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.w800,
                  color: color,
                  height: 1,
                ),
              ),
      ),
    );
  }
}

class _OsConfig {
  final String abbr;
  final IconData? iconData;

  const _OsConfig(this.abbr, this.iconData);
}

const _osConfigs = <String, _OsConfig>{
  'ubuntu': _OsConfig('Ub', null),
  'debian': _OsConfig('De', null),
  'fedora': _OsConfig('Fe', null),
  'centos': _OsConfig('Ce', null),
  'rhel': _OsConfig('RH', null),
  'arch': _OsConfig('Ar', null),
  'alpine': _OsConfig('Al', null),
  'opensuse': _OsConfig('oS', null),
  'sles': _OsConfig('SL', null),
  'gentoo': _OsConfig('Ge', null),
  'manjaro': _OsConfig('Mj', null),
  'kali': _OsConfig('Ka', null),
  'raspbian': _OsConfig('Pi', null),
  'freebsd': _OsConfig('FB', null),
  'openbsd': _OsConfig('OB', null),
  'darwin': _OsConfig('', Icons.laptop_mac),
  'linux': _OsConfig('Lx', null),
  'unknown': _OsConfig('', Icons.computer),
};
