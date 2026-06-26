import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flyssh/injectable/main.dart';
import 'package:flyssh/screens/auth/login/view.dart';
import 'package:flyssh/screens/auth/recover/view.dart';
import 'package:flyssh/screens/auth/register/view.dart';
import 'package:flyssh/screens/hosts/create/view.dart';
import 'package:flyssh/screens/hosts/detail/view.dart';
import 'package:flyssh/screens/hosts/edit/view.dart';
import 'package:flyssh/screens/hosts/list/view.dart';
import 'package:flyssh/screens/keys/create/view.dart';
import 'package:flyssh/screens/keys/detail/view.dart';
import 'package:flyssh/screens/keys/edit/view.dart';
import 'package:flyssh/screens/keys/list/view.dart';
import 'package:flyssh/screens/settings/view.dart';
import 'package:flyssh/screens/shell/view.dart';
import 'package:flyssh/screens/terminal/view.dart';
import 'package:flyssh/screens/port_forward/view.dart';
import 'package:flyssh/screens/sftp/view.dart';
import 'package:flyssh/services/token.dart';
import 'package:flyssh/utils/adaptive.dart';
import 'package:go_router/go_router.dart';

/// On desktop, pages appear instantly. On mobile, default platform transitions.
Page<T> _buildPage<T>(BuildContext context, GoRouterState state, Widget child) {
  if (PlatformHelper.isDesktop) {
    return NoTransitionPage<T>(child: child);
  }
  return MaterialPage<T>(child: child);
}

class FlysshRouter {
  final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: "/hosts",
    redirect: (context, state) async {
      final token = await getIt<TokenService>().getToken();
      final isLoggedIn = token.isNotEmpty;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');

      if (!isLoggedIn && !isAuthRoute) {
        return '/auth/login';
      }
      if (isLoggedIn && isAuthRoute) {
        return '/hosts';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/auth/login",
        pageBuilder: (context, state) =>
            _buildPage(context, state, const LoginView()),
      ),
      GoRoute(
        path: "/auth/register",
        pageBuilder: (context, state) =>
            _buildPage(context, state, const RegisterView()),
      ),
      GoRoute(
        path: "/auth/recover",
        pageBuilder: (context, state) =>
            _buildPage(context, state, const RecoverView()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ShellView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/hosts",
                pageBuilder: (context, state) =>
                    _buildPage(context, state, const HostListView()),
                routes: [
                  GoRoute(
                    path: "create",
                    pageBuilder: (context, state) =>
                        _buildPage(context, state, const HostCreateView()),
                  ),
                  GoRoute(
                    path: ":id",
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return _buildPage(
                          context, state, HostDetailView(hostId: id));
                    },
                    routes: [
                      GoRoute(
                        path: "edit",
                        pageBuilder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return _buildPage(
                              context, state, HostEditView(hostId: id));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/keys",
                pageBuilder: (context, state) =>
                    _buildPage(context, state, const KeyListView()),
                routes: [
                  GoRoute(
                    path: "create",
                    pageBuilder: (context, state) =>
                        _buildPage(context, state, const KeyCreateView()),
                  ),
                  GoRoute(
                    path: ":id",
                    pageBuilder: (context, state) {
                      final id = state.pathParameters['id']!;
                      return _buildPage(
                          context, state, KeyDetailView(keyId: id));
                    },
                    routes: [
                      GoRoute(
                        path: "edit",
                        pageBuilder: (context, state) {
                          final id = state.pathParameters['id']!;
                          return _buildPage(
                              context, state, KeyEditView(keyId: id));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/terminal",
                pageBuilder: (context, state) =>
                    _buildPage(context, state, const TerminalView()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/settings",
                pageBuilder: (context, state) =>
                    _buildPage(context, state, const SettingsView()),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: "/sftp/:sessionId",
        pageBuilder: (context, state) {
          final sessionId = state.pathParameters['sessionId']!;
          return _buildPage(
              context, state, SftpView(sessionId: sessionId));
        },
      ),
      GoRoute(
        path: "/port-forward/:sessionId",
        pageBuilder: (context, state) {
          final sessionId = state.pathParameters['sessionId']!;
          return _buildPage(
              context, state, PortForwardView(sessionId: sessionId));
        },
      ),
    ],
  );
}
