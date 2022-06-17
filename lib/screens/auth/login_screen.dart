import 'package:book_store/fb_controller/fb_auth_controller.dart';
import 'package:book_store/screens/app.dart';
import 'package:book_store/utility/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


import '../products_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {

  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();

  }


  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.login,
            style: TextStyle(
                fontSize: 25.0, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child:
          Center(child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: AppLocalizations.of(context)!.email,
                  labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _passwordEditingController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: AppLocalizations.of(context)!.password,
                  labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 40.0),
              GestureDetector(
                onTap: ()async => performLogin(),
                child: Container(
                    height: 60.0,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFF653bbf),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: Center(
                      child: Text(AppLocalizations.of(context)!.login, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15.0)),
                    )
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/register_screen');
                  },
                  child: Text(AppLocalizations.of(context)!.no_account,
                      style: TextStyle(
                          color: Color(0xFF653bbf), fontWeight: FontWeight.w600, fontSize: 16.0)),
                ),
              ),
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 80, height: 1.0, color: Colors.black12),
                  const SizedBox(width: 20.0),
                  Text(AppLocalizations.of(context)!.or,
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 12.0)),
                  const SizedBox(width: 20.0),
                  Container(width: 80, height: 1.0, color: Colors.black12),
                ],
              ),
              const SizedBox(height: 50.0),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      FbAuthController().signInWithGoogle();
                    },
                    child: Container(
                        height: 60.0,
                        width: size.width/2 - 40,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(width: 0.5, color: Colors.grey),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("images/google.png", width: 20.0),
                              const SizedBox(width: 15.0),
                              Text(AppLocalizations.of(context)!.google, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15.0)),
                            ],
                          ),
                        )
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  GestureDetector(
                    onTap: (){
                      FbAuthController().signInWithFacebook();
                    },
                    child: Container(
                        height: 60.0,
                        width: size.width/2 - 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF4267B2),
                            borderRadius: BorderRadius.all(Radius.circular(20.0))
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network("https://www.theexaminer.com/sites/theexaminer.etypegoogle7.com/files/2021-02/1200px-Facebook_Logo_%282019%29.png", width: 30.0),
                              const SizedBox(width: 15.0),
                              Text(AppLocalizations.of(context)!.facebook, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15.0)),
                            ],
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ),),
    );
  }

  // Sign In
  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> login() async {
    bool states = await FbAuthController().signIn(
      context: context,
      email: _emailEditingController.text,
      password: _passwordEditingController.text,
    );
    if (states) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return AppScreen();
        }
      ),

      );
    } else {
      showSnackBar(context: context, message: 'SOMETHING ERROR',error: true);
    }
  }
}