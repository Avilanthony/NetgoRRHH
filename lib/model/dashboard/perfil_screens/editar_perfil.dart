// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:recursos_humanos_netgo/config.dart';
import '../../../widgets/common_buttons.dart';
import '../../../screens/select_photo_options_screen.dart';
import 'package:http/http.dart' as http;

class EditarPerfilPage extends StatefulWidget {
  final token;
  const EditarPerfilPage({@required this.token, Key? key}) : super(key: key);

  static const id = 'set_photo_screen';

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  File? _image;

  late String usuario = '';
  String usuarioPrimerNombre = '';
  String usuarioPrimerApellido = '';
  String usuarioCorreo = '';
  String usuarioTelefono = '';

  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  void dispose() {
    // Liberar los controladores y los focus
    _correoController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    usuario = jwtDecodedToken['uid'].toString();
    obtenerInformacionUsuario();
  }

  Future<void> obtenerInformacionUsuario() async {
    try {
      final response = await http.get(
        Uri.parse(
            '$perfilUsuario/perfil_usuario/$usuario'), // Reemplaza con la URL correcta de tu backend
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        var myUsuario = jsonResponse['usuario'];

        print(myUsuario);

        setState(() {
          // Actualiza el estado con la información del usuario
          usuarioPrimerNombre = myUsuario['PRIMER_NOMBRE'];
          usuarioPrimerApellido = myUsuario['APELLIDO_PATERNO'];
          usuarioCorreo = myUsuario['CORREO'];
          usuarioTelefono = myUsuario['TELEFONO'];
          //VER QUE TRAE LOS DATOS DESDE LA CONSOLA
          print(usuarioPrimerNombre);
          print(usuarioPrimerApellido);
          print(usuarioCorreo);
          print(usuarioTelefono);
          // Otros campos del usuario...
        });
      } else {
        // La solicitud no fue exitosa, maneja el error según sea necesario
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      // Maneja errores de red u otros errores aquí
      print('Error: $error');
    }
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      File? img = File(image.path);

      img = await _cropImage(imageFile: img);

      // Envía la imagen al backend
      await _uploadImage(img!);

      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);

    if (croppedImage == null) return null;

    return File(croppedImage.path);
  }

  Future<void> _uploadImage(File image) async {
  // Construye la solicitud para subir la imagen al backend
  var request = http.MultipartRequest(
    'PUT', // o 'PUT' según tu API
    Uri.parse('$perfilUsuario/subir_imagen/$usuario'), // Reemplaza con la URL correcta de tu endpoint de carga
  );

  // Agrega la imagen al formulario multipart
  request.files.add(await http.MultipartFile.fromPath('image', image.path));

  // Envía la solicitud al backend
  var response = await request.send();

  // Maneja la respuesta del servidor
  if (response.statusCode == 200) {
    print('Imagen cargada con éxito');
  } else {
    print('Error al cargar la imagen: ${response.statusCode}');
  }
}

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        //resizeToAvoidBottomInset: false, //PARA QUE CUANDO SE ABRA EL TECLADO NO EXISTA OVERFLOW

        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
          ),
        ),

        body: SingleChildScrollView(
          reverse: true,
          physics: BouncingScrollPhysics(),
          child: Container(
            //height: MediaQuery.of(context).size.height,
            //width: double.infinity,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.1),
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            _showSelectPhotoOptions(context);
                          },
                          child: Center(
                            child: Container(
                                height: 200.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                  child: _image == null
                                      ? const Text(
                                          'No image selected',
                                          style: TextStyle(fontSize: 20),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: FileImage(_image!),
                                          radius: 200.0,
                                        ),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          '$usuarioPrimerNombre $usuarioPrimerApellido',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              padding: EdgeInsets.only(top: 1.5, left: 1.5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                  )),
                              child: CommonButtons(
                                onTap: () => _showSelectPhotoOptions(context),
                                backgroundColor:
                                    Color.fromARGB(255, 81, 124, 193),
                                textColor: Colors.white,
                                textLabel: 'Editar Foto',
                              ),

                              //AQUI VA LO QUE CORTÉ
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: <Widget>[
                              /* TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Telefono'
    
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Localidad'
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Correo'
                                    ),
                                  ), */

                              //====================================

                              /* TextFormField(
                                    focusNode: fielOne,
                                    //decoration: const InputDecoration(),
                                  ), */
                              makeInput(
                                  label: "Telefono",
                                  controller: _telefonoController),
                              makeInput(
                                  label: "Correo",
                                  controller: _correoController),

                              //makeInput(label: "Confirma tu Contraseña", obsecureText: true),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding: EdgeInsets.only(top: 1.5, left: 1.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                )),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () {
                                editar();
                              },
                              color: Color.fromARGB(255, 81, 124, 193),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Actualizar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void editar() async {
    var ingBody = {
      "correo": _correoController.text,
      "telefono": _telefonoController.text
    };

    print("Hola");

    var response = await http.put(
      Uri.parse('$perfilUsuario/editar_usuario/$usuario'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(ingBody),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse);

      // Después de editar, actualiza los datos de la pantalla de perfil
      await obtenerInformacionUsuario();

      // Cierra la pantalla de edición y devuelve true como resultado
      Navigator.pop(context, true);
    } else {
      // Maneja el error si la solicitud no fue exitosa
      print('Error en la solicitud: ${response.statusCode}');

      // Cierra la pantalla de edición y devuelve false como resultado
      Navigator.pop(context, false);
    }
  }

  Widget makeInput({label, controller, obsecureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),

        SizedBox(
          height: 5,
        ),

        TextField(
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              )),
        ),

        //AQUÍ

        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
