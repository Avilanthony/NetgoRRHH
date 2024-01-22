import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recursos_humanos_netgo/config.dart';
/* import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/adjuntar_boleta.dart'; NO NECESARIA*/

import 'package:http/http.dart' as http;
/* import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/gestion_usuarios.dart'; NO NECESARIA*/

class ConfiguracionUsuariosPage extends StatefulWidget {
  final int usuarioId;
  final Function() onUpdateUsuariosList;

  const ConfiguracionUsuariosPage({Key? key, required this.usuarioId, required this.onUpdateUsuariosList}) : super(key: key);

  @override
  _ConfiguracionUsuariosPageState createState() => _ConfiguracionUsuariosPageState();
}

class _ConfiguracionUsuariosPageState extends State<ConfiguracionUsuariosPage> {
  Map<String, dynamic> _datosUsuario = {}; // Cambiado a Map
  List<String> _departamentosEmpresa = [];
  List<String> _localesEmpresa = [];
  final List<String> _estadosUsuario = [
    "NUEVO",
    "ACTIVO",
    "BLOQUEADO"
  ];
  List<String> _rolesUsuario = [];
  List<int> _idLocalesEmpresa = [];
  List<int> _idDepartamentosEmpresa = [];
  List<int> _idRolesUsuario = [];
  static String? _valorSelecLocal;
  static String? _valorSelecDep;
  static String? _valorSelecEstado;
  static String? _valorSelecRol;
  int? _idLocalSeleccionado;
  int? _idDepSeleccionado;
  int? _idRolSeleccionado;

  final TextEditingController _vacacionesController = TextEditingController();
  
  

  void dispose() {
    // Liberar los controladores y los focus
    _vacacionesController.dispose();
    super.dispose();
  }

  Future<void> obtenerDetallesUsuario(int idUsuario) async {
    try {
      final response = await http.get(Uri.parse('$datos_cada_usuario_gestionar/${widget.usuarioId}'));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['status']) {
        // La solicitud fue exitosa
        /* final Map<String, dynamic> data = json.decode(response.body);
        print('Tipo de data: ${data['usuario'].runtimeType}'); */
        final data = json.decode(response.body);
        final detallesUsuario = data['usuario']; // Acceder directamente al mapa

        setState(() {
          _datosUsuario = detallesUsuario;
        });
        
        print('Detalles del usuario: $data');
        print("Esto es una prueba: $_datosUsuario");
        print(_datosUsuario['LOCAL']);
      } else {
        // La solicitud falló con un código de estado diferente de 200
        print('Error al obtener detalles del usuario: ${response.statusCode}');
      }
    } catch (error) {
      // Manejar errores de red u otros
      print('Error al obtener detalles del usuario: $error');
    }
  } 

    Future<void> _getLocales() async {
    try {
      final response = await http.get(Uri.parse(llenar_select_locales));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['status']) {
        final data = json.decode(response.body);
        final locales = List<String>.from(data['locales'].map((loc) => loc['UBICACION']));
        final ids = List<int>.from(data['locales'].map((dep) => dep['ID_LOCAL']));
        setState(() {
          _localesEmpresa = locales;
          _idLocalesEmpresa = ids;
        });

        print("Locales obtenidos correctamente en _getLocales()");
        print("Los locales: $locales");
        print("Los IDs: $ids");
      } else {
        showToast(jsonResponse['msg'], backgroundColor: Colors.red);
        print("Algo anda mal al obtener locales");
      }
    } catch (error) {
      print(error);
      showToast('Hubo un problema al traer los locales.', backgroundColor: Colors.red);
    }
  }

  Future<void> _getDepartamentos() async {
    try {
      final response = await http.get(Uri.parse(llenar_select_deptos));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
  
      if (jsonResponse['status']) {
        final data = json.decode(response.body);
        final departamentos = List<String>.from(data['departamento'].map((dep) => dep['DEPARTAMENTO']));
        final ids = List<int>.from(data['departamento'].map((dep) => dep['ID_DEPARTAMENTO']));
        setState(() {
          _departamentosEmpresa = departamentos;
          _idDepartamentosEmpresa = ids;
        });
  
        print("Hola desde Configurar Usuarios en _getDepartamentos()");
        print("Los departamentos: $departamentos");
        print("Los IDs: $ids");
      } else {
        showToast(jsonResponse['msg'], backgroundColor: Colors.red);
        print("Algo anda mal");
      }
    } catch (error) {
      print(error);
      showToast('Hubo un problema al traer los departamentos en NuevaPantalla.', backgroundColor: Colors.red);
    }
  }
  
    Future<void> _getRoles() async {
    try {
      final response = await http.get(Uri.parse(llenar_select_roles));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      if (jsonResponse['status']) {
        final data = json.decode(response.body);
        final roles = List<String>.from(data['roles'].map((rol) => rol['ROL']));
        final ids = List<int>.from(data['roles'].map((rol) => rol['ID_ROL']));
        setState(() {
          _rolesUsuario = roles;
          _idRolesUsuario = ids;
        });

        print("Roles obtenidos con éxito");
      } else {
        showToast(jsonResponse['msg'], backgroundColor: Colors.red);
        print("Algo anda mal");
      }
    } catch (error) {
      print(error);
      showToast('Hubo un problema al traer los roles.', backgroundColor: Colors.red);
    }
  }


  //FUNICONES YA NO UTILIZADAS

   /*  Future<void> _actualizarLocal() async {
    // Lógica para actualizar el local

    var ingBody = {
      "idLocal": _idLocalSeleccionado.toString(),
    };

    try {
      var response = await http.put(
        Uri.parse('$gestionar/gest_local_usuario/${widget.usuarioId}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(ingBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      print(jsonResponse);
      print("El ID de local que se va a colocar es: $_idLocalSeleccionado");
      if (jsonResponse['status']) {
        print("El response con body exitoso${response.body}");
        print("El response exitoso $jsonResponse");
        await obtenerDetallesUsuario(widget.usuarioId);
        // Pasar un indicador de actualización a la página anterior
        widget.onUpdateUsuariosList();
        showToast('Local actualizado con éxito', backgroundColor: Colors.green);
      } else {
        print("El response con body no exitoso${response.body}");
        print("El response no exitoso $jsonResponse");
        showToast(jsonResponse['msg'], backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
      showToast('Hubo un problema al actualizar el local.', backgroundColor: Colors.red);
    }
  } */

  /* Future<void> _actualizarDepartamento() async {
    // Lógica para actualizar el departamento

    var ingBody = {
      "idDepto": _idDepSeleccionado.toString()
    };

    try {
      var response = await http.put(
        Uri.parse('$gestionar/gest_depto_usuario/${widget.usuarioId}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(ingBody),
        /* body: {"idDepto": "1"} */
      );

      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      print(jsonResponse);
      print("El ID que se va a colocar es: $_idDepSeleccionado");
      if (jsonResponse['status']) {
        print("El response con body exitoso${response.body}");
        print("El response exitoso $jsonResponse");
        await obtenerDetallesUsuario(widget.usuarioId);
        // Pasar un indicador de actualización a la página anterior
        widget.onUpdateUsuariosList();
        showToast('Departamento actualizado con éxito', backgroundColor: Colors.green);
      } else {
        print("El response con body no exitoso${response.body}");
        print("El response no exitoso $jsonResponse");
        showToast(jsonResponse['msg'], backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
      showToast('Hubo un problema al actualizar el departamento.', backgroundColor: Colors.red);
    }
  } */
  
  /* Future<void> _actualizarVacaciones() async {
    // Lógica para gestionar las vacaciones del usuario

    // Construye el cuerpo de la solicitud
    var ingBody = {
      // Agrega los campos necesarios según los requisitos de tu backend
      "vacaciones" : _vacacionesController.text
    };

    print("Hola");

    try {
      // Realiza la solicitud HTTP
      var response = await http.put(
        Uri.parse('$gestionar/gest_vacaciones_usuario/${widget.usuarioId}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(ingBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      print(jsonResponse);

      // Verifica el código de estado de la respuesta
      if (jsonResponse['status']) {
        FocusScope.of(context).unfocus();
        print("El response con body exitoso${response.body}");
        print("El response exitoso $jsonResponse");

        // Después de gestionar las vacaciones, actualiza los datos de la pantalla de perfil
        await obtenerDetallesUsuario(widget.usuarioId);
        // Pasar un indicador de actualización a la página anterior
        widget.onUpdateUsuariosList();
        // Muestra una notificación o realiza otras acciones según sea necesario
        showToast('Vacaciones gestionadas con éxito', backgroundColor: Colors.green);
      } else {
        // Muestra una notificación o realiza otras acciones en caso de error
        showToast('Error al gestionar vacaciones: ${response.statusCode}', backgroundColor: Colors.red);
      }
    } catch (error) {
      // Muestra una notificación o realiza otras acciones en caso de error
      showToast('Hubo un problema al gestionar vacaciones: $error', backgroundColor: Colors.red);
    }
  } */

  
  /* Future<void> _actualizarEstado() async {
    // Lógica para actualizar el rol

    var ingBody = {
      "estadoUser": _valorSelecEstado,
    };

    try {
      var response = await http.put(
        Uri.parse('$gestionar/gest_estado_usuario/${widget.usuarioId}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(ingBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      print(jsonResponse);
      print("El estado que se va a colocar es: $_valorSelecEstado");
      if (jsonResponse['status']) {
        print("El response con body exitoso${response.body}");
        print("El response exitoso $jsonResponse");
        await obtenerDetallesUsuario(widget.usuarioId);
        // Pasar un indicador de actualización a la página anterior
        widget.onUpdateUsuariosList();
        showToast('Rol actualizado con éxito', backgroundColor: Colors.green);
      } else {
        print("El response con body no exitoso${response.body}");
        print("El response no exitoso $jsonResponse");
        showToast(jsonResponse['msg'], backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
      showToast('Hubo un problema al actualizar el rol.', backgroundColor: Colors.red);
    }
  } */


  /* Future<void> _actualizarRol() async {
    // Lógica para actualizar el rol

    var ingBody = {
      "idRol": _idRolSeleccionado.toString(),
    };

    try {
      var response = await http.put(
        Uri.parse('$gestionar/gest_rol_usuario/${widget.usuarioId}'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(ingBody),
      );

      var jsonResponse = jsonDecode(response.body);
      print(response.body);
      print(jsonResponse);
      print("El ID de rol que se va a colocar es: $_idRolSeleccionado");
      if (jsonResponse['status']) {
        print("El response con body exitoso${response.body}");
        print("El response exitoso $jsonResponse");
        await obtenerDetallesUsuario(widget.usuarioId);
        // Pasar un indicador de actualización a la página anterior
        widget.onUpdateUsuariosList();
        showToast('Rol actualizado con éxito', backgroundColor: Colors.green);
      } else {
        print("El response con body no exitoso${response.body}");
        print("El response no exitoso $jsonResponse");
        showToast(jsonResponse['msg'], backgroundColor: Colors.red);
      }
    } catch (error) {
      print(error);
      showToast('Hubo un problema al actualizar el rol.', backgroundColor: Colors.red);
    }
  } */

  // Función para mostrar toasts con FlutterToast
  void showToast(String message,{Color? backgroundColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  _ConfiguracionUsuariosPageState() {
    // Asegúrate de que _departamentosUsuario no esté vacío antes de asignar el valor
    _valorSelecDep = _departamentosEmpresa.isNotEmpty ? _departamentosEmpresa[0] : null;
    _valorSelecLocal = _localesEmpresa.isNotEmpty ? _localesEmpresa[0] : null;
    _valorSelecEstado = _estadosUsuario.isNotEmpty ? _estadosUsuario[0] : null;
    _valorSelecRol = _rolesUsuario.isNotEmpty ? _rolesUsuario[0] : null;
  }


  @override
  void initState() {
    super.initState();
    // Puedes establecer el valor de _userId según tus necesidades
     // Por ejemplo, asumiendo que el ID del usuario es "1"
    obtenerDetallesUsuario(widget.usuarioId);
    _getDepartamentos();
    _getLocales();
    _getRoles();
    //En caso de querer que el Input de vacaciones tenga puesto el valor de la BD
    /* _vacacionesController.text = _datosUsuario['VACACIONES'] ?? ''; */
  }

  @override
  Widget build(BuildContext context) {
    print("El ID traído es el siguiente: ${widget.usuarioId}");
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 255),
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: const Color.fromARGB(255, 247, 247, 255),
        leading: IconButton(
          /* onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GestionUsuariosPage()),
            );
          }, */
          onPressed: () {
            widget.onUpdateUsuariosList();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        /* padding: const EdgeInsets.symmetric(horizontal: 15), */
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Center(
                  child:  Padding
                  (padding:  EdgeInsets.all(25))),
                /* const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ), */
                  _datosUsuario['IMG'] == ''  || _datosUsuario['IMG'] == null ?
                  const CircleAvatar(
              
                  radius: 35,
              
                  backgroundImage: AssetImage('assets/images/user.png'),
              
                ):
                CircleAvatar(
              
                  radius: 35,
              
                  backgroundImage: NetworkImage(_datosUsuario['IMG']),
              
                )
                ,
                SizedBox(width: screenWidth * 0.05),
                Text(
                  ((_datosUsuario['P_NOMBRE'] ?? '') + ' ' + (_datosUsuario['P_APELLIDO'] ?? '')).toUpperCase(),
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
             SizedBox(height: screenWidth * 0.02),
            Padding(
              /* padding: const EdgeInsets.all(10), */
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Column(
                children: <Widget>[
                  itemConfigurar(
                    estiloTextos(_datosUsuario['LOCAL'] ?? ''),
                    'Local',
                   /*  'Actualizar',
                    () => _actualizarLocal(), */
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    _datosUsuario['DEPARTAMENTO'] ?? '',
                    'Departamento',
                   /*  'Actualizar',
                    () => _actualizarDepartamento(), */
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    '${_datosUsuario['VACACIONES']  ?? 'ND'} días',
                    'Vacaciones', 
                    /* 'Actualizar', 
                    () => _actualizarVacaciones(), */
                  ),
                  /* const SizedBox(height: 20),
                  itemConfigurar( ESTE ITEM YA NO ES NECESARIO
                    'Boleta de Pago',
                    'Observar',
                   /*  'Adjuntar',
                    _adjuntarBoleta, */
                  ), */
                  const SizedBox(height: 20),
                  itemConfigurar(
                    estiloTextos(_datosUsuario['ESTADO'] ?? ''),
                    'Estado del Usuario',
                    /* 'Actualizar',
                    () => _actualizarEstado(), */
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    estiloTextos(_datosUsuario['ROL'] ?? ''),
                    'Rol del Usuario',
                    /* 'Actualizar',
                    () => _actualizarRol(), */
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    '+504 ${_datosUsuario['TELEFONO'] ?? ''}',
                    'Teléfono',
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    (_datosUsuario['CORREO'] ?? '').toLowerCase(),
                    'Correo',
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //FUNCIÓN NO NECESARIA

  /* void _adjuntarBoleta() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdjuntarBoletaPage(usuarioId: widget.usuarioId)),
    );
  } */

  Widget _buildAdditionalWidget(String subtitle) {
    if (subtitle == 'Local') {
      return DropdownButtonFormField(
        value: _valorSelecLocal,
        items: _localesEmpresa
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (val) {
          final index = _localesEmpresa.indexOf(val as String);
          setState(() {
            /* _ConfiguracionUsuariosPageState._valorSelecLocal = val as String; */
            _valorSelecLocal = val;
            _idLocalSeleccionado = _idLocalesEmpresa[index];   
          });

          print("El local que seleccionaste para editar es: $_valorSelecLocal");
          print("El local que seleccionaste para editar tiene el ID: $_idLocalSeleccionado");
        },
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Color.fromARGB(255, 81, 124, 193),
        ),
        dropdownColor: const Color.fromARGB(255, 231, 241, 246),
        decoration: const InputDecoration(
          labelText: "Elige un Local",
          prefixIcon: Icon(
            CupertinoIcons.building_2_fill,
            color: Color.fromARGB(255, 81, 124, 193),
          ),
          border: UnderlineInputBorder(),
        ),
      );
    }else if (subtitle == 'Departamento') {
      return DropdownButtonFormField(
        value: _valorSelecDep,
        items: _departamentosEmpresa
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (val) {
           final index = _departamentosEmpresa.indexOf(val as String);
          setState(() {
            _valorSelecDep = val;
            _idDepSeleccionado = _idDepartamentosEmpresa[index];                      
          });

          print("El depto que seleccionaste para editar es: $_valorSelecDep");
          print("El depto que seleccionaste para editar tiene el ID: $_idDepSeleccionado");
        },
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Color.fromARGB(255, 81, 124, 193),
        ),
        dropdownColor: const Color.fromARGB(255, 231, 241, 246),
        decoration: const InputDecoration(
          labelText: "Elige un Departamento",
          prefixIcon: Icon(
            CupertinoIcons.briefcase_fill,
            color: Color.fromARGB(255, 81, 124, 193),
          ),
          border: UnderlineInputBorder(),
        ),
      );
    } else if (subtitle == 'Vacaciones') {
      return TextField(
        controller: _vacacionesController,
        decoration: const InputDecoration(          
          labelText: 'Ingrese el valor',
          //border: OutlineInputBorder(),
        ),
      );
    } else if (subtitle == 'Estado del Usuario') {
      return DropdownButtonFormField(
        value: _valorSelecEstado,
        items: _estadosUsuario
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (val) {
          setState(() {
            _valorSelecEstado = val as String;
          });
          print("El estado que seleccionaste para editar es: $_valorSelecEstado");
        },
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Color.fromARGB(255, 81, 124, 193),
        ),
        dropdownColor: const Color.fromARGB(255, 231, 241, 246),
        decoration: const InputDecoration(
          labelText: "Elige un estado de usuario",
          prefixIcon: Icon(
            CupertinoIcons.briefcase_fill,
            color: Color.fromARGB(255, 81, 124, 193),
          ),
          border: UnderlineInputBorder(),
        ),
      );
    } else if (subtitle == 'Rol del Usuario') {
      return DropdownButtonFormField(
        value: _valorSelecRol,
        items: _rolesUsuario
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (val) {
          final index = _rolesUsuario.indexOf(val as String);
          setState(() {
            _valorSelecRol = val;
            _idRolSeleccionado = _idRolesUsuario[index];
          });

          print("El rol que seleccionaste para editar es: $_valorSelecRol");
          print("El rol que seleccionaste para editar tiene el ID: $_idRolSeleccionado");
        },
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Color.fromARGB(255, 81, 124, 193),
        ),
        dropdownColor: const Color.fromARGB(255, 231, 241, 246),
        decoration: const InputDecoration(
          labelText: "Elige un Rol",
          prefixIcon: Icon(
            CupertinoIcons.person_fill,
            color: Color.fromARGB(255, 81, 124, 193),
          ),
          border: UnderlineInputBorder(),
        ),
      );
    } else if (subtitle == 'Adjuntar') {
      // No se muestra nada para el caso de 'Adjuntar'
      return const SizedBox.shrink();
    } else {
      return const SizedBox.shrink(); // Si no es ninguno de los casos anteriores, retorna un Widget vacío
    }
  }

  Widget itemConfigurar(
    String title,
    String subtitle,
    /* String buttonText,
    Function()? onPressedFunction, */
  ) {
    return Container(
/*       height: subtitle != "Adjuntar" ? 125.0 : 100.0, */
      /* width: 200, */
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: const Color.fromARGB(179, 10, 47, 196).withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ListTile(
                title: Text(
                  subtitle,
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),),
                subtitle: Text(
                  title,
                  style: const TextStyle(fontSize: 17),
                ),
                textColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              /* Positioned( BOTÓN YA NO UTILIZADO
                top: 10,
                bottom: 10,
                right: 10,
                child: SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: onPressedFunction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 81, 124, 193), // Cambia el color del botón a rojo
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25), // Bordes redondeados
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ),
              ), */
              
              
            ],

            
            
          ),

          /* Padding( AQUI SE LLAMABAN LOS CONTROLES QUE YA NO SON NECESARIOS
            padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0 ),
            child: SizedBox(
              width: 300,
              child: _buildAdditionalWidget(subtitle),
            ),
          ), */

           /*    if (subtitle != "Adjuntar")
          const SizedBox(
            height: 10,
          ), 
           */
        ],
      ),
      
    );
  }

  /* Widget itemNoConfigurar(String title, String subtitle) {
    return Container(
      alignment: Alignment.centerLeft,
      /* width: 200, */
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: const Color.fromARGB(179, 10, 47, 196).withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(
              subtitle,
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),
            /* leading: Icon(iconData), */
            textColor: const Color.fromARGB(255, 0, 0, 0),
          ),
        ],
      ),
    );
  } */
}

estiloTextos(String texto){
  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  } 

  String capitalizeFullName(String fullName) {
    List<String> nameParts = fullName.split(' ');
    List<String> capitalizedParts = nameParts.map((part) => capitalize(part)).toList();
    return capitalizedParts.join(' ');
  }

  String capitalizedNombre = capitalizeFullName(texto);
  return capitalizedNombre;
}
