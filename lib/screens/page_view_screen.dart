import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/page_view_indicator.dart';
import '../widget/page_view_wedgit.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  int _currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Visibility(
            visible: _currentPage!=2,
            replacement: Container(
              alignment: AlignmentDirectional.topEnd,
              margin: EdgeInsetsDirectional.only(end: 30,top: 30),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login_screen');
                },
                child: Text(
                  AppLocalizations.of(context)!.start_now,
                  style: TextStyle(
                    color:  Color(0xffe4a972),
                  ),
                ),
              ),
            ),
            child: Container(
              alignment: AlignmentDirectional.topEnd,
              margin: EdgeInsetsDirectional.only(end: 30,top: 30),
              child: TextButton(
                onPressed: () {
                  _pageController.animateToPage(2, duration: Duration(milliseconds: 700), curve: Curves.ease);
                },
                child: Text(
                  AppLocalizations.of(context)!.skip,
                  style: TextStyle(
                    color: Color(0xffe4a972),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              children: [
                PageViewWidget(
                  title: AppLocalizations.of(context)!.title1,
                  imagePath: 'images/page1.jpg',
                ),
                PageViewWidget(
                  title: AppLocalizations.of(context)!.title2,
                  imagePath: 'images/page2.jpg',
                ),
                PageViewWidget(
                  title: AppLocalizations.of(context)!.title3,
                  imagePath: 'images/page2.jpg',
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageViewIndicator(
                  marginEnd: 7,
                  selected: _currentPage == 0,
                ),
                PageViewIndicator(
                  marginEnd: 7,
                  selected: _currentPage == 1,
                ),
                PageViewIndicator(
                  selected: _currentPage == 2,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    _pageController.animateToPage(_currentPage - 1,
                        duration: Duration(seconds: 1), curve: Curves.ease);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: _currentPage == 0 ?  Color(0xff9941d8):Color(0xffe4a972),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _pageController.animateToPage(_currentPage + 1,
                        duration: Duration(seconds: 1), curve: Curves.ease);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: _currentPage == 2 ? Color(0xff9941d8):Color(0xffe4a972),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _currentPage == 2,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login_screen');
                },
                child: Text(
                  AppLocalizations.of(context)!.start_now,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary:Color(0xff9941d8),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
