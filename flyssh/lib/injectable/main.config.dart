// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flyssh/screens/auth/login/controller.dart' as _i167;
import 'package:flyssh/screens/auth/recover/controller.dart' as _i4;
import 'package:flyssh/screens/auth/register/controller.dart' as _i503;
import 'package:flyssh/screens/auth/service.dart' as _i20;
import 'package:flyssh/screens/hosts/create/controller.dart' as _i323;
import 'package:flyssh/screens/hosts/detail/controller.dart' as _i282;
import 'package:flyssh/screens/hosts/edit/controller.dart' as _i51;
import 'package:flyssh/screens/hosts/list/controller.dart' as _i269;
import 'package:flyssh/screens/hosts/service.dart' as _i154;
import 'package:flyssh/screens/keys/create/controller.dart' as _i334;
import 'package:flyssh/screens/keys/detail/controller.dart' as _i473;
import 'package:flyssh/screens/keys/edit/controller.dart' as _i207;
import 'package:flyssh/screens/keys/list/controller.dart' as _i38;
import 'package:flyssh/screens/keys/service.dart' as _i457;
import 'package:flyssh/services/crypto.dart' as _i254;
import 'package:flyssh/services/master_key.dart' as _i895;
import 'package:flyssh/services/os_detection.dart' as _i572;
import 'package:flyssh/services/settings.dart' as _i295;
import 'package:flyssh/services/ssh.dart' as _i683;
import 'package:flyssh/services/token.dart' as _i744;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i254.CryptoService>(() => _i254.CryptoService());
    gh.singleton<_i895.MasterKeyService>(() => _i895.MasterKeyService());
    gh.singleton<_i572.OsDetectionService>(() => _i572.OsDetectionService());
    gh.singleton<_i295.SettingsService>(() => _i295.SettingsService());
    gh.singleton<_i744.TokenService>(() => _i744.TokenService());
    gh.factory<_i20.AuthService>(
      () => _i20.AuthService(gh<_i254.CryptoService>()),
    );
    gh.singleton<_i683.SshSessionManager>(
      () => _i683.SshSessionManager(gh<_i572.OsDetectionService>()),
    );
    gh.factory<_i154.HostService>(
      () => _i154.HostService(
        gh<_i254.CryptoService>(),
        gh<_i895.MasterKeyService>(),
      ),
    );
    gh.factory<_i457.KeyService>(
      () => _i457.KeyService(
        gh<_i254.CryptoService>(),
        gh<_i895.MasterKeyService>(),
      ),
    );
    gh.factory<_i282.HostDetailController>(
      () => _i282.HostDetailController(gh<_i154.HostService>()),
    );
    gh.factory<_i269.HostListController>(
      () => _i269.HostListController(gh<_i154.HostService>()),
    );
    gh.factory<_i4.RecoverController>(
      () => _i4.RecoverController(
        gh<_i20.AuthService>(),
        gh<_i254.CryptoService>(),
      ),
    );
    gh.factory<_i167.LoginController>(
      () => _i167.LoginController(
        gh<_i20.AuthService>(),
        gh<_i744.TokenService>(),
        gh<_i895.MasterKeyService>(),
      ),
    );
    gh.factory<_i334.KeyCreateController>(
      () => _i334.KeyCreateController(gh<_i457.KeyService>()),
    );
    gh.factory<_i473.KeyDetailController>(
      () => _i473.KeyDetailController(gh<_i457.KeyService>()),
    );
    gh.factory<_i207.KeyEditController>(
      () => _i207.KeyEditController(gh<_i457.KeyService>()),
    );
    gh.factory<_i38.KeyListController>(
      () => _i38.KeyListController(gh<_i457.KeyService>()),
    );
    gh.factory<_i503.RegisterController>(
      () => _i503.RegisterController(
        gh<_i20.AuthService>(),
        gh<_i744.TokenService>(),
        gh<_i895.MasterKeyService>(),
        gh<_i254.CryptoService>(),
      ),
    );
    gh.factory<_i323.HostCreateController>(
      () => _i323.HostCreateController(
        gh<_i154.HostService>(),
        gh<_i457.KeyService>(),
      ),
    );
    gh.factory<_i51.HostEditController>(
      () => _i51.HostEditController(
        gh<_i154.HostService>(),
        gh<_i457.KeyService>(),
      ),
    );
    return this;
  }
}
