import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilCarta extends StatelessWidget {
  const PerfilCarta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.6,
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(children: [
          Text(
            'MI PERFIL',
            style: GoogleFonts.josefinSans(
                fontSize: 30, fontWeight: FontWeight.bold),
          ),
          ClipOval(
            child: Image.asset('assets\img\perfil.jpeg'),
          ),       
          Text.rich(
            TextSpan(text: 'Anthony Avila\n', 
            style: GoogleFonts.josefinSans(
              fontSize: 30, 
              fontWeight: FontWeight.bold
              ),  
              children: [
                TextSpan(text: 'anthony@correo.com',
                style: GoogleFonts.josefinSans(
                fontSize: 20, 
                color: Colors.black38
                ),
                )
              ]
              ),
          )
        ]),
      ),
    );
  }
}