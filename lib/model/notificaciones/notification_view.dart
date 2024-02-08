import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 81, 124, 193),
        title: Text.rich(
          TextSpan(
              text: 'NOTIFICACIONES',
              style: GoogleFonts.josefinSans(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          textAlign: TextAlign.center,
        ),
      ),
      body: listView(),
    );
  }
}

PreferredSizeWidget appBar() {
  return AppBar(
    title: const Text('Notification Screen'),
  );
}

Widget listView() {
  return ListView.separated(
      itemBuilder: (context, index) {
        return listViewItems(index);
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 0);
      },
      itemCount: 15);
}

Widget listViewItems(int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        prefixIcon(),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              message(index),
              timeAndDate(index),
            ],
          ),
        ))
      ],
    ),
  );
}

Widget prefixIcon() {
  return Container(
    height: 50,
    width: 50,
    padding: const EdgeInsets.all(0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey.shade300,
    ),
    child: Icon(
      Icons.notifications,
      size: 25,
      color: Colors.grey.shade700,
    ),
  );
}

Widget message(int index) {
  double textSize = 14;
  return Container(
    child: RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
          text: 'Message',
          style: TextStyle(
              fontSize: textSize,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          children: const [
            TextSpan(
                text: 'Message Description',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ))
          ]),
    ),
  );
}

Widget timeAndDate(int index) {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '23-01-2021',
          style: TextStyle(fontSize: 10),
        ),
        Text(
          '07:10 a.m.',
          style: TextStyle(fontSize: 10),
        )
      ],
    ),
  );
}
