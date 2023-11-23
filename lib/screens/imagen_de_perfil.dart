// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/common_buttons.dart';
import 'constants.dart';
import '../../screens/select_photo_options_screen.dart';

// ignore: must_be_immutable
class ImagenDePerfilPage extends StatefulWidget {
  const ImagenDePerfilPage({super.key});

  static const id = 'set_photo_screen';

  @override
  State<ImagenDePerfilPage> createState() => _ImagenDePerfilPage();
}


class _ImagenDePerfilPage extends State<ImagenDePerfilPage> {
  

  File? _image;
  bool _imageSelected = false;

  Future _pickImage(ImageSource source) async {

    try {

      final image = await ImagePicker().pickImage(source: source);

      if(image == null) return;

      File? img= File(image.path);

      img = await _cropImage(imageFile: img);

      setState(() {

        _image = img;
         _imageSelected = true;
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

    if(croppedImage == null) return null;
    
    return File(croppedImage.path);

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
    return Scaffold(

      backgroundColor: Color.fromARGB(255, 247, 247, 255),

      appBar: AppBar(

        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        backgroundColor: Color.fromARGB(255, 247, 247, 255),
        
        leading: IconButton(
          onPressed: () {

            Navigator.pop(
              context
            );
            
          },

          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        
        ),

      ),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        '¡Agrega una foto tuya!',
                        style: kHeadTextStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Así podremos reconocerte mejor',
                        style: kHeadSubtitleTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
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
                            color: Color.fromARGB(255, 229, 229, 244),
                          ),
                          child: Center(
                            child: _image == null 
                              ? const Text(
                                'No Seleccionada',
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
                  const Text(
                    'Usuario',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButtons(
                    onTap: () => _showSelectPhotoOptions(context),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textLabel: 'Agregar Foto',
                  ),
                  if (_imageSelected)
                  const SizedBox(
                    height: 20,
                  ),
                  if (_imageSelected)
                  /* CommonButtons(
                    onTap: () {
                    
                    },
                    backgroundColor: Colors.blue, // Puedes cambiar el color según tu diseño.
                    textColor: Colors.white,
                    textLabel: 'Guardar Imagen',
                  ), */
                Padding(
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
                            )
                          ),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              // Implementa la lógica para guardar la imagen en la aplicación.
                              // Puedes agregar aquí la lógica para guardar la imagen.
                              // Ejemplo: _saveImageToApp();
                              Navigator.pop(
                                context
                              );
                            },
                            color: Color.fromARGB(255, 81, 124, 193),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Guardar Imagen",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                              ),
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
    );
  }
}
