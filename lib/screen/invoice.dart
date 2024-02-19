import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:login_google/Utils/custome_textfiled.dart';
import 'package:login_google/screen/item_addScreen.dart';
import '../Utils/text.dart';
import '../controller/invoiceController.dart';


class InvoiceScreen extends StatelessWidget {
  final InvoiceController controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Data',  style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

               font_(font: "Customer  NAME",color: Colors.black,fontsize: Get.width/26),
             SizedBox(height: 5),
             custome_textfield(Controlle: controller.customerNameController,icon:Icons.person,text: "Enter your Name ",keyboardType: TextInputType.emailAddress)
          ,    SizedBox(height: 10.0),
               font_(font: "Customer  email",color: Colors.black,fontsize: Get.width/26),
             SizedBox(height: 5),
             custome_textfield(Controlle: controller.customerEmailController,icon:Icons.person,text: "Enter your Email ",keyboardType: TextInputType.emailAddress)
          ,    SizedBox(height: 10.0),
              font_(font: "Customer  Number",color: Colors.black,fontsize: Get.width/26),
              SizedBox(height: 5),
              custome_textfield(Controlle: controller.customerNumberController,icon:Icons.person,text: "Enter Number",keyboardType:TextInputType.number )
              ,    SizedBox(height: 10.0),
              font_(font: "Customer  Address",color: Colors.black,fontsize: Get.width/26),
              SizedBox(height: 5),
              custome_textfield(Controlle: controller.customerAddrController,icon:Icons.person,text: "Enter Address",keyboardType: TextInputType.streetAddress)
              ,    SizedBox(height: 20.0),
              // ,
              // TextField(
              //   controller: controller.itemNameController,
              //   decoration: InputDecoration(
              //     labelText: 'Item Name',
              //   ),
              // ),
              // TextField(
              //   controller: controller.itemPriceController,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     labelText: 'Item Price',
              //   ),
              // ),
              InkWell(
                onTap:  () {
                  Get.to(SignatureFormPage());
                },
                child: Center(child:
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Add Signature",style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900
                    )),
                  ),
                ),),
              ),
         
            ],
          ),
        ),
      ),
    );
  }
}
