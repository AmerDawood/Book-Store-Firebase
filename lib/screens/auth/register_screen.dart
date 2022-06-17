import 'package:book_store/screens/app.dart';
import 'package:book_store/screens/auth/login_screen.dart';
import 'package:book_store/utility/helpers.dart';
import 'package:flutter/material.dart';
import '../../fb_controller/fb_auth_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _nameEditingController;
  late TextEditingController _confirmPasswordEditingController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _nameEditingController = TextEditingController();
    _confirmPasswordEditingController = TextEditingController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _nameEditingController.dispose();
    _confirmPasswordEditingController.dispose();

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
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/login_screen');
          },
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title: Text(AppLocalizations.of(context)!.register,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: AppLocalizations.of(context)!.f_name,
                  labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 20.0),
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
              const SizedBox(height: 20.0),
              TextField(
                controller: _confirmPasswordEditingController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  labelText: AppLocalizations.of(context)!.confirm_password,
                  labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14.0),
                ),
              ),
              const SizedBox(height: 40.0),
              GestureDetector(
                onTap: () async => await Regiser(),
                child: Container(
                    height: 60.0,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFF653bbf),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: Center(
                      child: Text(AppLocalizations.of(context)!.register, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15.0)),
                    ),
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Regiser() async {
    bool states = await FbAuthController().createAccount(
      context: context,
      email: _emailEditingController.text,
      password: _passwordEditingController.text,
      name: _nameEditingController.text,

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
