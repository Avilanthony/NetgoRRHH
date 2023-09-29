import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPage();
}

class _TicketsPage extends State<TicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              const SizedBox(height: 50),
              Text(
                "Tickets".toUpperCase(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Text(
                "\nAqui puede crear su ticke \nal departamento de \nrecursos humanos",
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              const TicketWidget(
                width: 300,
                height: 500,
                isCornerRounded: true,
                child: Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 60,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/papi.jpg'),
                                  backgroundColor: Colors.black,
                                  radius: 55,
                                ),
                              ),
                              Text(
                                "Henry Cavil",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.archive,
                                      color: Colors.grey, size: 18),
                                  Text(
                                    'Dep. Contabilidad',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueGrey),
                                  )
                                ],
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Asunto',
                                  hintStyle: TextStyle(color: Colors.grey)
                                ),
                              ),
                              SizedBox(height: 20),
                              TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 90),
                                  border: InputBorder.none,
                                  hintText: 'Contexto',
                                  hintStyle: TextStyle(color: Colors.grey)
                                ),
                              )
                            ],
                            
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: 140,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Enviar'),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Color.fromARGB(255, 101, 166, 213),
        tabBackgroundColor: Color.fromARGB(255, 26, 26, 26),
        gap: 7,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Inicio',
          ),
          GButton(
            icon: Icons.airplane_ticket_rounded,
            text: 'Ticket',
          ),
          GButton(
            icon: Icons.picture_as_pdf_rounded,
            text: 'Documentos',
          ),
          GButton(
            icon: Icons.person,
            text: 'Perfil',
          ),
        ],
      ),
        );
  }
}
