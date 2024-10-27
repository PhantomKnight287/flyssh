// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'count.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Count extends Count {
  @override
  final num hosts;

  factory _$Count([void Function(CountBuilder)? updates]) =>
      (new CountBuilder()..update(updates))._build();

  _$Count._({required this.hosts}) : super._() {
    BuiltValueNullFieldError.checkNotNull(hosts, r'Count', 'hosts');
  }

  @override
  Count rebuild(void Function(CountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountBuilder toBuilder() => new CountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Count && hosts == other.hosts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, hosts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Count')..add('hosts', hosts))
        .toString();
  }
}

class CountBuilder implements Builder<Count, CountBuilder> {
  _$Count? _$v;

  num? _hosts;
  num? get hosts => _$this._hosts;
  set hosts(num? hosts) => _$this._hosts = hosts;

  CountBuilder() {
    Count._defaults(this);
  }

  CountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hosts = $v.hosts;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Count other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Count;
  }

  @override
  void update(void Function(CountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Count build() => _build();

  _$Count _build() {
    final _$result = _$v ??
        new _$Count._(
            hosts: BuiltValueNullFieldError.checkNotNull(
                hosts, r'Count', 'hosts'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
