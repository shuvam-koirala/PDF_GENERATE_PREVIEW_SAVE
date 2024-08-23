import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGenerator {
  static final PdfGenerator _instance = PdfGenerator._instance;
  factory PdfGenerator() => _instance;

  static Future<Uint8List> getPdfFromHtml(String body) async {
    final Document pdf = pw.Document();
    final List<Widget> widgets = await HTMLToPdf().convert(body);
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4, build: (context) => widgets));
    return await pdf.save();
  }

  static Future<Uint8List> getNetworkPdf(String pdfUrl) async {
    final NetworkAssetBundle networkbundle = NetworkAssetBundle(Uri.parse(""));
    final pdf = await networkbundle.load(pdfUrl);
    return pdf.buffer.asUint8List();
  }

  static FutureOr<(Uint8List?, String?)> getDevicePdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      final file = result.files.first;
      return (File(file.path!).readAsBytesSync(), file.name);
    }
    return (null, null);
  }

  static Future<Uint8List> getCustomPdf(List<Widget> widgets) async {
    final Document pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return widgets;
        }));
    return await pdf.save();
  }
}
