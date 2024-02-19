import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_google/screen/pre_viewInvoiceScreen.dart';

import '../Utils/custome_textfiled.dart';
import '../Utils/text.dart';
import '../controller/invoiceController.dart';
import 'package:signature/signature.dart'; // Import the signature package

class item_addScreen extends StatefulWidget {
  const item_addScreen({super.key, required this.signatureData});
 final Uint8List signatureData;
  @override
  State<item_addScreen> createState() => _item_addScreenState();
}

class _item_addScreenState extends State<item_addScreen> {
  final InvoiceController controller = Get.put(InvoiceController());
  bool adddata = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Item Data',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              font_(
                font: "Item Name",
                color: Colors.black,
                fontsize: Get.width / 26,
              ),
              SizedBox(height: 5),
              custome_textfield(
                  Controlle: controller.itemNameController,
                  icon: Icons.person,
                  text: "Enter Item Name",
                  keyboardType: TextInputType.name),
              SizedBox(height: 10.0),
              font_(
                  font: "Item Quantity",
                  color: Colors.black,
                  fontsize: Get.width / 26),
              SizedBox(height: 5),
              custome_textfield(
                  Controlle: controller.itemQuantityController,
                  icon: Icons.person,
                  text: "Enter Item Quantity",
                  keyboardType: TextInputType.number),
              SizedBox(height: 10.0),
              font_(
                  font: "Item price",
                  color: Colors.black,
                  fontsize: Get.width / 26),
              SizedBox(height: 5),
              custome_textfield(
                  Controlle: controller.itemPriceController,
                  icon: Icons.person,
                  text: "Enter Item Price",
                  keyboardType: TextInputType.number),
              SizedBox(height: 20.0),
              SizedBox(
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: controller.addItem,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Add more ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(pre_viewInvoiceScreen(signatureData:widget.signatureData!));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Genreat Invoice",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900)),
                        ),
                      ),
                    ),
                  ],
                ),
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
                          DataCell(
                              Text('\$${totalForItem.toStringAsFixed(2)}')),
                        ],
                      );
                    }).toList(),
                  )),
              SizedBox(height: 20.0),
              // Obx(() => Text(
              //   'Total: \$${controller.calculateTotal().toStringAsFixed(2)}',
              //   style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              // )),
            ],
          ),
        ),
      ),
    );
  }
}

class SignatureFormPage extends StatefulWidget {
  @override
  _SignatureFormPageState createState() => _SignatureFormPageState();
}

class _SignatureFormPageState extends State<SignatureFormPage> {
  final SignatureController _controller = SignatureController(
    // Set signature parameters like pen color, pen thickness, etc.
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature Form'),
      ),
      body: Column(
        children: [
          // Signature Pad Widget
          Signature(
            controller: _controller,
            height: 300,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 20),
          // Save Button to Navigate to Next Page
          Row(
            children: [
              InkWell(
                onTap: () async {
                      final Uint8List? signatureData = await _controller.toPngBytes();
                  // // Navigate to the next page and pass the signature data
                  // Get.to(NextPage(signatureData: signatureData!));
              
                  Get.to(item_addScreen(signatureData: signatureData!));
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Save and Continue",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w900)),
                    ),
                  ),
                ),
              ),
InkWell(
            onTap: () async {
        _controller.clear();
              // // Navigate to the next page and pass the signature data
              // Get.to(NextPage(signatureData: signatureData!));

             
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.2),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("clean",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900)),
              ),
            ),
          ),
            ],
          ),
           
        ],
      ),
    );
  }
}

// NextPage class to display the captured signature
class NextPage extends StatelessWidget {
  final Uint8List signatureData;

  NextPage({required this.signatureData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the captured signature
            Image.memory(signatureData),
            SizedBox(height: 20),
            // Add other widgets or functionality as needed
            Text('Signature Captured!'),
          ],
        ),
      ),
    );
  }
}
