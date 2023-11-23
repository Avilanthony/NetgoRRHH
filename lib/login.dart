// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recursos_humanos_netgo/signup.dart';
import 'package:recursos_humanos_netgo/model/dashboard/dashboard.dart';

class LoginPage extends StatelessWidget {
  
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
              
                          makeInput(label: "Usuario"),
                          makeInput(label: "Contraseña", obsecureText: true),
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
    
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
    
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

  //CLASES

  Widget makeInput({label, obsecureText = false}){

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