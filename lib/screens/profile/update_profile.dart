import 'package:book_store/utility/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../fb_controller/firestore_controller.dart';
import '../../model/user_model.dart';
import '../../shared_preferences/user_preferences_controler.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> with Helpers {



 late TextEditingController _usernameTextController;
 late TextEditingController _emailTextController  ;





  @override
  void initState() {
    super.initState();
     // getUserData();
     _usernameTextController = TextEditingController();
     _emailTextController  =TextEditingController();

    _usernameTextController.text=UserPreferenceController().name;
    _emailTextController.text=UserPreferenceController().email;

  }

  @override
  void dispose() {
    _usernameTextController.dispose();
    _emailTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/app_screen');
              },
              icon: Icon(
                Iconsax.back_square,
                color: Colors.black45,
              ),
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
                  onPressed: () {},
                ),
    const SizedBox(width: 10.0),
    Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Icon(Iconsax.notification, color: Colors.black45),)
              ],
            ),
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            SizedBox(height: 10),
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
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _emailTextController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'example@gmail.com',
                  iconColor: Colors.black,
                  prefixIcon: Icon(Icons.email),
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _usernameTextController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      color: Colors.black.withOpacity(0.1),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'your name',
                  iconColor: Colors.black,
                  prefixIcon: Icon(Iconsax.text),
                  labelStyle: TextStyle(
                    fontSize: 20,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ElevatedButton(
              // async => await performUpdateUserInformation(),
              onPressed: () {
                print(UserPreferenceController().name);
              },
              child: Text('Update Now'),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> performUpdateUserInformation() async {
  //   if (checkData()) {
  //     await updateUserInformation();
  //   }
  // }
  //
  // //
  // bool checkData() {
  //   if (checkEmail()) {
  //     return true;
  //   }
  //   showSnackBar(context: context, message: 'Enter required data', error: true);
  //   return false;
  // }
  //
  // bool checkEmail() {
  //   if (_emailTextController.text.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }
  //
  // bool checkName() {
  //   if (_usernameTextController.text.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }

  // Future<void> updateUserInformation() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) => Center(
  //             child: LoadingAnimationWidget.staggeredDotsWave(
  //               color: Colors.black,
  //               size: 25,
  //             ),
  //           ));
  //
  //   bool status = await FbFireStoreController()
  //       .updateUser(context: context, user: await readData());
  //   Navigator.pop(context);
  //   if (status) {
  //     showSnackBar(context: context, message: 'Update Profile Successfully');
  //   } else {
  //     showSnackBar(
  //         context: context, message: 'Update Profile Failed', error: true);
  //   }
  // }
  //
  // Future<Users> readData() async {
  //   Users user = Users();
  //   user.name = _usernameTextController.text;
  //   user.email = _emailTextController.text;
  //   user.id = UserPreferenceController().userInformation.id;
  //
  //   return user;
  // }
}
