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

               font_(font: "Customer  Name",color: Colors.black,fontsize: Get.width/26),
             SizedBox(height: 5),
             custome_textfield(Controlle: controller.customerNameController,icon:Icons.person,text: "Enter your name ")
          ,    SizedBox(height: 10.0),
              font_(font: "Customer  Number",color: Colors.black,fontsize: Get.width/26),
              SizedBox(height: 5),
              custome_textfield(Controlle: controller.customerNumberController,icon:Icons.person,text: "Enter Number")
              ,    SizedBox(height: 10.0),
              font_(font: "Customer  Address",color: Colors.black,fontsize: Get.width/26),
              SizedBox(height: 5),
              custome_textfield(Controlle: controller.customerAddrController,icon:Icons.person,text: "Enter ADDRESS")
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
                  Get.to(item_addScreen());
                },
                child: Center(child:
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Item Add",style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900
                    )),
                  ),
                ),),
              ),
              //   Center(
              //   child: ElevatedButton(
              //     onPressed: () {
              //       Get.to(item_addScreen());
              //     },
              //     child: Text('Item Add '),
              //   ),
              // ),
              // SizedBox(height: 20.0),
              //
              // ElevatedButton(
              //   onPressed: controller.addItem,
              //   child: Text('Add Item'),
              // ),
              // SizedBox(height: 20.0),
              // Obx(() => DataTable(
              //       columns: [
              //         DataColumn(label: Text('Item')),
              //         DataColumn(label: Text('Price')),
              //       ],
              //       rows: controller.items
              //           .map(
              //             (item) => DataRow(
              //               cells: [
              //                 DataCell(Text(item.name)),
              //                 DataCell(Text('\$${item.price.toStringAsFixed(2)}')),
              //               ],
              //             ),
              //           )
              //           .toList(),
              //     )),
              // SizedBox(height: 20.0),
              // Obx(() => Text(
              //       'Total: \$${controller.calculateTotal().toStringAsFixed(2)}',
              //       style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
