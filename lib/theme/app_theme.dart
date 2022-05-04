import 'package:flutter/material.dart';

class AppTheme {

  static Color primary = Colors.indigo;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // Color Primario
    primaryColor: Colors.indigo,
    //AppBar Theme
    appBarTheme: AppBarTheme(
      color: primary,
      elevation: 0
    ),
    //TextButton Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom( primary: primary )
    ),
    //FloatingActionButton
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      elevation: 5
    ),
    //ElevatedButtons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: const StadiumBorder(),
        elevation: 0
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle( color: primary ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primary
        ),
        borderRadius: const BorderRadius.only( 
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10)
         )
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: primary
        ),
        borderRadius: const BorderRadius.only( 
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
      ),

      border: const OutlineInputBorder(
        borderRadius: BorderRadius.only( 
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
      )
    )
  );

    static final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Color Primario
    primaryColor: Colors.indigo,
    //AppBar Theme
    appBarTheme: AppBarTheme(
      color: primary,
      elevation: 0
    ),
    scaffoldBackgroundColor: Colors.black
  );
}