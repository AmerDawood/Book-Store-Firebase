import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../provider/change_language_notifire.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: (){
              Navigator.pushReplacementNamed(context, '/app_screen');
            }, icon: Icon(Iconsax.back_square,color: Colors.black45,),
            );
          },
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 23.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Iconsax.heart, color: Colors.black45),
                  onPressed: (){

                  },
                ),
                const SizedBox(width: 15.0),
                Icon(Iconsax.notification, color: Colors.black45),
              ],
            ),
          ),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Locale currentLanguage =Localizations.localeOf(context);
          // String newLocal=  currentLanguage.languageCode=='en'?'ar':'en';
          String newLocal =
          Provider.of<ChangeLanguageNotifier>(context, listen: false)
              .languageCode ==
              'en'
              ? 'ar'
              : 'en';
          Provider.of<ChangeLanguageNotifier>(context, listen: false)
              .changeLanguage(languageCode: newLocal);
        },
        child: Icon(
          Icons.language,
          color: Colors.white,
        ),
      ),

    );
  }


}