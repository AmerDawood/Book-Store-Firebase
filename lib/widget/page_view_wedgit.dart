import 'package:flutter/material.dart';
class PageViewWidget extends StatelessWidget {
  final String title;
  final String imagePath;


  PageViewWidget({required this.title,required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 200,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(50),
          //   color: Colors.amber,
          // ),
          child: Image.asset(imagePath),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),

      ],
    );
  }
}
