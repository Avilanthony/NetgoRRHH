// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recursos_humanos_netgo/imagen_de_perfil.dart';
import 'package:recursos_humanos_netgo/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SignupPage> {
  // Controladores para los campos de entrada
  TextEditingController _nombresController = TextEditingController();
  TextEditingController _apellidosController = TextEditingController();
  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _identidadController = TextEditingController();
  TextEditingController _correoController = TextEditingController();
  TextEditingController _contrasenaController = TextEditingController();
  TextEditingController _confirmarContrasenaController = TextEditingController();

  // Define FocusNode para cada campo de entrada
  final _nombresFocus = FocusNode();
  final _apellidosFocus = FocusNode();
  final _usuarioFocus = FocusNode();
  final _identidadFocus = FocusNode();
  final _correoFocus = FocusNode();
  final _contrasenaFocus = FocusNode();
  final _confirmarContrasenaFocus = FocusNode();

  // Variable para habilitar/deshabilitar el botón de registro
  bool _registroHabilitado = false;
  
 

  @override
  void dispose() {
    // Liberar los controladores y los focus
    _nombresController.dispose();
    _apellidosController.dispose();
    _usuarioController.dispose();
    _identidadController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    _confirmarContrasenaController.dispose();
    _nombresFocus.dispose();
    _apellidosFocus.dispose();
    _usuarioFocus.dispose();
    _identidadFocus.dispose();
    _correoFocus.dispose();
    _contrasenaFocus.dispose();
    _confirmarContrasenaFocus.dispose();
    super.dispose();
  }

   @override
  void initState() {
    super.initState();

    // Vincular onChanged a cada campo de entrada
    _nombresController.addListener(_verificarCampos);
    _apellidosController.addListener(_verificarCampos);
    _usuarioController.addListener(_verificarCampos);
    _identidadController.addListener(_verificarCampos);
    _correoController.addListener(_verificarCampos);
    _contrasenaController.addListener(_verificarCampos);
    _confirmarContrasenaController.addListener(_verificarCampos);
  }

  void cambiarFoco(FocusNode nodoActual, FocusNode proximoNodo) {
    nodoActual.unfocus();
    FocusScope.of(context).requestFocus(proximoNodo);
  }


  // Función para verificar si todos los campos contienen información válida
  void _verificarCampos() {
    setState(() {
      if (_nombresController.text.isNotEmpty &&
          _apellidosController.text.isNotEmpty &&
          _usuarioController.text.isNotEmpty &&
          _identidadController.text.isNotEmpty &&
          _correoController.text.isNotEmpty &&
          _contrasenaController.text.isNotEmpty &&
          _confirmarContrasenaController.text.isNotEmpty &&
          _contrasenaController.text == _confirmarContrasenaController.text) {
        _registroHabilitado = true; // Utiliza = en lugar de ==
      } else {
        _registroHabilitado = false; // Utiliza = en lugar de ==
      }
    });
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
        /* resizeToAvoidBottomInset: false, */ //PARA QUE CUANDO SE ABRA EL TECLADO NO EXISTA OVERFLOW

        backgroundColor: Colors.white,

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
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Crea cuenta",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    ],
                  ),

                  //AQUÍ

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        makeInput(
                          label: "Nombres",
                          controller: _nombresController,
                          focusNode: _nombresFocus,
                          onSubmitted: (value) => cambiarFoco(_nombresFocus, _apellidosFocus),
                        ),
                        makeInput(
                          label: "Apellidos",
                          controller: _apellidosController,
                          focusNode: _apellidosFocus,
                          onSubmitted: (value) => cambiarFoco(_apellidosFocus, _usuarioFocus),
                        ),
                        makeInput(
                          label: "Nombre de Usuario",
                          controller: _usuarioController,
                          focusNode: _usuarioFocus,
                          onSubmitted: (value) => cambiarFoco(_usuarioFocus, _identidadFocus),
                        ),
                        makeInput(
                          label: "Número de Identidad",
                          controller: _identidadController,
                          focusNode: _identidadFocus,
                          onSubmitted: (value) => cambiarFoco(_identidadFocus, _correoFocus),
                        ),
                        makeInput(
                          label: "Correo",
                          controller: _correoController,
                          focusNode: _correoFocus,
                          onSubmitted: (value) => cambiarFoco(_correoFocus, _contrasenaFocus),
                        ),
                        makeInput(
                            label: "Contraseña",
                            controller: _contrasenaController,
                            focusNode: _contrasenaFocus,
                            onSubmitted: (value) => cambiarFoco(_contrasenaFocus, _confirmarContrasenaFocus),
                            obsecureText: true),
                        makeInput(
                            label: "Confirma tu Contraseña",
                            controller: _confirmarContrasenaController,
                            focusNode: _confirmarContrasenaFocus,
                            onSubmitted: (value) {
                              
                              _confirmarContrasenaFocus.unfocus();
                            },
                            obsecureText: true),
                      ],
                    ),
                  ),

                  //AQUÍ
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImagenDePerfilPage()));
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        "Añadir Foto de  Perfil",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      height: 20,
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
                          _registroHabilitado ? _registrarse() : null;
                        },
                        color: Color.fromARGB(255, 81, 124, 193),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          "Registrarse",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),

                  //AQUÍ

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("¿Ya tienes una cuenta?"),
                        GestureDetector(
                          child: Text(
                            " Ingresa aquí",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        ),
                      ],
                    ),
                  ),

                  //AQUÍ
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _registrarse() {
    // Lógica para realizar el registro
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  //CLASES

  Widget makeInput({label, controller, focusNode, onSubmitted, obsecureText = false}) {
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
          focusNode: focusNode,
          onSubmitted: onSubmitted,
          obscureText: obsecureText,
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
