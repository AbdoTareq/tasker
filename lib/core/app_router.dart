import 'package:tasker/features/animated_splash/views/animated_splash_page.dart';

import '../../export.dart';

/// don't use for navigate without context
final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class AppRouter {
  /// use for navigate without context
  static final GoRouter routes = GoRouter(
      navigatorKey: navKey,
      initialLocation: Routes.animatedSplash,
      routes: [
        GoRoute(
          name: Routes.animatedSplash,
          path: Routes.animatedSplash,
          builder: (context, state) => AnimatedSplash(
            home: Routes.tasksPage,
            title: 'Tasker',
            duration: Duration.hoursPerDay,
            type: AnimatedSplashType.StaticDuration,
          ),
        ),
        GoRoute(
          name: Routes.tasksPage,
          path: Routes.tasksPage,
          builder: (context, state) => TasksPage(),
        ),
        GoRoute(
          name: Routes.saveTaskPage,
          path: Routes.saveTaskPage,
          builder: (_, state) {
            final id = state.extra;
            return SaveTaskScreen(taskId: id);
          },
        ),
      ]);
}
