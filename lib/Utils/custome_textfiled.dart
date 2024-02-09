


import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class custome_textfield extends StatelessWidget {
   custome_textfield({super.key, this.text, this.icon, this.Controlle});
  final text;
  final IconData? icon;
  final TextEditingController? Controlle;
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 00),
      child: Container(
        height: Get.height/15,width: Get.width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextField(
        controller: Controlle,
        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 22),
        cursorColor: Colors.black,

        // cursorHeight: 20,
        decoration: InputDecoration(
            // border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
      
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon,color: Colors.black.withOpacity(.2),size: 16),
        
          ) ,

          suffixIcon: IconButton(onPressed: () {
            Controlle!.clear();
          }, icon: Icon(FontAwesomeIcons.x,color: Colors.black.withOpacity(.2),size: 18)),
            label: Text("${text}",style: TextStyle(color: Colors.black.withOpacity(.8),fontSize:16, ),)),
      ),
      ),
    );
  }
}
