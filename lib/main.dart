// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:recursos_humanos_netgo/widgets/dashboard.dart';
import 'package:recursos_humanos_netgo/widgets/perfil_usuario.dart';
import 'package:recursos_humanos_netgo/widgets/tickets.dart';
import 'package:recursos_humanos_netgo/login.dart';
import 'package:recursos_humanos_netgo/signup.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Container(

          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              //AQUI
              Column(


                children: <Widget>[

                  Text(
                    
                    "Bienvenido",

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),

                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    
                    "Para acceder a la aplicación primero debes ingresar tus datos",

                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.grey[780],
                      fontSize: 15,
                    ),

                  ),


                ],

              ),

              //AQUI

              Container(

                height: MediaQuery.of(context).size.height / 3,

                decoration: BoxDecoration(

                  image: DecorationImage(

                    image: AssetImage("assets/images/Header.png")

                  )

                ),

              ),

              //AQUÍ

              Column(
                children: <Widget>[
                  MaterialButton(

                    minWidth: double.infinity,
                    height: 60,
                    onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        
                    },

                    shape: RoundedRectangleBorder(

                      side: BorderSide(

                        color: Colors.black

                      ),

                      borderRadius: BorderRadius.circular(50)

                    ),

                    child: Text(

                      "Ingresar", 

                      style: TextStyle(

                        fontWeight: FontWeight.w600,
                        fontSize: 18

                      ),

                    ),

                  ),

                  //SIGUIENTE BOTÓN

                  SizedBox(
                    height: 20,
                  ),

                  Container(

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

                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));

                      },

                      color: Color.fromARGB(255, 139, 194, 68),
                      elevation: 0,

                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(50)

                      ),

                      child: Text(

                        "Registrarse", 

                        style: TextStyle(
                          
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18

                        ),

                      ),

                    ),

                  )

                ],

              )

            ],

          )

        ),
      
      ),

    );

  }

}
