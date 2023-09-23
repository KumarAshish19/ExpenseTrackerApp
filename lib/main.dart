import 'package:flutter/material.dart';
import 'package:expensetrackerapp/Expenses.dart';
// import 'package:flutter/services.dart';

var appcolorscheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 229, 82));

var darkcolorscheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 251, 255, 138),
  brightness: Brightness.dark,
);
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) {         //rotation lock logic
      runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: darkcolorscheme,
        cardTheme: CardTheme().copyWith(
            color: darkcolorscheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkcolorscheme.primaryContainer,
            foregroundColor: appcolorscheme.primaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: appcolorscheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: appcolorscheme.onPrimaryContainer,
          foregroundColor: appcolorscheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
            color: appcolorscheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: appcolorscheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  backgroundColor: appcolorscheme.onSecondaryContainer,
                  fontSize: 16),
            ),
      ),
      themeMode: ThemeMode.system,
      home: Expenses(),
    ),
  );
  // },);
  
}
