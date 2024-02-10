import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_google/Utils/text.dart';
import 'package:intl/intl.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: Row(children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: Get.height / 8.5,
                        height: Get.height / 8.5,
                        child: Image.asset("aassert/image/logo.png")),
                    SizedBox(
                      height: Get.width / 50,
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Invoice',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Get.width / 8,
                          fontFamily: 'DMSerifDisplay-Regular'),
                    ),
                  ],
                )),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Container(
                width: Get.width,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BILLED TO :',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Get.width / 16,
                              fontFamily: 'DMSerifDisplay-Regular',
                              fontWeight: FontWeight.w900),
                        ),
                        font_(
                            font: "${controller.customerNameController.text}",
                            color: Colors.black.withOpacity(.8),
                            fontsize: Get.width / 24),
                        font_(
                            font: "${controller.customerNumberController.text}",
                            color: Colors.black.withOpacity(.8),
                            fontsize: Get.width / 24),
                        Container(
                          width: Get.width / 2,
                          child: font_(
                              font: "${controller.customerAddrController.text}",
                              color: Colors.black.withOpacity(.8),
                              fontsize: Get.width / 24),
                        )
                      ],
                    ),
                    Positioned(
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'invoice NO : 12345',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.8),
                                  fontSize: Get.width / 22,
                                  fontFamily: 'DMSerifDisplay-Regular',
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              ' ${formatDate(DateTime.now())}',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.6),
                                  fontSize: Get.width / 26,
                                  fontFamily: 'DMSerifDisplay-Regular',
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 50,
            ),
            Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: DataTable(
                    dataRowHeight: Get.height / 20,
                    headingRowColor: MaterialStateColor.resolveWith((states) {
                      // You can set the color conditionally based on the state if needed
                      return Colors.grey
                          .shade100; // Change the color as per your preference
                    }),
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
                          // DataCell(Text('\$${controller.calculateTotal().toStringAsFixed(2)}')),
                        ],
                      );
                    }).toList(),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    
                  Column(
                    children: [
                       Obx(() => Text(
                            'Subtotal                \$${controller.calculateTotal().toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: Get.width / 26, fontWeight: FontWeight.w300,color: Colors.black.withOpacity(.5)),
                          )),
                      SizedBox(
                        width: Get.width /2.4,
                        child: Divider(),
                      ),
                      Obx(() => Text(
                            '   Total:            \$${controller.calculateTotal().toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          )),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(
                            'Thank you!',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width / 14,
                                fontFamily: 'DMSerifDisplay-Regular',
                                fontWeight: FontWeight.w900),
                          ),
             ),
               SizedBox(height: 20.0),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Container(
                width: Get.width,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PAYMENT INFORMATION',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Get.width / 22,
                              fontFamily: 'DMSerifDisplay-Regular',
                              fontWeight: FontWeight.w900),
                        ),
                        font_(
                            font: "Briard Bank",
                            color: Colors.black.withOpacity(.6),
                            fontsize: Get.width / 24),
                        font_(
                            font: "Account Name: Samira Hadid",
                            color: Colors.black.withOpacity(.6),
                            fontsize: Get.width / 24),
                              font_(
                            font: "Account No.: 123-456-7890",
                            color: Colors.black.withOpacity(.6),
                            fontsize: Get.width / 24),
                              font_(
                            font: "Pay by: 5 July 2025",
                            color: Colors.black.withOpacity(.6),
                            fontsize: Get.width / 24),
                        Container(
                          width: Get.width / 2,
                          child: font_(
                              font: "${controller.customerAddrController.text}",
                              color: Colors.black.withOpacity(.5),
                              fontsize: Get.width / 24),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 20,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Samira Hadid',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.8),
                                  fontSize: Get.width / 20,
                                  fontFamily: 'DMSerifDisplay-Regular',
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              ' Any City, ST 12345',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.6),
                                  fontSize: Get.width / 26,
                                  fontFamily: 'DMSerifDisplay-Regular',
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat("dd MMMM yyyy").format(date);
  }
}
