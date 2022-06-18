import 'package:flutter/material.dart';
class PageViewWidget extends StatelessWidget {
  final String title;


  PageViewWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.amber,
          ),
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
        Text(
          'Computer Science -IUG',
          style: TextStyle(
            fontSize: 20,
            color:  Colors.grey,
          ),
        ),
      ],
    );
  }
}
