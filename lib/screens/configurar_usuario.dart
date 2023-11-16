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
  static String? _valorSelecLocal;
  static String? _valorSelecDep;
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
  static final _rolesUsuario = [
    "Administrador",
    "General",
  ];

  @override
  Widget build(BuildContext context) {
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
                  "Anthony Ávila".toUpperCase(),
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
                    'Tegucigalpa',
                    'Local',
                    'Actualizar',
                    null,
                  ),
                  const SizedBox(height: 20),
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
      bool estadoActivo = true;

      return StatefulBuilder(
        builder: (context, setState) => Row(
          children: [
            Expanded(
              child: Row(
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
                  
                ],
              ),
            ),
              const SizedBox(width: 60),
             // Espacio entre los elementos
            Expanded(
              child: Row(
                children: [
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
            ),
            
            
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
