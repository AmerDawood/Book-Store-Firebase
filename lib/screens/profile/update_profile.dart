import 'package:book_store/utility/helpers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constance/my_color.dart';
import '../../fb_controller/firestore_controller.dart';
import '../../model/user_model.dart';
import '../../shared_preferences/user_preferences_controler.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> with Helpers {
  //
  // late TextEditingController _usernameTextController;
  // late TextEditingController _emailTextController;
  //
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _usernameTextController = TextEditingController();
  //   _emailTextController = TextEditingController();
  //   _usernameTextController.text =
  //       UserPreferenceController().userInformation.name;
  //   _emailTextController.text =
  //       UserPreferenceController().userInformation.email;
  //
  //
  // }
  //
  // @override
  // void dispose() {
  //   _usernameTextController.dispose();
  //   _emailTextController.dispose();
  //
  //   super.dispose();
  // }

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
            },
              icon: Icon(Iconsax.back_square,color: Colors.black45,),
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 70,),

              Container(
                color: Colors.grey.shade200,
                child: TextField(

                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Email',
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                color: Colors.grey.shade200,
                child: TextField(

                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Email',
                  ),
                ),
              ),

              SizedBox(height: 30,),

              ElevatedButton(
                // async => await performUpdateUserInformation(),
                onPressed: (){},
                child: Text('Update Now'),
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
  // bool checkData() {
  //   if (checkIsNotEmpty()) {
  //     return true;
  //   }
  //   showSnackBar(
  //       context: context, message: 'Enter required data', error: true);
  //   return false;
  // }
  //
  //
  //
  // bool checkIsNotEmpty() {
  //   if (_usernameTextController.text.isNotEmpty && _emailTextController.text.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }
  //
  // Future<void> updateUserInformation() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) => const Center(
  //         child: CircularProgressIndicator(
  //           color: accentColor,
  //         ),
  //       ));
  //
  //   bool status = await FbFireStoreController()
  //       .updateUser(context: context,  user: await readData());
  //   Navigator.pop(context);
  //   if (status) {
  //
  //     showSnackBar(context: context, message: 'Update Profile Successfully');
  //   } else {
  //     showSnackBar(
  //         context: context, message: 'Update Profile Failed', error: true);
  //   }
  // }
  //
  //
  // Future<Users> readData() async {
  //   Users user = Users();
  //   user.name = _usernameTextController.text;
  //   user.email = _emailTextController.text;
  //   user.id = UserPreferenceController().userInformation.id;
  //
  //   return user;
  // }
  //
  //
}
