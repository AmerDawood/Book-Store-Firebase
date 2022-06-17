import 'package:book_store/fb_controller/firestore_controller.dart';
import 'package:book_store/utility/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

import '../../fb_controller/fb_auth_controller.dart';
import '../../shared_preferences/user_preferences_controler.dart';

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  late double width;
  late double height;

  bool _isLoading = false;
  String email ='';
  String name='';






  void getUserData()async{
    _isLoading = true;

    try{
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').
      doc(UserPreferenceController().userInformation.id).
      get();
      if (userDoc == null){
        return;
      }else{
        setState(() {
          email = userDoc.get('email');
          name = userDoc.get('name');
        });
      }
    }catch (e){
      //
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

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
                Icon(Iconsax.edit, color: Colors.black45),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    // backgroundImage: AssetImage("assets/images/Profile Image.png"),
                    backgroundColor: Colors.grey.shade300,
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            backgroundColor: Color(0xFFF5F6F9),
                          ),
                          onPressed: () {},
                          child: Icon(
                            Iconsax.user_add,
                            color: Colors.black,
                          )),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            ProfileMenu(
              text: '$name',
              icon: Icon(Iconsax.text),
              press: () => {
              },
            ),
            ProfileMenu(
              text: '${email}',
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
                     Navigator.pushReplacementNamed(context, '/update_profile');
                      },
                      icon: Icon(Iconsax.arrow_left,color: Colors.black,),
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
