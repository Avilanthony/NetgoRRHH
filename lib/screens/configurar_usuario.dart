import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:recursos_humanos_netgo/screens/adjuntar_boleta.dart';

class ConfiguracionUsuariosPage extends StatefulWidget {
  const ConfiguracionUsuariosPage({super.key});
  @override
  _ConfiguracionUsuariosPageState createState() => _ConfiguracionUsuariosPageState();
}

class _ConfiguracionUsuariosPageState extends State<ConfiguracionUsuariosPage> {

  @override
  _ConfiguracionUsuariosPageState() {
    _valorSelecDep ??= _departamentosUsuario[0];
    _valorSelecRol ??= _rolesUsuario[0];
    

  }


  //String dropdownValue = 'Todos';
  /* final _departamentosUsuario = [
    "Todos",
    "Marketing",
    "Administración",
    "RRHH",
    "Mantenimiento"
  ];
  String? _valorSelec = ""; */
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
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        
        child: Column(
          
          children: [
            Row(
              
              children: [
                
                const CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('assets/images/user.png'),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.center, // Centramos horizontalmente
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: [
                
                      Text(
                        "Anthony Ávila".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      
                    ],
                    
                  ),
                  
                ),

               

                
                
              ],

              
            ),

            const SizedBox(height: 15),
            
              /* const SizedBox(height: 20),
             
              const SizedBox(height: 20),
              
              const SizedBox(height: 20),
              
              const SizedBox(height: 20),
              
              const SizedBox(height: 20),
              
              const SizedBox(height: 20),
              
              const SizedBox(height: 20),
              
              const SizedBox(height: 25), */
              Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(

                              children: <Widget>[

                                itemConfigurar('Contabilidad','Departamento', 'Editar', null, null),
                                const SizedBox(height: 20),
                                itemConfigurar('35 días','Vacaciones', 'Editar', null, null),
                                const SizedBox(height: 20),
                                itemConfigurar('Boleta de Pago','Adjuntar', 'Adjuntar', _adjuntarBoleta, null),
                                const SizedBox(height: 20),
                                itemConfigurar('Activo','Estado del Usuario', 'Editar',null, null),
                                const SizedBox(height: 20),
                                itemConfigurar('Administrador','Rol del Usuario', 'Editar',null, null),
                                const SizedBox(height: 20),
                                itemNoConfigurar('+504 3315-9876','Teléfono',),
                                const SizedBox(height: 20),
                                itemNoConfigurar('anthony.avila@netgo.com','Correo',),
                                const SizedBox(height: 20),

                        
                              ]
                            )
              ),

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
                              
                            },
                            color: const Color.fromARGB(255, 81, 124, 193),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Guardar",
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
        
      )
    );

  }
  
  void _adjuntarBoleta() {
    // Lógica para realizar el registro
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdjuntarBoletaPage()));
  }

  itemConfigurar(String title, String subtitle, String buttonText, Function()? onPressedFunction, Widget? additionalWidget) {

 TextEditingController _textEditingController = TextEditingController();
 Widget contentWidget;
 

  if (subtitle == 'Departamento') {
    contentWidget = DropdownButtonFormField(
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
                              dropdownColor:
                                  const Color.fromARGB(255, 231, 241, 246),
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
    contentWidget = TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese el valor',
                    border: OutlineInputBorder(),
                  ),
            );
  } else if (subtitle == 'Estado del Usuario') {
    bool estadoActivo = true;

  contentWidget = StatefulBuilder(
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
        const SizedBox(width: 110), // Espacio entre los elementos
        Checkbox(
          value: !estadoActivo, // Invertir el valor para el segundo Checkbox
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
    contentWidget = DropdownButtonFormField(
                              value: _ConfiguracionUsuariosPageState._valorSelecRol,
                              items: _ConfiguracionUsuariosPageState._rolesUsuario
                                  .map((e) => DropdownMenuItem(
                                        
                                    value: e,
                                    child: Text(e),
                                  ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _ConfiguracionUsuariosPageState._valorSelecRol = val as String;
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                color: Color.fromARGB(255, 81, 124, 193),
                              ),
                              dropdownColor:
                                  const Color.fromARGB(255, 231, 241, 246),
                              decoration: const InputDecoration(
                                labelText: "Elige un Departamento",
                                prefixIcon: Icon(
                                  CupertinoIcons.briefcase_fill,
                                  color: Color.fromARGB(255, 81, 124, 193),
                                ),
                                border: UnderlineInputBorder(),
                              ),
                            );
  } else if (subtitle == 'Adjuntar') {
    // No se muestra nada para el caso de 'Adjuntar'
    contentWidget = SizedBox.shrink();
  } else {
    // Por defecto, se muestra un TextField
    contentWidget = SizedBox.shrink();
  }


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
      child: Column(
        children: [
          Stack(
            children: [ListTile(
              title: Text(title),
              subtitle: Text(subtitle,
                style: TextStyle(
                fontSize: 15, color: Colors.grey[700])
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

                            if (additionalWidget != null) {
                              Positioned(
                              top: 50, // Ajusta la posición según tus necesidades
                              left: 10,
                              child: additionalWidget,
                              );
                            }
                            
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 81, 124, 193), // Cambia el color del botón a rojo
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25), // Bordes redondeados
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
              
              
              
            ),]
          ),
          
          
            
            Positioned(
          top: 10, 
          left: 20,
          right: 20,
          child: SizedBox(
            width: 300,
            child: contentWidget,
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

itemNoConfigurar(String title, String subtitle) {
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
          subtitle: Text(subtitle,
              style: TextStyle(
                fontSize: 15, color: Colors.grey[700])),
          /* leading: Icon(iconData), */
          textColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        
      ],
    ),
  );
}




}



