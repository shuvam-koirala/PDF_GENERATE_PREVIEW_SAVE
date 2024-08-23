import 'package:flutter/material.dart';
import 'package:pdf_genereate_view_print/pdf_options.dart';
import 'package:pdf_genereate_view_print/pdf_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PdfOptions(),
    );
  }
}
