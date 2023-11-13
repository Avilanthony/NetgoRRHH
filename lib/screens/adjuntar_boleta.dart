import 'package:flutter/material.dart';
/* import 'package:flutter/services.dart'; */
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:recursos_humanos_netgo/screens/gestionar_boleta.dart';
/* import 'package:recursos_humanos_netgo/signup.dart'; */
/* import 'package:recursos_humanos_netgo/widgets/dashboard.dart'; */

class AdjuntarBoletaPage extends StatefulWidget {

   @override
  _AdjuntarBoletaPageState createState() => _AdjuntarBoletaPageState();

}

/* class SignupPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
} */

class _AdjuntarBoletaPageState extends State<AdjuntarBoletaPage> with SingleTickerProviderStateMixin{


  late AnimationController loadingController;

  /* File? _file;
 PlatformFile? _platformFile;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg']
    );

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
    }

    loadingController.forward();
  } */

   @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() { setState(() {}); });
    
    super.initState();
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
    
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 81, 124, 193),
          title: Text.rich(
            TextSpan(
              text: 'ADJUNTAR BOLETA DE PAGO',
              style: GoogleFonts.josefinSans(
              fontSize: 20, fontWeight: FontWeight.bold)
            ),
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
                  Column(

                    children: <Widget>[

                      const SizedBox(height: 35,),
                      const Text(
                        'Usuario a Entregar:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                        'Anthony Joshua Avila Laguna',
                        style: TextStyle( fontSize: 18),
                      ),
                      const SizedBox(height: 30,),
                      Image.asset("assets/images/Personaje5.png"),
                      const SizedBox(height: 30,),
                      Text('Sube el archivo', style: TextStyle(fontSize: 25, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      Text('El archivo debe ser en formato PDF', style: TextStyle(fontSize: 15, color: Colors.grey.shade500),),
                      const SizedBox(height: 15,),
                      /* GestureDetector( */
                      //onTap: selectFile,
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: [10, 4],
                          strokeCap: StrokeCap.round,
                          color: Colors.blue.shade400,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50.withOpacity(.3),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.folder_open, color: Colors.blue, size: 40,),
                                const SizedBox(height: 15,),
                                Text('Selecciona tu archivo', style: TextStyle(fontSize: 15, color: Colors.grey.shade400),),
                              ],
                            ),
                          ),
                        )
                      ),
                      const SizedBox(height: 20,),
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
                              /* _registroHabilitado ? _registrarse() : null; */
                              Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GestionarBoletaPage()));
                            },
                            color: Color.fromARGB(255, 81, 124, 193),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Enviar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                              ),
                            ),
                          ),
                        ),
                      ),

                      /* ), */

                    ]

                  


                  )
                  
                ],
            
              ),
            ),
          ),
    
        )
    
      ),
    );

  }

}