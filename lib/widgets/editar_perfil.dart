// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/common_buttons.dart';
import '../constants.dart';
import '../screens/select_photo_options_screen.dart';

class EditarPerfilPage extends StatefulWidget {

  const EditarPerfilPage({super.key});

  static const id = 'set_photo_screen';

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPage();

}

class _EditarPerfilPage extends State<EditarPerfilPage>{

  File?_image;

  Future _pickImage(ImageSource source) async {

    try {

      final image = await ImagePicker().pickImage(source: source);

      if(image == null) return;

      File? img= File(image.path);

      img = await _cropImage(imageFile: img);

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

      resizeToAvoidBottomInset: false, //PARA QUE CUANDO SE ABRA EL TECLADO NO EXISTA OVERFLOW

      appBar: AppBar(

        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        backgroundColor: Colors.white,
        
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
              const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* Column(
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
              ), */
              
              Padding(
                padding: const EdgeInsets.all(1),
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
                        )
                      ),
                      child: CommonButtons(
                        onTap: () => _showSelectPhotoOptions(context),
                        backgroundColor:Color.fromARGB(255, 81, 124, 193),
                        textColor: Colors.white,
                        textLabel: 'Agregar Foto',
                          
                      ),
                      
                      
                      /* child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarPerfilPage()
                            )
                          );
                        },
                        color: Color.fromARGB(255, 81, 124, 193),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text(
                          "Editar Perfil",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                          ),
                        ),
                      ), */
                    )
                    
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
            
                    padding: EdgeInsets.symmetric(horizontal: 40),
            
                    child: Column(
            
                      children: <Widget>[
            
                        makeInput(label: "Telefono"),
                        makeInput(label: "Localidad"),
                        makeInput(label: "Correo"),
                        
                        //makeInput(label: "Confirma tu Contraseña", obsecureText: true),
            
                      ],
            
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
  Widget makeInput({label, obsecureText = false}){

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[

        Text(
          
          label, 
          style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87

        ),),

        SizedBox(

          height: 5,

        ),

        TextField(

          obscureText: obsecureText,

          decoration: InputDecoration(

            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),

            enabledBorder: OutlineInputBorder(

              borderSide: BorderSide(

                color: Colors.grey[400]!

              ),

            ),

            border: OutlineInputBorder(

              borderSide: BorderSide(

                color: Colors.grey[400]!
                
              ),
            )
          
          ),

        ),

        //AQUÍ

        SizedBox(
          
          height: 30,
          
        ),

      ],

    );

  }

}

