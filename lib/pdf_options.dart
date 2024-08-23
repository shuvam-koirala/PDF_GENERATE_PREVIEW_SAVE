import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf_genereate_view_print/custom_pdf_creator.dart';
import 'package:pdf_genereate_view_print/pdf_generator.dart';
import 'package:pdf_genereate_view_print/pdf_viewer.dart';

class PdfOptions extends StatelessWidget {
  const PdfOptions({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Choose Suitable Option"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Generate, Preview and Save Pdf",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  const String body = '''
                        <h1>Heading Example</h1>
                        <p>This is a paragraph.</p>
                        <img src="image.jpg" alt="Example Image" />
                        <blockquote>This is a quote.</blockquote>
                        <ul>
                          <li>First item</li>
                          <li>Second item</li>
                          <li>Third item</li>
                        </ul>
                        ''';
                  Uint8List bytes = await PdfGenerator.getPdfFromHtml(body);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PdfViewer(
                            bytes: bytes,
                            fileName: "Html_Sample.pdf",
                          )));
                },
                child: const Text("Pdf From Html")),
            ElevatedButton(
                onPressed: () async {
                  const String pdfUrl =
                      "https://www.rd.usda.gov/sites/default/files/pdf-sample_0.pdf";
                  Uint8List bytes = await PdfGenerator.getNetworkPdf(pdfUrl);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PdfViewer(
                            bytes: bytes,
                            fileName: "Network_Sample.pdf",
                          )));
                },
                child: const Text("Pdf From Network Url")),
            ElevatedButton(
                onPressed: () async {
                  final widgets = await CustomPdfCreator.createPdf();
                  Uint8List bytes = await PdfGenerator.getCustomPdf(widgets);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PdfViewer(
                            bytes: bytes,
                            fileName: "Network_Sample.pdf",
                          )));
                },
                child: const Text("Pdf From Widgets")),
            ElevatedButton(
                onPressed: () async {
                  final (Uint8List? bytes, String? fileName) =
                      await PdfGenerator.getDevicePdf();
                  if (bytes != null && fileName != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PdfViewer(
                              bytes: bytes,
                              fileName: fileName,
                            )));
                  }
                },
                child: const Text("Pdf From Device"))
          ],
        ),
      ),
    );
  }
}
