import 'package:flutter/material.dart';
class PageViewIndicator extends StatelessWidget {
 final double marginEnd;
 final bool selected;

     PageViewIndicator({this.marginEnd=1,required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: marginEnd),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape:BoxShape.circle,
        color:selected? Colors.amber:Colors.grey,
      ),
    );
  }
}
