import 'package:flutter/material.dart';
import 'package:gourmet_mobile/screen/home_screen.dart';
import 'package:gourmet_mobile/screen/login_screen.dart';
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';
import 'provider/network_provider.dart';
import 'screen/produto_screen.dart';
import 'screen/settings_screen.dart';
import 'util/app_route.dart';

void main() {
  runApp(MyApp());
}

bool themeDataLight = true;

final int primarySwatch = 0xFFB26145;
final int accentColor = 0xFF6B3525;

final int primarySwatchDark = 0xFF673A29;
final int accentColorDark = 0xFFd46838;

Map<int, Color> generateColor(int colorCode) {
  return {
    50: Color(colorCode).withOpacity(0.1),
    100: Color(colorCode).withOpacity(0.2),
    200: Color(colorCode).withOpacity(0.3),
    300: Color(colorCode).withOpacity(0.4),
    400: Color(colorCode).withOpacity(0.5),
    500: Color(colorCode).withOpacity(0.6),
    600: Color(colorCode).withOpacity(0.7),
    700: Color(colorCode).withOpacity(0.8),
    800: Color(colorCode).withOpacity(0.9),
    900: Color(colorCode).withOpacity(1),
  };
}

ThemeData lightThemeData = ThemeData(
  primarySwatch: MaterialColor(primarySwatch, generateColor(primarySwatch)),
  accentColor: MaterialColor(accentColor, generateColor(accentColor)),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.light,
);

ThemeData darkThemeData = ThemeData(
  primarySwatch: MaterialColor(primarySwatchDark, generateColor(primarySwatchDark)),
  accentColor: MaterialColor(accentColorDark, generateColor(accentColorDark)),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NetworkProvider(),
        ),
      ],
      child: Consumer<AppProvider>(
        builder: (ctx, appProvider, _) => MaterialApp(
          title: 'Gourmet Mobile',
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: appProvider.lightTheme ? ThemeMode.light : ThemeMode.dark,
          routes: {
            AppRoute.LOGIN: (ctx) => LoginScreen(),
            AppRoute.HOME: (ctx) => HomeScreen(),
            AppRoute.SETTINGS: (ctx) => SettingsScreen(),
            AppRoute.PRODUTO: (ctx) => ProdutoScreen(),
          },
          home: LoginScreen(),
        ),
      ),
    );
  }
}
