import 'package:book_store/provider/change_language_notifire.dart';
import 'package:book_store/provider/new_product_provider.dart';
import 'package:book_store/provider/product_provider.dart';
import 'package:book_store/screens/app.dart';
import 'package:book_store/screens/auth/login_screen.dart';
import 'package:book_store/screens/auth/register_screen.dart';
import 'package:book_store/screens/auth/reset_password.dart';
import 'package:book_store/screens/details_screen.dart';
import 'package:book_store/screens/home_screen.dart';
import 'package:book_store/screens/launch_screen.dart';
import 'package:book_store/screens/products_screen.dart';
import 'package:book_store/screens/profile/profile_screen.dart';
import 'package:book_store/screens/profile/update_profile.dart';
import 'package:book_store/screens/settings_screen.dart';
import 'package:book_store/shared_preferences/app_preferences_controller.dart';
import 'package:book_store/shared_preferences/user_preferences_controler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferenceController().initSharedPreference();
  await AppSettingsPreferances().initPreferances();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
            create: (_) => ProductProvider()),
        ChangeNotifierProvider<NewProductProvider>(
            create: (_) => NewProductProvider()),
        ChangeNotifierProvider<ChangeLanguageNotifier>(
            create: (_) => ChangeLanguageNotifier()),
      ],
      child: const MainMaterialApp(),
    );
  }
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(Provider.of<ChangeLanguageNotifier>(context).languageCode),
      // locale: Locale('en'),
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/login_screen': (context) => LoginScreen(),
        '/register_screen': (context) => RegisterScreen(),
        '/reset_password': (context) => ResetPassword(),
        '/product_screen': (context) => ProductsScreen(),
        '/home_screen': (context) => HomeScreen(),
        '/details_screen': (context) => DetailScreen(),
        '/app_screen': (context) => AppScreen(),
        '/setting_screen': (context) => SettingScreen(),
        '/profile_screen': (context) => ProfileScreen(),
        '/update_profile': (context) => UpdateProfile(),
      },
    );
  }
}
