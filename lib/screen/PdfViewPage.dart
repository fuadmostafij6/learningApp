


import 'package:flutter/material.dart';
import 'package:learningapp/constant/rout_page.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewScreen extends StatefulWidget {
  final String name;
  final String link;
  const PdfViewScreen({Key? key, required this.link, required this.name}) : super(key: key);

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
   PdfViewerController? _pdfViewerController;


  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.link);
    return Scaffold(
      appBar:
      PreferredSize(
        preferredSize: AppBar().preferredSize,
        child:
        NewAppBar.buildAppBar(name: widget.name,pdf: true, function: (){
          _pdfViewerController!.previousPage();
        }, function1: (){
          _pdfViewerController!.nextPage();
        }),
      ),
      body: SfPdfViewer.network(
        widget.link,
        controller: _pdfViewerController,
      ) ,
    );
  }
}
