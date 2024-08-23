import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer(
      {super.key,
      required this.bytes,
      required this.fileName,
      this.pageFormat = PdfPageFormat.standard});
  final Uint8List bytes;
  final String fileName;
  final PdfPageFormat pageFormat;
  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.fileName),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () async {
                await Printing.layoutPdf(
                  onLayout: (_) => widget.bytes,
                  name: widget.fileName,
                  format: widget.pageFormat,
                  dynamicLayout: false,
                  usePrinterSettings: false,
                );
              },
              icon: const Icon(Icons.download)),
          IconButton(
              onPressed: () async {
                await Printing.sharePdf(
                  bytes: widget.bytes,
                  filename: widget.fileName,
                );
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: PdfPreview(
          loadingWidget: CircularProgressIndicator.adaptive(),
          useActions: false,
          enableScrollToPage: true,
          scrollViewDecoration:
              BoxDecoration(color: Colors.black.withOpacity(0.03)),
          pdfFileName: widget.fileName,
          pdfPreviewPageDecoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          canChangePageFormat: false,
          canChangeOrientation: false,
          canDebug: false,
          build: (_) => widget.bytes),
    );
  }
}
