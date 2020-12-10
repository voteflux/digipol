import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:voting_app/ui/styles.dart';
import 'package:flutter_fullpdfview/flutter_fullpdfview.dart';

/// This is the page that displays the PDFs

class PdfPage extends StatelessWidget {
  final String pdfUrl;

  PdfPage({
    Key key,
    @required this.pdfUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Bill Info'),
        ),
        body: PdfWidget(path: pdfUrl),
      ),
    );
  }
}

class PdfWidget extends StatefulWidget {
  final String path;

  @override
  _PdfWidgetState createState() => _PdfWidgetState();

  PdfWidget({
    Key key,
    @required this.path,
  }) : super(key: key);
}

class _PdfWidgetState extends State<PdfWidget> {
  String pathPDF = "";

  Future<File> createFileOfPdfUrl(String pdfUrl) async {
    Completer<File> completer = Completer();

    try {
      final filename = pdfUrl
          .substring(pdfUrl.lastIndexOf("/") + 1)
          .replaceAll(';fileType=application%2Fpdf', '');
      var request = await HttpClient().getUrl(Uri.parse(pdfUrl));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File('$dir/$filename');
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<File>(
        future: createFileOfPdfUrl(widget.path),
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              RaisedButton(
                  child: Text("Open PDF"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PDFScreen(path: snapshot.data.path)),
                    );
                  }),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String path;
  PDFScreen({Key key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  int pages = 0;
  bool isReady = false;
  String errorMessage = '';
  GlobalKey pdfKey = GlobalKey();
  bool isActive = true;
  double scale = 1.0;
  double top = 200.0;
  double initialLocalFocalPoint;
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (orientation == Orientation.portrait) {
        final Completer<PDFViewController> _controller =
            Completer<PDFViewController>();
        return Scaffold(
          appBar: AppBar(
            title: Text("Document"),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                color: Colors.black,
                child: PDFView(
                    key: pdfKey,
                    filePath: widget.path,
                    fitEachPage: true,
                    fitPolicy: FitPolicy.BOTH,
                    dualPageMode: false,
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: true,
                    pageFling: true,
                    defaultPage: 1,
                    pageSnap: true,
                    // backgroundColor: bgcolors.BLACK,
                    onRender: (_pages) {
                      print("OK RENDERED!!!!!");
                      setState(() {
                        pages = _pages;
                        isReady = true;
                      });
                    },
                    onError: (error) {
                      setState(() {
                        errorMessage = error.toString();
                      });
                      print(error.toString());
                    },
                    onPageError: (page, error) {
                      setState(() {
                        errorMessage = '$page: ${error.toString()}';
                      });
                      print('$page: ${error.toString()}');
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      _controller.complete(pdfViewController);
                    },
                    onPageChanged: (int page, int total) {
                      print('page change: $page/$total');
                    },
                    onZoomChanged: (double zoom) {
                      print("Zoom is now $zoom");
                    }),
              ),
              errorMessage.isEmpty
                  ? !isReady
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container()
                  : Center(child: Text(errorMessage))
            ],
          ),
          // floatingActionButton: FutureBuilder<PDFViewController>(
          //   future: _controller.future,
          //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          //     if (snapshot.hasData) {
          //       return FloatingActionButton.extended(
          //         label: Text("Go to ${pages ~/ 2}"),
          //         onPressed: () async {
          //           print(await snapshot.data.getZoom());
          //           print(await snapshot.data.getPageWidth(1));
          //           print(await snapshot.data.getPageHeight(1));
          //           //await snapshot.data.setPage(pages ~/ 2);
          //           await snapshot.data.resetZoom(1);
          //           await snapshot.data.setZoom(3.0);
          //           //print(await snapshot.data.getScreenWidth());
          //         },
          //       );
          //     }

          //     return Container();
          //   },
          // ),
        );
      } else {
        final Completer<PDFViewController> _controller =
            Completer<PDFViewController>();
        return PDFView(
          filePath: widget.path,
          fitEachPage: true,
          dualPageMode: true,
          displayAsBook: true,
          dualPageWithBreak: true,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: true,
          defaultPage: 0,
          pageSnap: true,
          backgroundColor: bgcolors.BLACK,
          onRender: (_pages) {
            print("Pdf rendered");
            setState(() {
              pages = _pages;
              isReady = true;
            });
          },
          onError: (error) {
            setState(() {
              errorMessage = error.toString();
            });
            print(error.toString());
          },
          onPageError: (page, error) {
            setState(() {
              errorMessage = '$page: ${error.toString()}';
            });
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {
            _controller.complete(pdfViewController);
          },
          onPageChanged: (int page, int total) {
            print('page change: $page/$total');
          },
        );
      }
    });
  }
}
