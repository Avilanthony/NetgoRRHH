// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_call_super

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recursos_humanos_netgo/signup.dart';
import 'package:recursos_humanos_netgo/model/dashboard/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';

class LoginPage extends StatefulWidget {
  
  @override
   _LoginPageState createState() => _LoginPageState();
  
}

class _LoginPageState extends State<LoginPage>{

  // Controladores para los campos de entrada
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  // Define FocusNode para cada campo de entrada
  final _usuarioFocus = FocusNode();
  final _contrasenaFocus = FocusNode();

  // Variable para habilitar/deshabilitar el botón de registro
  bool _accesoHabilitado = false;

  late SharedPreferences prefs;

  @override
  void dispose() {
    // Liberar los controladores y los focus
    _usuarioController.dispose();
    _contrasenaController.dispose();
    _usuarioFocus.dispose();
    _contrasenaFocus.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Vincular onChanged a cada campo de entrada
    _usuarioController.addListener(_verificarCampos);
    _contrasenaController.addListener(_verificarCampos);
    initSharedPref();
  }

  void cambiarFoco(FocusNode nodoActual, FocusNode proximoNodo) {
    nodoActual.unfocus();
    FocusScope.of(context).requestFocus(proximoNodo);
  }

  // Función para verificar si todos los campos contienen información válida
  void _verificarCampos() {
    setState(() {
      if (
          _usuarioController.text.isNotEmpty &&
          _contrasenaController.text.isNotEmpty) {
        _accesoHabilitado = true; // Utiliza = en lugar de ==
      } else {
        _accesoHabilitado = false; // Utiliza = en lugar de ==
      }
    });
  }

  void initSharedPref() async {

    prefs = await SharedPreferences.getInstance();

  }

  _LoginPageState();

@override
Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
    
        resizeToAvoidBottomInset: false, //PARA QUE CUANDO SE ABRA EL TECLADO NO EXISTA OVERFLOW
        
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
        
        body: Container(
    
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
    
          child: Column(
    
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
    
            children: <Widget>[
    
              Expanded( //PARA QUE CUBRA TODA LA PANTALLA
    
                child: Column(
              
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
                  children: <Widget>[
              
                    Column(
              
                      children: <Widget>[
              
                        Text("Login", style: TextStyle(
              
                          fontSize: 30,
                          fontWeight: FontWeight.bold
              
                        ),),
              
                        SizedBox(height: 20,),
              
                        Text("Accede a tu cuenta", style: TextStyle(
              
                          fontSize: 15,
                          color: Colors.grey[700]
              
                        ),),
              
                      ],
              
                    ),
              
                    //AQUÍ
              
                    Padding(
              
                      padding: EdgeInsets.symmetric(horizontal: 40),
              
                      child: Column(
              
                        children: <Widget>[
              
                          makeInput(label: "Usuario",
                          controller: _usuarioController,
                          focusNode: _usuarioFocus,
                          onSubmitted: (value) => cambiarFoco(_usuarioFocus, _contrasenaFocus)),
                          makeInput(label: "Contraseña", 
                          controller: _contrasenaController,
                          focusNode: _contrasenaFocus,
                          onSubmitted: (value) => {},
                          obsecureText: true),
                          //makeInput(label: "Confirma tu Contraseña", obsecureText: true),
              
                        ],
              
                      ),
              
                    ),
              
                    //AQUÍ
              
                    Padding(
                      
                      padding: EdgeInsets.symmetric(horizontal: 40),
              
                      //AQUI
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
                        
                        child: MaterialButton(
              
                          minWidth: double.infinity,
                          height: 60,
    
                          onPressed: (){
    
                            _accesoHabilitado ? _ingresar() : null;
    
                          },
    
                          color: Color.fromARGB(255, 81, 124, 193),
                          elevation: 0,
              
                          shape: RoundedRectangleBorder(
              
                            borderRadius: BorderRadius.circular(50)
              
                          ),
              
                          child: Text(
              
                            "Ingresar", 
              
                            style: TextStyle(
                              
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18
              
                            ),
              
                          ),
              
                        ),
              
                      ),
                    
                    ),
              
                    //AQUÍ
              
                    Row(
              
                      mainAxisAlignment: MainAxisAlignment.center,
              
                      children: <Widget>[
              
                        Text("¿No tienes una cuenta?"),
    
                        GestureDetector(
    
                          child: Text(" Regístrate aquí", style: TextStyle(
                    
                            fontWeight: FontWeight.w600, fontSize:  18
    
                          ),),
                          
                          onTap: (){
    
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
    
                          },
    
                        )
              
                      ],
              
                    )
              
                  ],
              
                ),
              ),
    
              //AQUÍ
    
              Container(
    
                height: MediaQuery.of(context).size.height / 3,
    
                decoration: BoxDecoration(
    
                  image: DecorationImage(
    
                    image: AssetImage("assets/images/Background.png"),
                    fit: BoxFit.cover
    
                  )
    
                ),
    
              )
    
            ],
    
          ),
    
        ),
    
      ),
    );
  }

  void _ingresar() async{

/*     bool _esValido = false; */
    // Lógica para realizar el registro
    if(_accesoHabilitado){

      FocusScope.of(context).unfocus();
      try {
        var ingBody = {
          "usuario": _usuarioController.text,
          "contrasena": _contrasenaController.text,
        };
        print("Hola");

        var response = await http.post(Uri.parse(ingreso),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(ingBody)
        );

        var jsonResponse = jsonDecode(response.body);

        print(jsonResponse);

        if (jsonResponse['status']) {
          var myToken = jsonResponse['token'];
          prefs.setString('token', myToken);
          print(myToken);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(token: myToken,))); 
        /* context, MaterialPageRoute(builder: (context) => LoginPage())); */
        }else{
          print("Algo anda mal");
        }

        /* print(jsonResponse); */
        print(jsonResponse['status']);

      } catch (e) {
        // Manejar errores de red o excepciones (PODEMOS MODIFICARLO)
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error de conexión'),
            content: Text('Hubo un problema al intentar iniciar sesión. Por favor, verifica tu conexión a Internet.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
     

    }else{
      setState(() {
        print("Adiós");
      });
    }


   
  }

  //CLASES

  Widget makeInput({label, controller, focusNode, onSubmitted, obsecureText = false}){

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
          controller: controller,
          focusNode: focusNode,
          onSubmitted: onSubmitted,
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