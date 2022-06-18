import 'package:book_store/fb_controller/firestore_controller.dart';
import 'package:book_store/utility/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../fb_controller/fb_auth_controller.dart';
import '../../shared_preferences/user_preferences_controler.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0,left: 15),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Iconsax.edit, color: Colors.black45),
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, '/update_profile');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body:
      SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/user.jpg"),
                    backgroundColor: Colors.grey.shade300,
                  ),

                ],
              ),
            ),
            SizedBox(height: 20),
            ProfileMenu(
              text: UserPreferenceController().name,
              icon: Icon(Iconsax.text),
              press: () => {
              },
            ),
            ProfileMenu(
              text: UserPreferenceController().email,
              icon: Icon(Icons.email),
              press: () {},
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () async {},
                child: Row(
                  children: [
                    SvgPicture.asset('images/Lock.svg'),
                    SizedBox(width: 20),
                    Expanded(child: Text('*****')),
                    IconButton(
                      onPressed: () async {

                      },
                      icon: Icon(Iconsax.arrow_circle_right,color: Colors.black,),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () async {},
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Expanded(child: Text('Logout')),
                    IconButton(
                      onPressed: () async {
                        await UserPreferenceController().loggedOut();
                        await FbAuthController().signOut();
                        showSnackBar(
                            context: context, message: 'Logout Successfully');
                        Navigator.pushReplacementNamed(
                            context, '/login_screen');
                      },
                      icon: Icon(Iconsax.logout,color: Colors.red,),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            // Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
