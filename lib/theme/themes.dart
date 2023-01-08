import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';



class Themes {
  //light theme
  final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    tabBarTheme: TabBarTheme(
      //indicator: BoxDecoration(color:Colors.indigo.shade900),
      labelColor: Colors.black,
      labelStyle: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600, fontSize: 10,),
      unselectedLabelColor: Colors.grey.withOpacity(0.7),
      unselectedLabelStyle: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600, fontSize: 10,),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedLabelStyle: GoogleFonts.nunitoSans(color: Colors.tealAccent, fontSize: 12, fontWeight: FontWeight.w800),
      unselectedLabelStyle: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
      unselectedItemColor: Colors.grey.withOpacity(0.7),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey.withOpacity(0.7),
        //shadows: [BoxShadow(color: Colors.white)]
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.indigo.shade900,
      selectedIconTheme: IconThemeData(
        color: Colors.indigo.shade900,
        //shadows: [BoxShadow(color: Colors.white)]
      )
    ),
    cardTheme: CardTheme(
      shadowColor: Colors.grey,
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)  
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      //backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: GoogleFonts.comfortaa(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18,),
      iconTheme: IconThemeData(
        color: Colors.black, //white
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.tealAccent, //white
      ),
      centerTitle: true,
      titleSpacing: 4,
    ),
    iconTheme: IconThemeData(
      color: Colors.black, //indigo.shade900,
    ),
    //buttonTheme: ,
    //buttonColor: Colors.black, //black,
    primaryTextTheme: TextTheme(
      bodyText1: GoogleFonts.comfortaa(color: Colors.black)
    ),
    //textTheme: TextTheme(bodyText1: GoogleFonts.nunitoSans(color: Colors.black)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.indigo[900]
    ),
    listTileTheme: ListTileThemeData(
      tileColor: Colors.white,
      textColor: Colors.black,
      iconColor: Colors.tealAccent,
      horizontalTitleGap: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 2
        ),
      ),
      //style: ListTileStyle.
    ),
  );
  
  //dark theme
  final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.indigo[800], //black
    tabBarTheme: TabBarTheme(
      //indicator: BoxDecoration(color:Colors.white),
      labelColor: Colors.white,
      labelStyle: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600, fontSize: 10,),
      unselectedLabelColor: Colors.grey.withOpacity(0.7),
      unselectedLabelStyle: GoogleFonts.nunitoSans(fontWeight: FontWeight.w600, fontSize: 10,),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      selectedLabelStyle: GoogleFonts.nunitoSans(color: Colors.tealAccent, fontSize: 12, fontWeight: FontWeight.w800),
      unselectedLabelStyle: GoogleFonts.nunitoSans(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600),
      unselectedItemColor: Colors.grey.withOpacity(0.7),
      unselectedIconTheme: IconThemeData(
        color: Colors.grey.withOpacity(0.7),
        //shadows: [BoxShadow(color: Colors.white)]
      ),
      elevation: 0,
      selectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: Colors.white,
        //shadows: [BoxShadow(color: Colors.white)]
      )
    ),
    cardTheme: CardTheme(
      shadowColor: Colors.grey,
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)  
      ),
    ),

    appBarTheme: AppBarTheme(
      color: Colors.black, //white12
      elevation: 0,
      //backgroundColor: Colors.white30,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: GoogleFonts.comfortaa(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18,),
      iconTheme: IconThemeData(
        color: Colors.white, //white
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.tealAccent, //white
      ),
      centerTitle: true,
      titleSpacing: 4,
    ),
    iconTheme: IconThemeData(
      color: Colors.white, //white
    ),
    //buttonTheme: ,
    //buttonColor: Colors.white, //black,
    primaryTextTheme: TextTheme(
      bodyText1: GoogleFonts.comfortaa(color: Colors.white)
    ),
    //textTheme: TextTheme(bodyText1: GoogleFonts.nunitoSans(color: Colors.indigo)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.tealAccent
    ),
    listTileTheme: ListTileThemeData(
      //style: ListStyle(),
      tileColor: Colors.black, //white,
      textColor: Colors.white, //black
      iconColor: Colors.tealAccent,
      horizontalTitleGap: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.tealAccent,
          style: BorderStyle.solid,
          width: 2
        ),
      ),
      //style: ListTileStyle.
    ),
  );
}