import 'package:book_store/fb_controller/fb_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../shared_preferences/user_preferences_controler.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // FbNotifications().requestNotificationPermissions();
    Future.delayed(Duration(seconds: 3),(){
      String routeName =UserPreferenceController().loggedIn ?'/app_screen':'/page_view_screen';
      Navigator.pushReplacementNamed(context, routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin:AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              Color(0xffe4a972),
              Color(0xff9941d8),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Padding(
             padding: const EdgeInsets.only(
               top: 20,
             ),
             child: Container(
               height: 200,
               width: 200,
               child:  Image(
                 image: AssetImage(
                   'images/lanch_book_app.png',
                 ),
               ),
             ),
           ),
            Text(
              AppLocalizations.of(context)!.app_name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}