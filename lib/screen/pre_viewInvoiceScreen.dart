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
  const pre_viewInvoiceScreen({super.key, required this.signatureData});
  final Uint8List signatureData;
  @override
  State<pre_viewInvoiceScreen> createState() => _pre_viewInvoiceScreenState();
}

class _pre_viewInvoiceScreenState extends State<pre_viewInvoiceScreen> {
  final InvoiceController controller = Get.put(InvoiceController());
int itemNumber = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(children: [
                  Container(
                    width: Get.width / 1.9,
                    height: Get.width / 6,
                  
                    color: Colors.orangeAccent.shade700,
                  ),
                  Container(
                   width: Get.width / 2,
                    height: Get.width / 5,
                    // transform: Matrix4.skewX(-0.4),
                    color: Colors.orangeAccent.shade400,
                  ),
                  Container(
                  width: Get.width / 2.1,
                    height: Get.width / 4.5,
                    // transform: Matrix4.skewX(-0.4),
                    color: Colors.black,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'COMPNAY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Get.width / 22,
                            ),
                          ),
                          Text(
                            'COMPNAY TAGLINE HERE',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.6),
                              fontSize: Get.width / 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Invoice',
                        style: TextStyle(
                          color: Colors.orangeAccent.shade700,
                          fontSize: Get.width / 10,
                        ),
                      ),
                      Text(
                        'invoice NO : #12345',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.8),
                            fontSize: Get.width / 36,
                            fontFamily: 'DMSerifDisplay-Regular',
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Date : ${formatDate(DateTime.now())}',
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontSize: Get.width / 36,
                            fontFamily: 'DMSerifDisplay-Regular',
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )),
              ],
            ),
       

            SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: Container(
                width: Get.width,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Invoice To:',
                          style: TextStyle(
                              color: Colors.orangeAccent.shade700,
                              fontSize: Get.width / 24,
                              fontFamily: 'DMSerifDisplay-Regular',
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          '${controller.customerNameController.text}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Get.width / 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${controller.customerAddrController.text}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Get.width / 28,
                          ),
                        ),
                        Text(
                          'Phone : ${controller.customerNumberController.text}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Get.width / 28,
                          ),
                        ),
                        Text(
                          'Email : ${controller.customerEmailController.text}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Get.width / 28,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Invoice FROM:',
                              style: TextStyle(
                                  color: Colors.orangeAccent.shade700,
                                  fontSize: Get.width / 24,
                                  fontFamily: 'DMSerifDisplay-Regular',
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              'Abc ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Get.width / 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'surat,Gujrat',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width / 28,
                              ),
                            ),
                            Text(
                              'Phone : 1234567890',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width / 28,
                              ),
                            ),
                            Text(
                              'Email : abc@gmail.com',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Get.width / 28,
                              ),
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
                    showBottomBorder: false,
                    dividerThickness: .0,
                    dataRowHeight: Get.height / 20,
                    // decoration: BoxDecoration(color: Colors.black12) ,
                    border: TableBorder.all(color: Colors.white),

                    headingRowColor: MaterialStateColor.resolveWith((states) {
                      // You can set the color conditionally based on the state if needed
                      return Colors.orangeAccent
                          .shade400; // Change the color as per your preference
                    }),
                    columns: [
                     
                      DataColumn(
                          label: Text(
                        'Item',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'DMSerifDisplay-Regular',
                        ),
                      )),
                      DataColumn(
                          label: Text('Price',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'DMSerifDisplay-Regular',
                              ))),
                      DataColumn(
                          label: Text('Quantity',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'DMSerifDisplay-Regular',
                              ))),
                      DataColumn(
                          label: Text('Total',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'DMSerifDisplay-Regular',
                              ))),
                    ],
                    rows: controller.items.map((item) {
                  itemNumber ++;
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
                                        fontSize: Get.width / 28,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    '\$${controller.calculateTotal().toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: Get.width / 26,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        width: Get.width / 2.4,
                        child: Divider(),
                      ),

                      Obx(() => Container(
                            color: Colors.orangeAccent.shade400,
                            width: Get.width / 2.4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 6.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total ',
                                    style: TextStyle(
                                        fontSize: Get.width / 26,
                                        fontFamily: 'DMSerifDisplay-Regular',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '\$${controller.calculateTotal().toStringAsFixed(2)}',
                                    style: TextStyle(
                                        fontSize: Get.width / 26,
                                        color: Colors.white,
                                        fontFamily: 'DMSerifDisplay-Regular',
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
            SizedBox(
              height: Get.height / 50,
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: Container(
                width: Get.width,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Method :',
                          style: TextStyle(
                              color: Colors.orangeAccent.shade700,
                              fontSize: Get.width / 24,
                              fontFamily: 'DMSerifDisplay-Regular',
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          'Account no : 1234 5678 2345',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Get.width / 32,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Account Name : ABC',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Get.width / 28,
                          ),
                        ),
                        Text(
                          'Branch : Briard Bank',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Get.width / 28,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                    Positioned(
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: Get.height / 20,
                                  width: Get.width / 4,
                                  // color: Colors.amber,
                                  child: Image.memory(widget.signatureData)),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                height: 1,
                                width: Get.width / 3.8,
                                // color: Colors.amber,
                                color: Colors.orangeAccent.shade200,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Authorised sign',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Get.width / 32,
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Terms & Conditions : ',
                style: TextStyle(
                    fontSize: Get.width / 24,
                    fontFamily: 'DMSerifDisplay-Regular',
                    color: Colors.orangeAccent.shade700,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'A line of credit agreement, sometimes called a line of credit.',
                    style: TextStyle(
                      fontSize: Get.width / 28,
                    ),
                  ),
                     SizedBox(
                    height: 2,
                  ),
                  Text(
                    'The client  and as money is repaid, it can be. ',
                    style: TextStyle(
                      fontSize: Get.width / 28,
                    ),
                  ),
                ],
              ),
            )
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
    return DateFormat("MMMM dd yyyy").format(date);
  }

  Future<void> generateAndDownloadPdf() async {
    final pdf = pw.Document();
int itemNumber = 0 ;
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
      margin: pw.EdgeInsets.all(0),
      build: (context) => pw.Container(
        width: double.infinity,
        height: Get.height,
        alignment: pw.Alignment.center,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
           pw.Row(
              children: [
               pw. Stack(children: [
                   pw.Container(
                    width: Get.width / 1.7,
                    height: Get.width / 6,
                    // transform: Matrix4.skewX(-0.4),
                    color: PdfColor.fromHex('#FF6D00'),
                  ),
                 pw. Container(
                    width: Get.width / 1.8,
                    height: Get.width / 5,
                    // transform: Matrix4.skewX(-0.4),
                    color: PdfColor.fromHex('#FFAB40'),
                  ),
                  pw.Container(
                    width: Get.width / 1.9,
                    height: Get.width / 4.5,
                    // transform: Matrix4.skewX(-0.4),
                    color: PdfColor.fromHex('#000000'),
                    child: pw.Container(
                      child: pw.Column(
                        mainAxisAlignment:pw. MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            'COMPNAY',
                            style:pw. TextStyle(
                              color: PdfColor.fromHex(
                      '#FFFFFF'),
                              fontSize: Get.width / 22,
                            ),
                          ),
                          pw.Text(
                            'COMPNAY TAGLINE HERE',
                            style: pw.TextStyle(
                              color:  PdfColor.fromHex(
                      '#FFFFFF'),
                              fontSize: Get.width / 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
               pw. Expanded(
                    child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 16.0),
                  child:pw. Column(
                    mainAxisAlignment:pw. MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Invoice',
                        style: pw.TextStyle(
                          color:PdfColor.fromHex('#FF6D00'),
                          fontSize: Get.width / 10,
                        ),
                      ),
                    pw.  Text(
                        'invoice NO : #12345',
                        style: pw.TextStyle(
                            color: PdfColor.fromHex('#FFAB40'),
                            fontSize: Get.width / 36,
                            font: ttf,
                            fontWeight:pw. FontWeight.bold),
                      ),
                     pw.Text(
                        'Date : ${formatDate(DateTime.now())}',
                        style:pw. TextStyle(
                            color:  PdfColor.fromHex('#000000'),
                            fontSize: Get.width / 36,
                            font: ttf,
                            // fontWeight: FontWeight.w400
                            ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
       

             pw.SizedBox(height: 20),
            pw. Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: pw.Container(
                width: double.infinity,
                child:pw. Stack(
                  children: [
                   pw. Column(
                      mainAxisAlignment:pw. MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                       pw. Text(
                          'Invoice To:',
                          style: pw.TextStyle(
                              color:PdfColor.fromHex('#FF6D00'),
                              fontSize: Get.width / 24,
                             font: ttf,
                              fontWeight: pw.FontWeight.bold),
                        ),
                       pw. Text(
                          '${controller.customerNameController.text}',
                          style:pw. TextStyle(
                              color:  PdfColor.fromHex('#000000'),
                              fontSize: Get.width / 24,
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          '${controller.customerAddrController.text}',
                          style:pw. TextStyle(
                            color:  PdfColor.fromHex('#000000'),
                            fontSize: Get.width / 28,
                          ),
                        ),
                        pw.Text(
                          'Phone : ${controller.customerNumberController.text}',
                          style:pw. TextStyle(
                            color:  PdfColor.fromHex('#000000'),
                            fontSize: Get.width / 28,
                          ),
                        ),
                        pw.Text(
                          'Email : ${controller.customerEmailController.text}',
                          style: pw.TextStyle(
                            color: PdfColor.fromHex('#000000'),
                            fontSize: Get.width / 28,
                          ),
                        ),
                      ],
                    ),
                   pw. Positioned(
                        right: 0,
                        child:pw. Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Invoice FROM:',
                              style:pw. TextStyle(
                                  color: PdfColor.fromHex('#FF6D00'),
                                  fontSize: Get.width / 24,
                                  font: ttf,
                                  fontWeight: pw.FontWeight.bold),
                            ),
                           pw. Text(
                              'Abc ',
                              style: pw.TextStyle(
                                  color:  PdfColor.fromHex('#000000'),
                                  fontSize: Get.width / 24,
                                  fontWeight: pw.FontWeight.bold),
                            ),
                          pw.  Text(
                              'surat,Gujrat',
                              style:pw. TextStyle(
                                color:  PdfColor.fromHex('#000000'),
                                fontSize: Get.width / 28,
                              ),
                            ),
                           pw. Text(
                              'Phone : 1234567890',
                              style:pw. TextStyle(
                                color:  PdfColor.fromHex('#000000'),
                                fontSize: Get.width / 28,
                              ),
                            ),
                            pw.Text(
                              'Email : abc@gmail.com',
                              style: pw.TextStyle(
                                color: PdfColor.fromHex('#000000'),
                                fontSize: Get.width / 28,
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
                // decoration: pw.BoxDecoration(
                //   color: PdfColor.fromHex(
                //       '#FFFFFF'), // Background color of the table
                // ),
                child: pw.Table(
                  tableWidth: pw.TableWidth.max,
                  border:
                      pw.TableBorder.all(color: PdfColor.fromHex('#FFFFFF')),
                  children: [
                    // Table header
                    pw.TableRow(
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromHex('#F5F5Ff'),
                      ),
                      children: [
                         pw.Container(
                            alignment: pw.Alignment.center,
                            color: PdfColor.fromHex('#FFAB40'),
                            child: pw.Padding(
                          padding:
                              const pw.EdgeInsets.symmetric(vertical: 12.0),child: pw.Text('No.',
                                style: pw.TextStyle(
                                    fontSize: Get.width / 24, font: ttf,color:  PdfColor.fromHex(
                                              '#FFFFFF')))),),

                        pw.Container(
                            alignment: pw.Alignment.center,
                            color: PdfColor.fromHex('#FFAB40'),
                            child: pw.Padding(
                          padding:
                              const pw.EdgeInsets.symmetric(vertical: 12.0),child: pw.Text('Item Name ',
                                style: pw.TextStyle(
                                    fontSize: Get.width / 24, font: ttf,color:  PdfColor.fromHex(
                                              '#FFFFFF')))),),

                                                pw.Container(
                            alignment: pw.Alignment.center,
                            color: PdfColor.fromHex('#000000'),
                            child: pw.Padding(
                          padding:
                              const pw.EdgeInsets.symmetric(vertical: 12.0),child: pw.Text('Price',
                                style: pw.TextStyle(
                                    fontSize: Get.width / 24, font: ttf,color:  PdfColor.fromHex(
                                              '#FFFFFF')))),),
                 
                          pw.Container(
                            alignment: pw.Alignment.center,
                            color: PdfColor.fromHex('#000000'),
                            child: pw.Padding(
                          padding:
                              const pw.EdgeInsets.symmetric(vertical: 12.0),child: pw.Text('Quantity',
                                style: pw.TextStyle(
                                    fontSize: Get.width / 24, font: ttf,color:  PdfColor.fromHex(
                                              '#FFFFFF')))),),
                    
                          pw.Container(
                            alignment: pw.Alignment.center,
                            color: PdfColor.fromHex('#000000'),
                            child: pw.Padding(
                          padding:
                              const pw.EdgeInsets.symmetric(vertical: 12.0),child: pw.Text('Total',
                                style: pw.TextStyle(
                                    fontSize: Get.width / 24, font: ttf,color:  PdfColor.fromHex('#FFFFFF')))),),
                      
                      ],
                    ),

                    // Table data
                    ...controller.items.map((item) {
                    itemNumber++;
                      double totalForItem = item.price * item.quantity;
                      return pw.TableRow(
                        children: [
                              pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(vertical: 10.0),
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text('${itemNumber}',
                                    style: pw.TextStyle(
                                      fontSize: Get.width / 26,
                                    ))),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(vertical: 10.0),
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text('${item.name}',
                                    style: pw.TextStyle(
                                      fontSize: Get.width / 26,
                                    ))),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(vertical: 10.0),
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    '\$${item.price.toStringAsFixed(2)}',
                                    style: pw.TextStyle(
                                      fontSize: Get.width / 26,
                                    ))),
                          ),

                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(vertical: 10.0),
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text('${item.quantity.toString()}',
                                    style: pw.TextStyle(
                                      fontSize: Get.width / 26,
                                    ))),
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(vertical: 10.0),
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    '\$${totalForItem.toStringAsFixed(2)}',
                                    style: pw.TextStyle(
                                      fontSize: Get.width / 26,
                                    ))),
                          ),

                          // pw.Text('\$${totalForItem.toStringAsFixed(2)}'),
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
                        width: Get.width / 1.5,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.only(right: 8.0),
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            // mainAxisAlignment:
                            //     pw.MainAxisAlignment.spaceAround,
                            children: [
                              pw.Text(
                                'Subtotal',
                                style: pw.TextStyle(
                                    fontSize: Get.width / 26,
                                    // fontWeight: pw.FontWeight.bold,
                                    // fontWeight: FontWeight.w300,
                                    // fontBold: fontData,
                                    color: PdfColor.fromHex('#000005')),
                              ),
                              // pw.SizedBox(width: Get.width / 4),
                              pw.Expanded(
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                        '\$${controller.calculateTotal().toStringAsFixed(2)}',
                                        style: pw.TextStyle(
                                          fontSize: Get.width / 24,
                                          // fontWeight: FontWeight.w300,
                                          // color: Colors.black.withOpacity(.5)
                                        ),
                                      ),
                                    ]),
                              ),
                              pw.SizedBox(
                                width: 25,
                              )
                              //  pw. SizedBox(width: 10,)
                              //   pw.Text(
                              //     '\$${controller.calculateTotal().toStringAsFixed(2)}',
                              //     style: pw.TextStyle(
                              //       fontSize: Get.width / 24,
                              //       // fontWeight: FontWeight.w300,
                              //       // color: Colors.black.withOpacity(.5)
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        height: 5,
                      ),
                      pw.SizedBox(
                        width: Get.width / 1.5,
                        child: pw.Divider(),
                      ),
                      pw.SizedBox(
                        height: 5,
                      ),

                      pw.  Container(
                            color:PdfColor.fromHex('#FFAB40'),
                            width: 250,
                            child: pw.Padding(
                              padding: const pw. EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 6.0),
                              child:pw.Row (
                                  crossAxisAlignment:pw. CrossAxisAlignment.center,
                                mainAxisAlignment:pw.
                                    MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Total',
                                style: pw.TextStyle(
                                    fontSize: Get.width / 18,
                                    // fontWeight: pw.FontWeight.bold,
                                    // fontWeight: FontWeight.w300,
                                    // fontBold: fontData,
                                    color: PdfColor.fromHex('#ffffff'),
                                    font: ttf),
                              ),
                              pw.Expanded(
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                        '\$${controller.calculateTotal().toStringAsFixed(2)}',
                                        style: pw.TextStyle(
                                            fontSize: Get.width / 18,
                                            // fontWeight: FontWeight.w300,
                                          color: PdfColor.fromHex('#ffffff'),
                                            font: ttf),
                                      ),
                                    ]),
                              ),
                              pw.SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        ),
                      ),
         
                    ],
                  )
                ],
              ),
            ),
            pw.SizedBox(height: 20.0),
          
           pw. Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child:pw. Container(
                width: double.infinity,
                child:pw. Stack(
                  children: [
                    pw.Column(
                      mainAxisAlignment:pw. MainAxisAlignment.start,
                      crossAxisAlignment: pw. CrossAxisAlignment.start,
                      children: [
                     pw.   Text(
                          'Payment Method :',
                          style:pw. TextStyle(
                              color: PdfColor.fromHex('#FF6D00'),
                              fontSize: Get.width / 24,
                              font: ttf,
                              fontWeight:pw. FontWeight.bold),
                        ),
                       pw. Text(
                          'Account no : 1234 5678 2345',
                          style:pw. TextStyle(
                              color:  PdfColor.fromHex('#000000'),
                              fontSize: Get.width / 32,
                              fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          'Account Name : ABC',
                          style: pw.TextStyle(
                            color:PdfColor.fromHex('#000000'),
                            fontSize: Get.width / 28,
                          ),
                        ),
                       pw. Text(
                          'Branch : Briard Bank',
                          style:pw. TextStyle(
                            color:PdfColor.fromHex('#000000'),
                            fontSize: Get.width / 28,
                          ),
                        ),
                       pw. SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                    pw.Positioned(
                        right: 0,
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(8.0),
                          child:pw. Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment:pw. CrossAxisAlignment.center,
                            children: [
                              pw.Container(
                                  height: Get.height / 20,
                                  width: Get.width / 4,
                                  // color: Colors.amber,
                                  child: pw.Image(pw.MemoryImage(widget.signatureData))
                                  
                                  ),
                              pw.SizedBox(
                                height: 4,
                              ),
                             pw. Container(
                                height: 1,
                                width: Get.width / 3.8,
                                // color: Colors.amber,
                                color: PdfColor.fromHex('#FF6D00'),
                              ),
                             pw. SizedBox(
                                height: 2,
                              ),
                             pw. Text(
                                'Authorised sign',
                                style: pw.TextStyle(
                                  color: PdfColor.fromHex('#000000'),
                                  fontSize: Get.width / 32,
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
           pw. SizedBox(height: 20.0),
          pw. Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 15.0),
              child:pw. Text(
                'Terms & Conditions : ',
                style:pw. TextStyle(
                    fontSize: Get.width / 24,
                    font: ttf,
                    color:PdfColor.fromHex('#FF6D00'),
                    fontWeight: pw.FontWeight.bold),
              ),
            ),
      
            // pw.SizedBox(height: 20.0),
          pw. Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 15.0),
              child: pw.Column(
                mainAxisAlignment:pw. MainAxisAlignment.start,
                crossAxisAlignment:pw. CrossAxisAlignment.start,
                children: [
                //  pw. SizedBox(
                //     height: 5,
                //   ),
                 pw. Text(
                    'A line of credit agreement, sometimes called a line of credit.',
                    style:pw. TextStyle(
                      fontSize: Get.width / 28,
                    ),
                  ),
                    pw. SizedBox(
                    height: 2,
                  ),
                pw.  Text(
                    'The client  and as money is repaid, it can be. ',
                    style: pw.TextStyle(
                      fontSize: Get.width / 28,
                    ),
                  ),
                ],
              ),
            )
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
