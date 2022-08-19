import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:kittys_tavern/src/classes/theme.dart';
import 'package:kittys_tavern/src/menu/menu_item.dart';
import 'package:kittys_tavern/src/menu/menu_view.dart';
import 'package:kittys_tavern/src/models/bar_item.dart';
import 'package:kittys_tavern/src/models/drink.dart';
import 'package:kittys_tavern/src/models/shot.dart';
import 'package:kittys_tavern/src/splash%20screen/splash_screen.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  final SettingsController settingsController;

  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  static _AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppWidget>()!.appData;
  }

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<MyApp> {
  bool _hasLoaded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: appLightTheme,
          darkTheme: appDarkTheme,
          themeMode: widget.settingsController.themeMode,
          navigatorKey: Get.key,
          onGenerateRoute: (RouteSettings routeSettings) {
            BarItem item = (routeSettings.arguments == null)
                ? const Drink(
                    id: -1,
                    imgPath: '',
                    name: 'unknown',
                    desc: '',
                    ingredients: [],
                  )
                : _deserializeArgument(routeSettings.arguments);

            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                if (!_hasLoaded) {
                  print('Defaulting to load on route: ${routeSettings.name}');
                  _hasLoaded = true;
                  return const SplashScreen();
                } else {
                  print('bypassing default: ${routeSettings.name}');
                }

                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: widget.settingsController);
                  case MenuView.routeName:
                    return const MenuView();
                  case MenuItem.routeName:
                    return MenuItem(
                      item: item,
                    );
                  default:
                    return const SplashScreen();
                }
              },
            );
          },
        );
      },
    );
  }

  // Use this sparingly.  It was introduced as a means to update the UI language.
  // It really SHOULD NOT be used elsewhere.
  void refreshApp() {
    setState(() {});
  }

  BarItem _deserializeArgument(Object? argument) {
    Map<String, dynamic> args = argument as Map<String, dynamic>;

    if (args.containsKey('desc')) {
      return Drink.fromJson(args);
    } else {
      return Shot.fromJson(args);
    }
  }
}

class AppWidget extends InheritedWidget {
  final _AppState appData;

  const AppWidget({
    Key? key,
    required Widget child,
    required this.appData,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(AppWidget oldWidget) {
    return true;
  }
}
