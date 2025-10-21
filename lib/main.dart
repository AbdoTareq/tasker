import 'package:flutter/foundation.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'core/injection_container.dart' as di;
import 'export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    GetStorage.init(),
    di.init(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  ]);
  getInitialLanguage();
  runApp(
    RequestsInspector(
      navigatorKey: null,
      enabled: kDebugMode,
      showInspectorOn: ShowInspectorOn.LongPress,
      child: TranslationProvider(child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  static ValueNotifier<bool> isDark =
      ValueNotifier<bool>(GetStorage().read(kTheme) ?? false);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(baseWidth, baseHeight),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return ValueListenableBuilder<bool>(
            valueListenable: isDark,
            builder: (context, value, child) {
              return MaterialApp.router(
                supportedLocales: AppLocaleUtils.supportedLocales,
                locale: TranslationProvider.of(context).flutterLocale,
                theme: decideOnTheme(lightTheme, darkTheme),
                debugShowCheckedModeBanner: false,
                routerConfig: AppRouter.routes,
              );
            },
          );
        });
  }
}
