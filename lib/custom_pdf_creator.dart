import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class CustomPdfCreator {
  static final CustomPdfCreator _instance = CustomPdfCreator._instance;
  factory CustomPdfCreator() => _instance;

  static Future<List<Widget>> createPdf() async {
    List<String> fruits = [
      "apple",
      "mango",
      "banana",
      "guava",
      "grapes",
      "licchi"
    ];
    final assetimage = await imageFromAssetBundle('assets/animals.jpg');
    final networkimage = await networkImage(
        "https://images.unsplash.com/photo-1720491468850-368cd24ce9d5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxOHx8fGVufDB8fHx8fA%3D%3D");
    return [
      pw.Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        pw.Text("This is a sample test pdf document."),
        pw.SizedBox(height: 10),
        pw.Text("Image from asset"),
        pw.Image(assetimage, height: 200),
        pw.SizedBox(height: 10),
        pw.Text("Image from network url"),
        pw.Image(networkimage, height: 200),
        pw.SizedBox(height: 10),
        pw.Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          pw.Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: PdfColors.red,
              )),
          pw.Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: PdfColors.yellow,
              )),
          pw.Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: PdfColors.green,
              )),
        ]),
        pw.SizedBox(height: 10),
        pw.ListView.separated(
            itemBuilder: (context, index) => pw.Text(fruits[index]),
            itemCount: fruits.length,
            separatorBuilder: (context, index) => pw.SizedBox(height: 8))
      ])
    ];
  }
}
