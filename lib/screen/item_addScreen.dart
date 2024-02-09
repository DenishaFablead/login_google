import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_google/screen/pre_viewInvoiceScreen.dart';

import '../Utils/custome_textfiled.dart';
import '../Utils/text.dart';
import '../controller/invoiceController.dart';

class item_addScreen extends StatefulWidget {
  const item_addScreen({super.key});

  @override
  State<item_addScreen> createState() => _item_addScreenState();
}

class _item_addScreenState extends State<item_addScreen> {
  final InvoiceController controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Data',  style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              font_(font: "Item Name",color: Colors.black,fontsize: Get.width/26),
              SizedBox(height: 5),
              custome_textfield(Controlle: controller.itemNameController,icon:Icons.person,text: "Enter Item Name")
              ,
              SizedBox(height: 10.0),
              font_(font: "Item Quantity",color: Colors.black,fontsize: Get.width/26),
              SizedBox(height: 5),
              custome_textfield(Controlle: controller.itemQuantityController,icon:Icons.person,text: "Enter Item Quantity")
              ,
              SizedBox(height: 10.0),
              font_(font: "Item price",color: Colors.black,fontsize: Get.width/26),
              SizedBox(height: 5),
              custome_textfield(Controlle: controller.itemPriceController,icon:Icons.person,text: "Enter Item Price"),
              SizedBox(height: 20.0),
              InkWell(
                onTap:  () {
                  Get.to(pre_viewInvoiceScreen());
                },
                child: Center(child:
                Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Genreat Invoice",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900
                    )),
                  ),
                ),),
              ),
              ElevatedButton(
                onPressed: controller.addItem,
                child: Text('Add Item'),
              ),
              Obx(() => DataTable(
                columns: [
                  DataColumn(label: Text('Item')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Total')),
                ],
                rows: controller.items.map((item) {
                  double totalForItem = item.price * item.quantity;
                  return DataRow(
                    cells: [
                      DataCell(Text(item.name)),
                      DataCell(Text('\$${item.price.toStringAsFixed(2)}')),
                      DataCell(Text(item.quantity.toString())),
                      DataCell(Text('\$${totalForItem.toStringAsFixed(2)}')),
                    ],
                  );
                }).toList(),
              )),
              SizedBox(height: 20.0),
              Obx(() => Text(
                'Total: \$${controller.calculateTotal().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              )),
        
            ],
          ),
        ),
      ),
    );
  }
}
