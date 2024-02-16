// import 'dart:typed_data';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// import '../controller/invoiceController.dart';

// class pre_viewInvoiceScreen extends StatefulWidget {
//   const pre_viewInvoiceScreen({super.key});

//   @override
//   State<pre_viewInvoiceScreen> createState() => _pre_viewInvoiceScreenState();
// }

// class _pre_viewInvoiceScreenState extends State<pre_viewInvoiceScreen> {
//   final InvoiceController controller = Get.put(InvoiceController());

//   Future<void> _generateAndDownloadPDF() async {
//     final pdf = pw.Document();

//     // Add content to the PDF
//     pdf.addPage(
//       pw.Page(
//         build: (context) => _buildPdfContent(),
//       ),
//     );

//     // Get the directory where the PDF will be saved
//     final directory = await getApplicationDocumentsDirectory();
//     final path = '${directory.path}/invoice.pdf';

//     // Write the PDF to a file
//     final file = File(path);
//     await file.writeAsBytes(pdf.save() as List<int>);

//     // Open the PDF file using the device's default viewer
//     OpenFile.open(path);
//   }

//   pw.Widget _buildPdfContent() {
//     return 
//     // Build the content for the PDF
//     // Similar to what you have in your build method
//   }

//   // Rest of your code...
// }
