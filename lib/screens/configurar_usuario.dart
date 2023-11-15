import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:recursos_humanos_netgo/screens/adjuntar_boleta.dart';

class ConfiguracionUsuariosPage extends StatefulWidget {
  const ConfiguracionUsuariosPage({Key? key}) : super(key: key);

  @override
  _ConfiguracionUsuariosPageState createState() =>
      _ConfiguracionUsuariosPageState();
}

class _ConfiguracionUsuariosPageState extends State<ConfiguracionUsuariosPage> {
  static String? _valorSelecDep;
  static String? _valorSelecRol;
  static final _departamentosUsuario = [
    "Marketing",
    "Administración",
    "RRHH",
    "Mantenimiento"
  ];
  static final _rolesUsuario = [
    "Administrador",
    "General",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(25)),
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(width: 20),
                Text(
                  "Anthony Ávila".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  itemConfigurar(
                    'Contabilidad',
                    'Departamento',
                    'Actualizar',
                    null,
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar('35 días', 'Vacaciones', 'Actualizar', null),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    'Boleta de Pago',
                    'Adjuntar',
                    'Adjuntar',
                    _adjuntarBoleta,
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    'Activo',
                    'Estado del Usuario',
                    'Actualizar',
                    null,
                  ),
                  const SizedBox(height: 20),
                  itemConfigurar(
                    'Administrador',
                    'Rol del Usuario',
                    'Actualizar',
                    null,
                  ),
                  const SizedBox(height: 20),
                  itemNoConfigurar(
                    '+504 3315-9876',
                    'Teléfono',
                  ),
                  const SizedBox(height: 20),
                  itemNoConfigurar(
                    'anthony.avila@netgo.com',
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
    if (subtitle == 'Departamento') {
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
      bool estadoActivo = true;

      return StatefulBuilder(
        builder: (context, setState) => Row(
          children: [
            Checkbox(
              value: estadoActivo,
              onChanged: (value) {
                setState(() {
                  estadoActivo = value!;
                });
              },
            ),
            const SizedBox(width: 8), // Espacio entre el Checkbox con el label
            const Text('Activo'),
            const SizedBox(width: 8), // Espacio entre los elementos
            Checkbox(
              value:
                  !estadoActivo, // Invertir el valor para el segundo Checkbox
              onChanged: (value) {
                setState(() {
                  estadoActivo = !value!;
                });
              },
            ),
            const SizedBox(width: 8),
            const Text('Inactivo'),
          ],
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
    } else {
      return const SizedBox
          .shrink(); // Si no es ninguno de los casos anteriores, retorna un Widget vacío
    }
  }

  Widget itemConfigurar(
    String title,
    String subtitle,
    String buttonText,
    Function()? onPressedFunction,
  ) {
    return Container(
      height: 125,
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
            textColor: const Color.fromARGB(255, 0, 0, 0),
          ),
          Positioned(
            top: 10,
            bottom: 65,
            right: 10,
            child: SizedBox(
              width: 115,
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
          Positioned(
            top: 55, // Ajusta la posición del widget adicional según tus necesidades
            left: 20,
            right: 20,
            child: SizedBox(
              width: 150,
              child: _buildAdditionalWidget(subtitle),
            ),
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
