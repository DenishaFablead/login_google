import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:login_google/Utils/text.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import '../controller/invoiceController.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart' as getx;

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
                      height: Get.width / 40,
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          DataCell(
                              Text('\$${totalForItem.toStringAsFixed(2)}')),
                          // DataCell(Text('\$${controller.calculateTotal().toStringAsFixed(2)}')),
                        ],
                      );
                    }).toList(),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Obx(() => SizedBox(
                            width: Get.width / 2.4,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal',
                                    style: TextStyle(
                                        fontSize: Get.width / 26,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black.withOpacity(.5)),
                                  ),
                                  Text(
                                    '\$${controller.calculateTotal().toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: Get.width / 26,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black.withOpacity(.5)),
                                  )
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        width: Get.width / 2.4,
                        child: Divider(),
                      ),

                      Obx(() => SizedBox(
                            width: Get.width / 2.4,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total ',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$${controller.calculateTotal().toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      // Obx(() => Text(
                      //       '   Total:            \$${controller.calculateTotal().toStringAsFixed(2)}',
                      //       style: TextStyle(
                      //           fontSize: 18.0, fontWeight: FontWeight.bold),
                      //     )),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: generateAndDownloadPdf,
          child: Container(
            height: Get.height / 20,
            width: Get.width,
            decoration: BoxDecoration(color: Colors.black),
            child: Center(
                child: Text(
              "Download PDF ",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat("dd MMMM yyyy").format(date);
  }

  Future<void> generateAndDownloadPdf() async {
    final pdf = pw.Document();

    // Get the image data as Uint8List
    final Uint8List imageData =
        await _getImageAsUint8List('aassert/image/logo.png');
    final ByteData fontData =
        await rootBundle.load('aassert/font/DMSerifDisplay-Regular.ttf');
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    // Add a page to the PDF
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      // pageTheme: pw.PageTheme(
      //   theme: pw.ThemeData(

      //   )
      // ),
      margin: pw.EdgeInsets.all(10),
      build: (context) => pw.Container(
        width: double.infinity,
        height: Get.height,
        alignment: pw.Alignment.center,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: pw.Row(children: [
                pw.Expanded(
                    child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                        width: Get.height / 5,
                        height: Get.height / 5,
                        child: pw.Image(pw.MemoryImage(imageData))),
                    pw.SizedBox(
                      height: 10,
                    ),
                  ],
                )),
                pw.Expanded(
                    child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Invoice',
                      style: pw.TextStyle(
                          color: PdfColor.fromHex('#000000'),
                          fontSize: Get.width / 8,
                          font: ttf),
                    ),
                  ],
                )),
              ]),
            ),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: pw.Container(
                width: double.infinity,
                child: pw.Stack(
                  children: [
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'BILLED TO :',
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#000000'),
                            fontSize: Get.width / 16,
                            font: ttf,
                          ),
                        ),
                        pw.Text(
                          '${controller.customerNameController.text}',
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#000000'),
                            fontSize: Get.width / 24,
                          ),
                        ),
                        pw.Text(
                          '${controller.customerNumberController.text}',
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#000000'),
                            fontSize: Get.width / 24,
                          ),
                        ),
                        pw.Container(
                          width: Get.width / 2,
                          child: pw.Text(
                              "${controller.customerAddrController.text}",
                              style: pw.TextStyle(fontSize: Get.width / 24)),
                        )
                      ],
                    ),
                    pw.Positioned(
                        right: 0,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              'invoice NO : 12345',
                              style: pw.TextStyle(
                                  color: PdfColor.fromHex('#000000'),
                                  // color: Colors.black.withOpacity(.8),
                                  fontSize: Get.width / 22,
                                  font: ttf
                                  // fontFamily: 'DMSerifDisplay-Regular',
                                  // fontWeight: FontWeight.w900
                                  ),
                            ),
                            pw.Text(
                              ' ${formatDate(DateTime.now())}',
                              style: pw.TextStyle(
                                  // color: Colors.black.withOpacity(.6),
                                  color: PdfColor.fromHex('#000000'),
                                  fontSize: Get.width / 26,
                                  font: ttf
                                  // fontFamily: 'DMSerifDisplay-Regular',
                                  // fontWeight: FontWeight.w400
                                  ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 8.0),
              child: pw.Container(
                decoration: pw.BoxDecoration(
      color: PdfColor.fromHex('#FFFFFF'), // Background color of the table
    ),
                child: pw.Table(
               tableWidth: pw.TableWidth.max,
border: pw.TableBorder.all(width: 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
),
                  children: [
                    // Table header
                    pw.TableRow(
                     decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#F5F5F5'),
          ),
                      children: [
                        pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 8.0),child:     pw.Text('Item',
                            style: pw.TextStyle(
                              fontSize: Get.width / 26,
                            )), ),
                     pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 8.0),child:     pw.Text('Price',
                            style: pw.TextStyle(
                              fontSize: Get.width / 26,
                            )), ),

                               pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 8.0),child:     pw.Text('Quantity',
                            style: pw.TextStyle(
                              fontSize: Get.width / 26,
                            )), ),    
                             pw.Padding(padding: const pw.EdgeInsets.symmetric(vertical: 8.0),child:     pw.Text('Total',
                            style: pw.TextStyle(
                              fontSize: Get.width / 26,
                            )), ),
                        // pw.Text('Total',
                        //     style: pw.TextStyle(
                        //       fontSize: Get.width / 26,
                        //     )),
                      ],
                    ),
                    // Table data
                    ...controller.items.map((item) {
                      double totalForItem = item.price * item.quantity;
                      return pw.TableRow(
                        children: [
                          pw.Text(item.name),
                          pw.Text('\$${item.price.toStringAsFixed(2)}'),
                          pw.Text(item.quantity.toString()),
                          pw.Text('\$${totalForItem.toStringAsFixed(2)}'),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 10.0),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Column(
                    children: [
                      pw.SizedBox(
                        width: Get.width / 2.4,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(right: 8.0),
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Subtotal',
                                style: pw.TextStyle(
                                  fontSize: Get.width / 26,
                                  // fontWeight: FontWeight.w300,
                                  // color: Colors.black.withOpacity(.5)
                                ),
                              ),
                              pw.Text(
                                '\$${controller.calculateTotal().toStringAsFixed(2)}',
                                style: pw.TextStyle(
                                  fontSize: Get.width / 26,
                                  // fontWeight: FontWeight.w300,
                                  // color: Colors.black.withOpacity(.5)
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        width: Get.width / 2.4,
                        child: pw.Divider(),
                      ),

                      pw.SizedBox(
                        width: Get.width / 2.4,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(right: 8.0),
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Total ',
                                style: pw.TextStyle(
                                  fontSize: 18.0,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                              pw.Text(
                                '\$${controller.calculateTotal().toStringAsFixed(2)}',
                                style: pw.TextStyle(
                                  fontSize: 18.0,
                                  // fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      )

                      // Obx(() => Text(
                      //       '   Total:            \$${controller.calculateTotal().toStringAsFixed(2)}',
                      //       style: TextStyle(
                      //           fontSize: 18.0, fontWeight: FontWeight.bold),
                      //     )),
                    ],
                  )
                ],
              ),
            ),
            pw.SizedBox(height: 20.0),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8.0),
              child: pw.Text(
                'Thank you!',
                style: pw.TextStyle(
                    color: PdfColor.fromHex('#000000'),
                    fontSize: Get.width / 12,
                    // fontFamily: 'DMSerifDisplay-Regular',
                    // fontWeight: FontWeight.w900,
                    font: ttf),
              ),
            ),
            pw.SizedBox(height: 20.0),
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: pw.Container(
                width: double.infinity,
                child: pw.Stack(
                  children: [
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'PAYMENT INFORMATION',
                          style: pw.TextStyle(
                              color: PdfColor.fromHex('#000000'),
                              fontSize: Get.width / 22,
                              font: ttf
                              // fontFamily: 'DMSerifDisplay-Regular',
                              // fontWeight: FontWeight.w900
                              ),
                        ),
                        pw.Text(
                          "Briard Bank",
                          style: pw.TextStyle(fontSize: Get.width / 24),
                        ),
                        pw.Text("Account Name: Samira Hadid",
                            style: pw.TextStyle(fontSize: Get.width / 24)),
                        pw.Text("Account No.: 123-456-7890",
                            style: pw.TextStyle(fontSize: Get.width / 24)),
                        pw.Text("Pay by: 5 July 2025",
                            style: pw.TextStyle(fontSize: Get.width / 24)),
                        pw.Container(
                          width: Get.width / 2,
                          child: pw.Text(
                              "${controller.customerAddrController.text}",
                              style: pw.TextStyle(fontSize: Get.width / 24)),
                        )
                      ],
                    ),
                    pw.Positioned(
                        bottom: 20,
                        right: 0,
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.end,
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              'Samira Hadid',
                              style: pw.TextStyle(
                                color: PdfColor.fromHex('#000000'),
                                // color: Colors.black.withOpacity(.8),
                                fontSize: Get.width / 20,
                                // fontFamily: 'DMSerifDisplay-Regular',
                                // fontWeight: FontWeight.w900
                                font: ttf,
                              ),
                            ),
                            pw.Text(
                              ' Any City, ST 12345',
                              style: pw.TextStyle(
                                  color: PdfColor.fromHex('#000000'),
                                  // color: Colors.black.withOpacity(.6),
                                  fontSize: Get.width / 26,
                                  // fontFamily: 'DMSerifDisplay-Regular',
                                  // fontWeight: FontWeight.w400
                                  font: ttf),
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
    ));

    // Save the PDF to a file
    final pdfBytes = await pdf.save();
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory?.path}/invoice.pdf';
    final file = File(filePath);
    await file.writeAsBytes(pdfBytes);

    // Open the PDF file
    OpenFile.open(filePath);
  }

  Future<Uint8List> _getImageAsUint8List(String imagePath) async {
    final ByteData data = await rootBundle.load(imagePath);
    return data.buffer.asUint8List();
  }
}
