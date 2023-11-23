import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
/* import 'dart:typed_data'; */
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
/* import 'package:pdf_render/pdf_render.dart'; */
/* import 'package:pdf_thumbnail/pdf_thumbnail.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data'; */
/* import 'dart:ui' as ui; */
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/configurar_usuario.dart';

class AdjuntarBoletaPage extends StatefulWidget {
  @override
  _AdjuntarBoletaPageState createState() => _AdjuntarBoletaPageState();
}

class _AdjuntarBoletaPageState extends State<AdjuntarBoletaPage>
    with SingleTickerProviderStateMixin {
  late AnimationController loadingController;

  File? _file;
  PlatformFile? _platformFile;
  Image? thumbnailImage;

  Future<Image> loadPlaceholderImage() async {
    final ByteData data = await rootBundle.load('assets/images/logopdf.png');
    final List<int> bytes = data.buffer.asUint8List();
    return Image.memory(Uint8List.fromList(bytes));
  }

  selectFile() async {
    final file = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });

     /*  final document = await PdfDocument.openFile(_file!.path);
      final page = await document.getPage(1);  // Usar la primera página para la miniatura
      final pageImage = await page.render(width: 70, height: 100); */

       final placeholderImage = await loadPlaceholderImage();
        setState(() {
      thumbnailImage = placeholderImage;
    });
    }
  }

 /*  Future<Uint8List> _captureImage(Image image) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

  /* image.paint(canvas, Rect.zero); */

    final picture = recorder.endRecording();
    final img = await picture.toImage(70, 100);
    final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  } */


  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 247, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 81, 124, 193),
          title: Text.rich(
            TextSpan(
                text: 'ADJUNTAR BOLETA DE PAGO',
                style: GoogleFonts.josefinSans(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            textAlign: TextAlign.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(children: <Widget>[
                    const SizedBox(
                      height: 35,
                    ),
                    const Text(
                      'Usuario a Entregar:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Anthony Joshua Avila Laguna',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset("assets/images/Personaje5.png"),
                    const SizedBox(
                      height: 39,
                    ),
                    Text(
                      'Sube el archivo',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'El archivo debe ser en formato PDF',
                      style:
                          TextStyle(fontSize: 15, color: Colors.grey.shade600),
                    ),
                    GestureDetector(
                      onTap: selectFile,
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, right: 40.0, bottom: 5.0, top: 20.0),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            color: Colors.blue.shade400,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.blue.shade50.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Iconsax.folder_open,
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Selecciona tu archivo',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    _platformFile != null
                        ? Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Archivo seleccionado',
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        /* color: Colors.white, */
                                        color: thumbnailImage != null ? Colors.white : Colors.grey[300],
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: const Offset(0, 1),
                                            blurRadius: 3,
                                            spreadRadius: 2,
                                          )
                                        ]),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset('assets/images/logopdf.png', width: 70, height: 100, fit: BoxFit.cover) /* Image.file(
                                              _file!,
                                              width: 70,
                                            ) *//* thumbnailImage != null */
                                             /*  ? Image.memory(img.encodePng(img.decodeImage(thumbnailImage!.image!.byteData!.buffer.asUint8List())!), width: 70, height: 100, fit: BoxFit.cover) */
                                              /* ? Image.memory(thumbnailImage!, width: 70, height: 100, fit: BoxFit.cover) */
                                              /* : Container(width: 70, height: 100, color: Colors.grey), */
                                              /* ? FutureBuilder<Uint8List>(
                                                future: _captureImage(thumbnailImage!),
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                                                    return Image.memory(snapshot.data!, width: 70, height: 100, fit: BoxFit.cover);
                                                  } else {
                                                    return Container(width: 70, height: 100, color: Colors.grey);
                                                  }
                                                },
                                              )
                                            : Container(width: 70, height: 100, color: Colors.grey), */
                                        ),

                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _platformFile!.name,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${(_platformFile!.size / 1024).ceil()} KB',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        Colors.grey.shade500),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                  height: 5,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.blue.shade50,
                                                  ),
                                                  child:
                                                      LinearProgressIndicator(
                                                    value:
                                                        loadingController.value,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        : Container(),

                        _platformFile != null
                        ?Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: const EdgeInsets.only(top: 1.5, left: 1.5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: const Border(
                              bottom: BorderSide(color: Colors.black),
                              top: BorderSide(color: Colors.black),
                              left: BorderSide(color: Colors.black),
                              right: BorderSide(color: Colors.black),
                            )),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            /* _registroHabilitado ? _registrarse() : null; */
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ConfiguracionUsuariosPage()));
                          },
                          color: const Color.fromARGB(255, 81, 124, 193),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            "Enviar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ): Container(),
                    
                    const SizedBox(
                      height: 20,
                    ),
                    /* ), */
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}
