// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:recursos_humanos_netgo/widgets/dashboard.dart';
import 'package:recursos_humanos_netgo/widgets/perfil_usuario.dart';
import 'package:recursos_humanos_netgo/widgets/tickets.dart';

void main() {
  runApp(
    
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netgo RRHH',
      home: TicketsPage(),
    )

  );
}

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: <Widget>[

          Container(
            height: 400,
            decoration: BoxDecoration(

              image: DecorationImage(

                image: AssetImage('assets/images/Header.png'),
                fit: BoxFit.fill
                  
              )

            ),

            child: Stack(

              children: <Widget>[

                Positioned(

                  left: 30,
                  width: 80,
                  height: 200,

                  child: Container(

                    decoration: BoxDecoration(

                      image: DecorationImage(

                        image: AssetImage('assets/images/light-1.png')

                      )

                    ),

                  ),

                ),

                Positioned(

                  left: 140,
                  width: 80,
                  height: 150,

                  child: Container(

                    decoration: BoxDecoration(

                      image: DecorationImage(

                        image: AssetImage('assets/images/light-2.png')

                      )

                    ),

                  ),

                ),

                 Positioned(

                  right: 40,
                  top: 5,
                  width: 80,
                  height: 150,

                  child: Container(

                    decoration: BoxDecoration(

                      image: DecorationImage(

                        image: AssetImage('assets/images/clock.png')

                      )

                    ),

                  ),

                ),

                Positioned(

                  child: Container(

                    margin: EdgeInsets.only(top:50),

                    child: Center(

                      child: Text("Login", style: TextStyle(color: Color.fromARGB(255, 43, 43, 43), fontSize: 40, fontWeight: FontWeight.bold)),
                  
                    )

                  ),

                ),

              ],

            ),

          ),

          Padding(
            padding: EdgeInsets.all(30.0),

            child: Column(

              children:<Widget>[
                
                Container(

                  padding: EdgeInsets.all(5),

                  decoration: BoxDecoration(

                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(

                        color: Color.fromRGBO(143, 148, 251, 0.2),
                        blurRadius: 20.0,
                        offset: Offset.fromDirection(0, 10)
                      )
                    ]

                  ),

                  child: Column(

                    children: <Widget>[

                      Container(

                        padding: EdgeInsets.all(8.0),

                        decoration: BoxDecoration(

                          border: Border(bottom: BorderSide(color:Colors.grey))

                        ),

                        child: TextField(

                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Correo",
                            hintStyle: TextStyle(color: Colors.grey[400])
                          ),

                        ),

                      ),

                      Container(

                        padding: EdgeInsets.all(8.0),

                        child: TextField(

                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Contraseña",
                            hintStyle: TextStyle(color: Colors.grey[400])
                          ),

                        ),

                      ),

                      SizedBox(

                        height: 30,
                      ),

                      Container(

                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [

                              Color.fromRGBO(143, 148, 251, 0.2),

                            ]
                          )
                        ),
                      )

                    ],
                    
                  )

                )

              ]
            ),
          ),
            

        ]

      ),

    );
    
  }

}
