
import 'package:book_store/fb_controller/fb_notifications.dart';
import 'package:book_store/fb_controller/firestore_controller.dart';
import 'package:book_store/shared_preferences/user_preferences_controler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../provider/change_language_notifire.dart';
import '../widget/books_widgets.dart';
import '../widget/drawer.dart';
import '../widget/new_books_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

/// Home Screen
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with FbNotifications {
  late double width;
  late double height;


  @override
  void initState(){
    super.initState();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
  }



  @override
  Widget build(BuildContext context) {




    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;



    return Scaffold(
      drawer: MyDrawer(),

      drawerEnableOpenDragGesture: false,
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

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 23.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Iconsax.heart, color: Colors.black45),
                  onPressed: ()async{
                    print(UserPreferenceController().id);
                    print(UserPreferenceController().name);
                    print(UserPreferenceController().email);
                    // print(UserPreferenceController().id);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 23.0),
            child: Column(
              children: [
                SearchWidget(text: AppLocalizations.of(context)!.search),
                const SizedBox(height: 25.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _makeCategoryEl(AppLocalizations.of(context)!.business),
                      const SizedBox(width: 7.0),
                      _makeCategoryEl(AppLocalizations.of(context)!.programming),
                      const SizedBox(width: 7.0),
                      _makeCategoryEl(AppLocalizations.of(context)!.physics),
                      const SizedBox(width: 7.0),
                      _makeCategoryEl(AppLocalizations.of(context)!.history),
                    ],
                  ),
                ),
                const SizedBox(height: 35.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.popular,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/product_screen');
                      },
                      child: Text(
                        AppLocalizations.of(context)!.seeAll,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.lightBlue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                PopularBooks(),
                const SizedBox(height: 20.0),
                Container(
                  width: double.infinity,
                  height: 150.0,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: const [
                        Color(0xffe4a972),
                        Color(0xff9941d8),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.best_sellers,
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                NewBooksWidget(),

              ],
            ),
          ),
        ),
      ),

      // ==========================================


    );
  }
}

class SearchWidget extends StatelessWidget {
  final String text;
  SearchWidget({required this.text});

  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.grey[200]),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey),
          hintText: text,
        ),
      ),
    );
  }
}





/// in start screen
Widget _makeCategoryEl(String title) {
  return Container(
    height: 40.0,
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      color: Color(0xFFF0F2F5),
    ),
    child:Center(
      child:Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    ),
  );
}
