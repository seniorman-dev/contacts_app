import 'package:contact_app/data/contact_model.dart';
import 'package:contact_app/screens/splash_screen.dart';
import 'package:contact_app/screens/home_screen.dart';
import 'package:contact_app/theme/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'theme/themes.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //initialize getstorage to get access to the storage+
  await GetStorage.init('ThemeBox'); //boolean
  await GetStorage.init('Favorite');  //boolean
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key,});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ContactModel(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes().lightTheme,
        darkTheme: Themes().darkTheme,
        themeMode: ThemeService().getThemeMode(),
        title: '',
        home: const SplashScreen(),
      )
    );
  }
}


