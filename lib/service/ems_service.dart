// import 'dart:io';
// import 'dart:typed_data';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// class EmsPdfService {
//   Future<Uint8List> GeneratePdf()
//   {
//     final pdf=pw.Document();
//     pdf.addPage(pw.Page(build: (pw.Context content){
//       return pw.Center(child: pw.Text("hello word"));
//     }));
//     return pdf.save();
//   }

//   Future<void> savePdffile(String filename, Uint8List byteList)async
//   {
//       final output =await getTemporaryDirectory();
//       var filepath= "${output.path}/$filename.pdf";
//       final file=File(filepath);
//       await file.writeAsBytes(byteList);
//       await OpenFile.open(filepath);
//   }
// }