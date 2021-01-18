import 'package:flutter/material.dart';
class TopBarSelectors extends StatelessWidget {
  final Function onPressed;
  final bool colorCondition;
  final IconData iconData;
  TopBarSelectors(
      {@required this.onPressed,
        @required this.colorCondition,
        @required this.iconData});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: CircleBorder(),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: colorCondition
            ? BoxDecoration(
            color: Color(0xffEEEEEE),
            borderRadius: BorderRadius.circular(20))
            : null,
        child: Icon(
          iconData,
          color: colorCondition ? Color(0xff222831) : Color(0xffEEEEEE),
        ),
      ),
    );
  }
}