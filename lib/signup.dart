// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:http/http.dart' as http;
import 'package:recursos_humanos_netgo/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SignupPage> {
  _SingUpPageState();

  // Controladores para los campos de entrada
  final TextEditingController _pNombresController = TextEditingController();
  final TextEditingController _sNombresController = TextEditingController();
  final TextEditingController _pApellidosController = TextEditingController();
  final TextEditingController _sApellidosController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _identidadController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _confirmarContrasenaController =
      TextEditingController();

  // Define FocusNode para cada campo de entrada
  final _pNombresFocus = FocusNode();
  final _sNombresFocus = FocusNode();
  final _pApellidosFocus = FocusNode();
  final _sApellidosFocus = FocusNode();
  final _usuarioFocus = FocusNode();
  final _identidadFocus = FocusNode();
  final _correoFocus = FocusNode();
  final _telefonoFocus = FocusNode();
  final _contrasenaFocus = FocusNode();
  final _confirmarContrasenaFocus = FocusNode();

  // Variable para habilitar/deshabilitar el botón de registro
  bool _registroHabilitado = false;

  bool _mostrarContrasena = false;

  @override
  void dispose() {
    // Liberar los controladores y los focus
    _pNombresController.dispose();
    _sNombresController.dispose();
    _pApellidosController.dispose();
    _sApellidosController.dispose();
    _usuarioController.dispose();
    _identidadController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    _confirmarContrasenaController.dispose();
    _pNombresFocus.dispose();
    _sNombresFocus.dispose();
    _pApellidosFocus.dispose();
    _sApellidosFocus.dispose();
    _usuarioFocus.dispose();
    _identidadFocus.dispose();
    _correoFocus.dispose();
    _telefonoFocus.dispose();
    _contrasenaFocus.dispose();
    _confirmarContrasenaFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Vincular onChanged a cada campo de entrada
    _pNombresController.addListener(_verificarCampos);
    _sNombresController.addListener(_verificarCampos);
    _pApellidosController.addListener(_verificarCampos);
    _sApellidosController.addListener(_verificarCampos);
    _usuarioController.addListener(_verificarCampos);
    _identidadController.addListener(_verificarCampos);
    _correoController.addListener(_verificarCampos);
    _telefonoController.addListener(_verificarCampos);
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
      print("Primer nombre: ${_pNombresController.text}");
      print("Condición 1.1: ${_pNombresController.text.isNotEmpty}");
      print("Condición 1.2: ${!_pNombresController.text.contains(' ')}");
      print("Condición 1.3: ${!(RegExp(r'[0-9]').hasMatch(_pNombresController.text))}");
      print("Segundo nombre: ${_sNombresController.text}");
      print("Condición 2.1: ${!_sNombresController.text.contains(' ')}");
      print("Condición 2.2: ${!(RegExp(r'[0-9]').hasMatch(_sNombresController.text))}");
      print("Primer apellido: ${_pApellidosController.text}");
      print("Condición 3.1: ${_pApellidosController.text.isNotEmpty}");
      print("Condición 3.2: ${!_pApellidosController.text.contains(' ')}");
      print("Condición 3.3: ${!(RegExp(r'[0-9]').hasMatch(_pApellidosController.text))}");
      print("Segundo apellido: ${_sApellidosController.text}");
      print("Condición 4.1: ${!_sApellidosController.text.contains(' ')}");
      print("Condición 4.2: ${!(RegExp(r'[0-9]').hasMatch(_sApellidosController.text))}");
      print("Usuario: ${_usuarioController.text}");
      print("Condición 5.1: ${_usuarioController.text.isNotEmpty}");
      print("Condición 5.2: ${!_usuarioController.text.contains(' ')}");
      print("Condición 5.3: ${!(RegExp(r'[0-9]').hasMatch(_usuarioController.text))}");
      print("Identidad: ${_identidadController.text}");
      print("Condición 6.1: ${_identidadController.text.isNotEmpty}");
      print("Condición 6.2: ${!_identidadController.text.contains(' ')}");
      print("Condición 6.3: ${!(RegExp(r'[^\d_-]').hasMatch(_identidadController.text))}");
      print("Correo: ${_correoController.text}");
      print("Condición 7.1: ${_correoController.text.isNotEmpty}");
      print("Condición 7.2: ${!_correoController.text.contains(' ')}");
      print("Teléfono: ${_telefonoController.text}");
      print("Condición 8.1: ${_telefonoController.text.isNotEmpty}");
      print("Condición 8.2: ${!_telefonoController.text.contains(' ')}");
      print("Condición 8.3: ${!(RegExp(r'[^\d_-]').hasMatch(_telefonoController.text))}");
      print("Contraseña: ${_contrasenaController.text}");
      print("Condición 9.1: ${_contrasenaController.text.isNotEmpty}");
      print("Condición 9.2: ${!_contrasenaController.text.contains(' ')}");
      print("Condición 9.3: ${_contrasenaController.text.length <= 12}");
      print("Condición 9.4: ${_contrasenaController.text.length >= 8}");
      print("Confirmar Contraseña: ${_confirmarContrasenaController.text}");
      print("Condición 10.1: ${_confirmarContrasenaController.text.isNotEmpty}");
      print("Condición 10.2: ${!_confirmarContrasenaController.text.contains(' ')}");
      print("Condición 10.3: ${_confirmarContrasenaController.text.length <= 12}");
      print("Condición 10.4: ${_confirmarContrasenaController.text.length >= 8}");
      print("Condición Final: ${_contrasenaController.text == _confirmarContrasenaController.text}");
      if (_pNombresController.text.isNotEmpty  &&
          !_pNombresController.text.contains(' ') &&
          !(RegExp(r'[0-9]').hasMatch(_pNombresController.text)) &&
          /* _sNombresController.text.isNotEmpty && */
          !_sNombresController.text.contains(' ') &&
          !(RegExp(r'[0-9]').hasMatch(_sNombresController.text)) &&
          _pApellidosController.text.isNotEmpty &&
          !_pApellidosController.text.contains(' ') &&
          !(RegExp(r'[0-9]').hasMatch(_pApellidosController.text)) &&
           /* _sApellidosController.text.isNotEmpty && */
          !_sApellidosController.text.contains(' ') &&
          !(RegExp(r'[0-9]').hasMatch(_sApellidosController.text)) &&
          _usuarioController.text.isNotEmpty &&
          !_usuarioController.text.contains(' ') &&
          _usuarioController.text.length <= 15 &&
          _usuarioController.text.length >= 5 &&
          !(RegExp(r'[0-9]').hasMatch(_usuarioController.text)) &&
          _identidadController.text.isNotEmpty &&
          !_identidadController.text.contains(' ') &&
          !(RegExp(r'[^\d_-]').hasMatch(_identidadController.text)) &&
          _identidadController.text.length == 13 &&
          _correoController.text.isNotEmpty &&
          !_correoController.text.contains(' ') &&
          _telefonoController.text.isNotEmpty &&
          !_telefonoController.text.contains(' ') &&
          !(RegExp(r'[^\d_-]').hasMatch(_telefonoController.text)) &&
          _telefonoController.text.length == 8 &&
          _contrasenaController.text.isNotEmpty &&
          !_contrasenaController.text.contains(' ') &&
          _contrasenaController.text.length <= 12 &&
          _contrasenaController.text.length >= 8 &&
          _confirmarContrasenaController.text.isNotEmpty &&
          !_confirmarContrasenaController.text.contains(' ') &&
          _confirmarContrasenaController.text.length <= 12 &&
          _confirmarContrasenaController.text.length >= 8 &&
          (_contrasenaController.text == _confirmarContrasenaController.text)) {
        _registroHabilitado = true; // Utiliza = en lugar de ==
        print(" Está habilitado?: $_registroHabilitado");
      } else {
        _registroHabilitado = false;
        print(" Está habilitado?: $_registroHabilitado");
        /* showToast("Hay ingresado mal los datos"); */ // Utiliza = en lugar de ==
      }
      print(" Está habilitado?: $_registroHabilitado");
      /* print(_pNombresController.text);
      print(_sNombresController.text);
      print(_pApellidosController.text);
      print(_sApellidosController.text);
      print(_usuarioController.text);
      print(_identidadController.text);
      print(_correoController.text);
      print(_telefonoController.text);
      print(_contrasenaController.text);
      print(_confirmarContrasenaController.text); */
    });
  }

  void mostrarValidaciones(){
    _pNombresController.text.isEmpty ? showToast("El campo del primer nombre no puede estar vacío") : null;
    _pNombresController.text.contains(' ') ? showToast("El campo del primer nombre no puede contener espacios") : null;
    RegExp(r'[0-9]').hasMatch(_pNombresController.text) ? showToast("El campo del primer nombre no puede contener números"): null;
    _sNombresController.text.contains(' ') ? showToast("El campo del segundo nombre no puede contener espacios") : null;
    RegExp(r'[0-9]').hasMatch(_sNombresController.text) ? showToast("El campo del segundo nombre no puede contener números"): null;
    _pApellidosController.text.isEmpty ? showToast("El campo del primer apellido no puede estar vacío") : null;
    _pApellidosController.text.contains(' ') ? showToast("El campo del primer apellido no puede contener espacios") : null;
    RegExp(r'[0-9]').hasMatch(_pApellidosController.text) ? showToast("El campo del primer apellido no puede contener números"): null;
    _sApellidosController.text.contains(' ') ? showToast("El campo del segundo apellido no puede contener espacios") : null;
    RegExp(r'[0-9]').hasMatch(_sApellidosController.text) ? showToast("El campo del segundo apellido no puede contener números"): null;
    _usuarioController.text.isEmpty ? showToast("El campo del usuario no puede estar vacío") : null;
    _usuarioController.text.contains(' ') ? showToast("El campo del usuario no puede contener espacios") : null;
    _usuarioController.text.length > 15 ? showToast("El campo del usuario debe tener 15 caracteres máximo") : null;
    _usuarioController.text.length < 5 ? showToast("El campo del usuario debe tener 5 caracteres mínimo") : null;
    RegExp(r'[0-9]').hasMatch(_usuarioController.text) ? showToast("El campo del usuario no puede contener números"): null;
    _identidadController.text.isEmpty ? showToast("El campo del DNI no puede estar vacío") : null;
    _identidadController.text.contains(' ') ? showToast("El campo del DNI no puede contener espacios") : null;
    RegExp(r'[^\d_-]').hasMatch(_identidadController.text) ? showToast("El campo del DNI no puede contener letras"): null;
    _identidadController.text.length != 13 ? showToast("El campo del DNI debe tener exactamente 13 números"):null;
    _correoController.text.isEmpty ? showToast("El campo del correo no puede estar vacío") : null;
    _correoController.text.contains(' ') ? showToast("El campo del correo no puede contener espacios") : null;
    _telefonoController.text.isEmpty ? showToast("El campo del teléfono no puede estar vacío") : null;
    _telefonoController.text.contains(' ') ? showToast("El campo del teléfono no puede contener espacios") : null;
    RegExp(r'[^\d_-]').hasMatch(_telefonoController.text) ? showToast("El campo del teléfono no puede contener letras"): null;
    _telefonoController.text.length != 8 ? showToast("El campo del télefono debe tener exactamente 8 números"):null;
    _contrasenaController.text.isEmpty ? showToast("El campo de la contraseña no puede estar vacío") : null;
    _contrasenaController.text.length > 12 ? showToast("El campo de la contraseña debe tener 12 caracteres máximo") : null;
    _contrasenaController.text.length < 8 ? showToast("El campo de la contraseña debe tener 8 caracteres mínimo") : null;
    _contrasenaController.text.contains(' ') ? showToast("El campo para la contraseña no puede contener espacios") : null;
    _confirmarContrasenaController.text.isEmpty ? showToast("El campo para confirmar la contraseña no puede estar vacío") : null;
    _confirmarContrasenaController.text.length > 12 ? showToast("El campo para confirmar la contraseña debe tener 12 caracteres máximo") : null;
    _confirmarContrasenaController.text.length < 8 ? showToast("El campo para confirmar la contraseña debe tener 8 caracteres mínimo") : null;
    _confirmarContrasenaController.text.contains(' ') ? showToast("El campo para confirmar la contraseña no puede contener espacios") : null;
    _contrasenaController.text != _confirmarContrasenaController.text ? showToast("Los espacios correspondientes a las contraseñas no coinciden") : null;
  }

  // Función para mostrar toasts con FlutterToast
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  void showToastExitoso(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
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
        /* resizeToAvoidBottomInset: false, */ //PARA QUE CUANDO SE ABRA EL TECLADO NO EXISTA OVERFLOW

        backgroundColor: Color.fromARGB(255, 247, 247, 255),

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        makeInput(
                          label: "Primer Nombre",
                          controller: _pNombresController,
                          focusNode: _pNombresFocus,
                          onSubmitted: (value) =>
                              cambiarFoco(_pNombresFocus, _sNombresFocus),
                          onChanged: (text) {
                             setState(() {
                              _pNombresController.text = text.toUpperCase();
                              _pNombresController.selection = TextSelection.fromPosition(
                                TextPosition(offset: _pNombresController.text.length),
                              );
                             });
                          }
                        ),
                        makeInput(
                          label: "Segundo Nombre",
                          controller: _sNombresController,
                          focusNode: _sNombresFocus,
                          onSubmitted: (value) =>
                              cambiarFoco(_sNombresFocus, _pApellidosFocus),
                          onChanged: (text) {
                             setState(() {
                              _sNombresController.text = text.toUpperCase();
                              _sNombresController.selection = TextSelection.fromPosition(
                                TextPosition(offset: _sNombresController.text.length),
                              );
                             });
                          }
                        ),
                        makeInput(
                          label: "Primer Apellido",
                          controller: _pApellidosController,
                          focusNode: _pApellidosFocus,
                          onSubmitted: (value) =>
                              cambiarFoco(_pApellidosFocus, _sApellidosFocus),
                          onChanged: (text) {
                             setState(() {
                              _pApellidosController.text = text.toUpperCase();
                              _pApellidosController.selection = TextSelection.fromPosition(
                                TextPosition(offset: _pApellidosController.text.length),
                              );
                             }); 
                          }
                        ),
                        makeInput(
                          label: "Segundo Apellido",
                          controller: _sApellidosController,
                          focusNode: _sApellidosFocus,
                          onSubmitted: (value) =>
                              cambiarFoco(_sApellidosFocus, _usuarioFocus),
                          onChanged: (text) {
                              setState(() {
                              _sApellidosController.text = text.toUpperCase();
                              _sApellidosController.selection = TextSelection.fromPosition(
                                TextPosition(offset: _sApellidosController.text.length),
                              );
                             }); 
                          }
                        ),
                        makeInput(
                          label: "Nombre de Usuario",
                          controller: _usuarioController,
                          focusNode: _usuarioFocus,
                          onSubmitted: (value) =>
                              cambiarFoco(_usuarioFocus, _identidadFocus),
                          onChanged: (text) {
                             setState(() {
                              _usuarioController.text = text.toUpperCase();
                              _usuarioController.selection = TextSelection.fromPosition(
                                TextPosition(offset: _usuarioController.text.length),
                              );
                             });
                          }
                        ),
                        makeInput(
                          label: "Número de DNI",
                          controller: _identidadController,
                          focusNode: _identidadFocus,
                          onSubmitted: (value) =>
                              cambiarFoco(_identidadFocus, _correoFocus),
                        ),
                        makeInput(
                          label: "Correo",
                          controller: _correoController,
                          focusNode: _correoFocus,
                          onSubmitted: (value) =>
                              cambiarFoco(_correoFocus, _telefonoFocus),
                        ),
                        makeInput(
                          label: "Teléfono",
                          controller: _telefonoController,
                          focusNode: _telefonoFocus,
                          onSubmitted: (value) =>
                              cambiarFoco(_telefonoFocus, _contrasenaFocus),
                        ),
                        makeInput(
                            label: "Contraseña",
                            controller: _contrasenaController,
                            focusNode: _contrasenaFocus,
                            onSubmitted: (value) => cambiarFoco(
                                _contrasenaFocus, _confirmarContrasenaFocus),
                            obsecureText: !_mostrarContrasena,
                            suffixIcon: IconButton(
                              icon: Icon(
                              _mostrarContrasena ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _mostrarContrasena = !_mostrarContrasena;
                              });
                            },
                          ),),
                        makeInput(
                            label: "Confirma tu Contraseña",
                            controller: _confirmarContrasenaController,
                            focusNode: _confirmarContrasenaFocus,
                            onSubmitted: (value) {
                              _confirmarContrasenaFocus.unfocus();
                            },
                            obsecureText: !_mostrarContrasena,
                            suffixIcon: IconButton(
                              icon: Icon(
                              _mostrarContrasena ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _mostrarContrasena = !_mostrarContrasena;
                              });
                            },
                          ),),
                      ],
                    ),
                  ),

                  //AQUÍ ESTABA EL BOTÓN DE LA IMAGEN DE PERFIL
                  /* Padding(
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
                  ), */

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
                          _registroHabilitado ? _registrarse() : mostrarValidaciones();
                          mostrarValidaciones();
                          
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

  void _registrarse() async {
    // Lógica para realizar el registro
    if (_registroHabilitado) {
      FocusScope.of(context).unfocus();
      try {
        var ingBody = {
          "primer_nombre": _pNombresController.text,
          "segundo_nombre": _sNombresController.text,
          "primer_apellido": _pApellidosController.text,
          "segundo_apellido": _sApellidosController.text,
          "usuario": _usuarioController.text,
          "dni": _identidadController.text,
          "correo": _correoController.text,
          "contrasena": _contrasenaController.text,
          "confcontrasena": _confirmarContrasenaController.text,
          "telefono": _telefonoController.text
        };

        print("Hola");

        var response = await http.post(Uri.parse(registro),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(ingBody));

        var jsonResponse = jsonDecode(response.body);

        print(jsonResponse);

        if (jsonResponse['status']) {
            showToastExitoso(jsonResponse['msg']);
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); 
          /* context, MaterialPageRoute(builder: (context) => LoginPage())); */
          }else{
            showToast(jsonResponse['msg']);
            print("Algo anda mal");
          }

        /* Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage())); */
      } catch (e) {
        // Manejar errores de red o excepciones
        showToast('Hubo un problema al intentar registrar al usuario. Verifica los datos');
      }
      
    } else {
      
      // Mostrar alerta porque las validaciones no se cumplen
      showToast('Por favor, completa todos los campos correctamente.');
      print("Adiós");
      
    }
  }

  //CLASES

  Widget makeInput(
      {label, controller, focusNode, onSubmitted, obsecureText = false, IconButton? suffixIcon, onChanged}) {
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
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            suffixIcon: suffixIcon,
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
