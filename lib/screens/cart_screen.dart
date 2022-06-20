import 'package:book_store/shared_preferences/app_preferences_controller.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: Icon(Iconsax.menu,color: Colors.black45,),
            );
          },
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.cart,
        style: TextStyle(
          fontFamily: 'Cairo',
          color: Colors.black45,
        ),),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 23.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Iconsax.heart, color: Colors.black45),
                  onPressed: ()async{

                  },
                ),
                const SizedBox(width: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Iconsax.notification, color: Colors.black45),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(

      ),
    );
  }
}
