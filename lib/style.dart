// 기본 위젯 사용하기 위해 필요
import 'package:flutter/material.dart';

var theme = ThemeData(
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 1, // 그림자
        titleTextStyle: TextStyle( color: Colors.black, fontSize: 25),
        actionsIconTheme: IconThemeData( color: Colors.black, size: 40 )
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.black
    ),

);

var tmpTheme = ThemeData(
    // button 스타일
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: Colors.purple
        )
    ),
    // elevatedButtonTheme: 똑같이 하면 됨,

    iconTheme: IconThemeData( color: Colors.black ),
    appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 1, // 그림자
        titleTextStyle: TextStyle( color: Colors.black, fontSize: 25),
        actionsIconTheme: IconThemeData( color: Colors.black, size: 40 )
    ),
    textTheme: TextTheme(
      // ignore: deprecated_member_use
        bodyText2: TextStyle(color: Colors.red),
        bodyText1: TextStyle(color: Colors.pink),
    ),

);
