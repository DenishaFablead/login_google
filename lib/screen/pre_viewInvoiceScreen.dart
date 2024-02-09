import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_google/Utils/text.dart';

import '../controller/invoiceController.dart';


class pre_viewInvoiceScreen extends StatefulWidget {
  const pre_viewInvoiceScreen({super.key});

  @override
  State<pre_viewInvoiceScreen> createState() => _pre_viewInvoiceScreenState();
}

class _pre_viewInvoiceScreenState extends State<pre_viewInvoiceScreen> {
  final InvoiceController controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
body: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
    children :[
      Expanded(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ Container(
            width: Get.height/8.5,
            height: Get.height/8.5,
            child: Image.asset("aassert/image/logo.png")),
          SizedBox(height: Get.width/ 50,),
          Text(
            'BILLED TO :',
            style:  TextStyle(color: Colors.black,fontSize: Get.width/22,fontFamily: 'DMSerifDisplay-Regular',fontWeight: FontWeight.w900),
          ),
        font_(font: "${controller.customerNameController.text}", color: Colors.black, fontsize: 12),
          font_(font: "${controller.customerNumberController.text}", color: Colors.black, fontsize: 12),
          font_(font: "${controller.customerAddrController.text}", color: Colors.black, fontsize: 12)
        ],)),

      Expanded(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Invoice',
              style:  TextStyle(color: Colors.black,fontSize: Get.width/10,fontFamily: 'DMSerifDisplay-Regular'),
            ),

          ],),
      )),
    ]
  ),
)
  ],
),
    );
  }
}
