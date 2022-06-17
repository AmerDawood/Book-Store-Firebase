import 'package:book_store/constance/my_color.dart';
import 'package:book_store/screens/cart_screen.dart';
import 'package:book_store/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../model/bn_screen.dart';
import 'home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AppScreen extends StatefulWidget{
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  late int _currentIndex = 0;
  final List<BnScreen> _bnScreen = <BnScreen>[
    BnScreen(widget: HomeScreen(), title: 'Book'),
    BnScreen(widget: CartScreen(), title: 'Shop'),
    BnScreen(widget: ProfileScreen(), title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
          currentIndex: _currentIndex,
        selectedIconTheme: IconThemeData(color: Colors.black),

        selectedItemColor: accentColor,
        unselectedItemColor: Colors.grey[400],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.book),
            activeIcon: Icon(Iconsax.book, color: accentColor),
            label: AppLocalizations.of(context)!.bn_book,
            tooltip: AppLocalizations.of(context)!.bn_book_details,
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.shopping_cart),
            activeIcon: Icon(Iconsax.shopping_cart, color: accentColor),
            label: AppLocalizations.of(context)!.bn_card,
            tooltip: AppLocalizations.of(context)!.bn_cart_details,
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle),
            activeIcon: Icon(Iconsax.personalcard, color: accentColor),
            label: AppLocalizations.of(context)!.bn_page,
            tooltip: AppLocalizations.of(context)!.bn_page_details,
          ),
        ],
      ),
      body: _bnScreen[_currentIndex].widget,
    );

  }


}

