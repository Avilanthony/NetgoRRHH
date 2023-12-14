import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:recursos_humanos_netgo/config.dart';
import 'package:recursos_humanos_netgo/model/dashboard/ajustes_screen/adjuntar_boleta.dart';

import 'package:http/http.dart' as http;

/* class ConfiguracionUsuariosPage extends StatefulWidget {
  const ConfiguracionUsuariosPage({Key? key}) : super(key: key);

  @override
  _ConfiguracionUsuariosPageState createState() =>
      _ConfiguracionUsuariosPageState();
} */

class ConfiguracionUsuariosPage extends StatefulWidget {
  final int usuarioId;

  const ConfiguracionUsuariosPage({Key? key, required this.usuarioId}) : super(key: key);

  @override
  _ConfiguracionUsuariosPageState createState() => _ConfiguracionUsuariosPageState();
}

class _ConfiguracionUsuariosPageState extends State<ConfiguracionUsuariosPage> {
  Map<String, dynamic> _datosUsuario = {}; // Cambiado a Map
  static String? _valorSelecLocal;
  static String? _valorSelecDep;
  static String? _valorSelecEstado;
  static String? _valorSelecRol;
  static final _localesEmpresa=[
    "Tegucigalpa",
    "San Pedro Sula"
  ];
  static final _departamentosUsuario = [
    "Marketing",
    "Administración",
    "RRHH",
    "Mantenimiento"
  ];
  static final _estadoUsuario = [
    "Activo",
    "Inactivo",
    "Nuevo",
  ];
  static final _rolesUsuario = [
    "Administrador",
    "General",
  ];

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
        // Ahora, puedes utilizar los datos en 'data' para mostrarlos en tu aplicación
        /* final detallesUsuario = Map<String, dynamic>.from(data['usuario'].map((dep) => {
          'id': dep['ID'],
          'nombreCompleto': dep['P_NOMBRE'] + ' ' + dep['P_APELLIDO'],
          'localUbicacion': dep['LOCAL'],
          'deptoUsuario' : dep['DEPARTAMENTO'],
          'vacacUsuario': dep['VACACIONES'],
          'estadoUsuario' : dep['ESTADO'],
          'rolUsuario' : dep['ROL'],
          'telefonoUsuario': dep['TELEFONO'],
          'correoUsuario': dep['CORREO']
        })); */
        
        /* setState(() {
          /* _datosUsuario = detallesUsuario; */
          /* _idsUsuariosPorDepartamento = idsUsuarios; */
        }); */
        /* setState(() {
          _datosUsuario = data;
        }); */
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

  @override
  void initState() {
    super.initState();
    // Puedes establecer el valor de _userId según tus necesidades
     // Por ejemplo, asumiendo que el ID del usuario es "1"
    obtenerDetallesUsuario(widget.usuarioId);
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
          onPressed: () {
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
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
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
                    'Actualizar',
                    null,
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    _datosUsuario['DEPARTAMENTO'] ?? '',
                    'Departamento',
                    'Actualizar',
                    null,
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    '${_datosUsuario['VACACIONES']} días',
                    'Vacaciones', 
                    'Actualizar', 
                    null),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    'Boleta de Pago',
                    'Adjuntar',
                    'Adjuntar',
                    _adjuntarBoleta,
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    estiloTextos(_datosUsuario['ESTADO'] ?? ''),
                    'Estado del Usuario',
                    'Actualizar',
                    null,
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    estiloTextos(_datosUsuario['ROL'] ?? ''),
                    'Rol del Usuario',
                    'Actualizar',
                    null,
                  ),
                  const SizedBox(height: 20),
                  itemNoConfigurar(
                    '+504 ${_datosUsuario['TELEFONO'] ?? ''}',
                    'Teléfono',
                  ),
                  const SizedBox(height: 20),
                  itemNoConfigurar(
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

  void _adjuntarBoleta() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdjuntarBoletaPage()),
    );
  }

  Widget _buildAdditionalWidget(String subtitle) {
    if (subtitle == 'Local') {
      return DropdownButtonFormField(
        value: _ConfiguracionUsuariosPageState._valorSelecLocal,
        items: _ConfiguracionUsuariosPageState._localesEmpresa
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (val) {
          setState(() {
            _ConfiguracionUsuariosPageState._valorSelecLocal = val as String;
          });
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
        value: _ConfiguracionUsuariosPageState._valorSelecDep,
        items: _ConfiguracionUsuariosPageState._departamentosUsuario
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (val) {
          setState(() {
            _ConfiguracionUsuariosPageState._valorSelecDep = val as String;
          });
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
      return const TextField(
        decoration: InputDecoration(          
          labelText: 'Ingrese el valor',
          //border: OutlineInputBorder(),
        ),
      );
    } else if (subtitle == 'Estado del Usuario') {
      return DropdownButtonFormField(
        value: _ConfiguracionUsuariosPageState._valorSelecEstado,
        items: _ConfiguracionUsuariosPageState._estadoUsuario
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (val) {
          setState(() {
            _ConfiguracionUsuariosPageState._valorSelecEstado = val as String;
          });
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
          setState(() {
            _valorSelecRol = val;
          });
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
    String buttonText,
    Function()? onPressedFunction,
  ) {
    return Container(
/*       height: subtitle != "Adjuntar" ? 125.0 : 100.0, */
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
                title: Text(title),
                subtitle: Text(
                  subtitle,
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                textColor: const Color.fromARGB(255, 0, 0, 0),
              ),
              Positioned(
                top: 10,
                bottom: 10,
                right: 10,
                child: SizedBox(
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      if (onPressedFunction != null) {
                        onPressedFunction();
                      }
                    },
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
              ),
              
              
            ],

            
            
          ),

          Padding(
                /* top: 10, // Ajusta la posición del widget adicional según tus necesidades
                left: 20,
                right: 20, */
                padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0 ),
                child: SizedBox(
                  width: 300,
                  child: _buildAdditionalWidget(subtitle),
                ),
              ),

              if (subtitle != "Adjuntar")
          const SizedBox(
            height: 10,
          ), 
          
        ],
      ),
      
    );
  }

  Widget itemNoConfigurar(String title, String subtitle) {
    return Container(
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
  }
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
