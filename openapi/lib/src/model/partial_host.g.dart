// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partial_host.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PartialHost extends PartialHost {
  @override
  final String id;
  @override
  final String label;
  @override
  final String username;

  factory _$PartialHost([void Function(PartialHostBuilder)? updates]) =>
      (new PartialHostBuilder()..update(updates))._build();

  _$PartialHost._(
      {required this.id, required this.label, required this.username})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, r'PartialHost', 'id');
    BuiltValueNullFieldError.checkNotNull(label, r'PartialHost', 'label');
    BuiltValueNullFieldError.checkNotNull(username, r'PartialHost', 'username');
  }

  @override
  PartialHost rebuild(void Function(PartialHostBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PartialHostBuilder toBuilder() => new PartialHostBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PartialHost &&
        id == other.id &&
        label == other.label &&
        username == other.username;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, label.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PartialHost')
          ..add('id', id)
          ..add('label', label)
          ..add('username', username))
        .toString();
  }
}

class PartialHostBuilder implements Builder<PartialHost, PartialHostBuilder> {
  _$PartialHost? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _label;
  String? get label => _$this._label;
  set label(String? label) => _$this._label = label;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  PartialHostBuilder() {
    PartialHost._defaults(this);
  }

  PartialHostBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _label = $v.label;
      _username = $v.username;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PartialHost other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PartialHost;
  }

  @override
  void update(void Function(PartialHostBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PartialHost build() => _build();

  _$PartialHost _build() {
    final _$result = _$v ??
        new _$PartialHost._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'PartialHost', 'id'),
            label: BuiltValueNullFieldError.checkNotNull(
                label, r'PartialHost', 'label'),
            username: BuiltValueNullFieldError.checkNotNull(
                username, r'PartialHost', 'username'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
