
import 'package:flutter/material.dart';

class font_ extends StatelessWidget {
   font_({super.key,required  this.font, required this.color, required this.fontsize });
  final String font;
 Color color=Colors.black;
final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Text("${font}",style: TextStyle(
color: color,fontSize: fontsize,

    )
    );
  }
}