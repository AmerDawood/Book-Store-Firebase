import 'package:book_store/screens/auth/login_screen.dart';
import 'package:book_store/utility/helpers.dart';
import 'package:flutter/material.dart';
import '../../fb_controller/fb_auth_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();

}

class _ResetPasswordState extends State<ResetPassword> with Helpers {

  late TextEditingController _emailEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: AppLocalizations.of(context)!.email,
                  labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 20.0),

              GestureDetector(
                onTap: ()async =>await performReset(),
                child: Container(
                    height: 60.0,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFF653bbf),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: Center(
                      child: Text(AppLocalizations.of(context)!.reset, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15.0)),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Reset Password
  Future<void> performReset() async {
    if (checkData()) {
      await ResetPassword();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty ) {
      return true;
    }
    return false;
  }

  Future<void> ResetPassword() async {
    bool states = await FbAuthController().resetPassword(
      context: context,
      email: _emailEditingController.text,
    );
    if (states) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          }
      ),

      );
    } else {
      showSnackBar(context: context, message: 'SOMETHING ERROR',error: true);
    }
  }
}