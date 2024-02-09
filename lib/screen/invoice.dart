import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:login_google/Utils/custome_textfiled.dart';
import '../Utils/text.dart';

class invoice_Screen extends StatefulWidget {
  const invoice_Screen({super.key});

  @override
  State<invoice_Screen> createState() => _invoice_ScreenState();
}

class _invoice_ScreenState extends State<invoice_Screen> {
  TextEditingController name=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
 body:SingleChildScrollView(

  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child:  Text("INVOICE Data")),
     font_(font: "Enter Name",color: Colors.black,fontsize: 14),
     custome_textfield(Controlle: name,icon: FontAwesomeIcons.user,text: "eneter your name ")
      ],
    ),
  ),
 ),
    );
  }
}

class InvoiceScreen extends StatelessWidget {
  final InvoiceController controller = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invoice',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
               font_(font: "Enter Name",color: Colors.black,fontsize: 14),
             custome_textfield(Controlle: controller.customerNameController,icon:Icons.person,text: "eneter your name ")
            
          ,    SizedBox(height: 20.0),
              TextField(
                controller: controller.itemNameController,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                ),
              ),
              TextField(
                controller: controller.itemPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Item Price',
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: controller.addItem,
                child: Text('Add Item'),
              ),
              SizedBox(height: 20.0),
              Obx(() => DataTable(
                    columns: [
                      DataColumn(label: Text('Item')),
                      DataColumn(label: Text('Price')),
                    ],
                    rows: controller.items
                        .map(
                          (item) => DataRow(
                            cells: [
                              DataCell(Text(item.name)),
                              DataCell(Text('\$${item.price.toStringAsFixed(2)}')),
                            ],
                          ),
                        )
                        .toList(),
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

class InvoiceController extends GetxController {
  var items = <InvoiceItem>[].obs;
    TextEditingController customerNameController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  void addItem() {
    final itemName = itemNameController.text;
    final itemPrice = double.tryParse(itemPriceController.text) ?? 0.0;

    if (itemName.isNotEmpty && itemPrice > 0) {
      items.add(InvoiceItem(name: itemName, price: itemPrice));

      itemNameController.clear();
      itemPriceController.clear();
    }
  }

  double calculateTotal() {
    return items.fold(0, (total, item) => total + item.price);
  }
}

class InvoiceItem {
  final String name;
  final double price;

  InvoiceItem({required this.name, required this.price});
}