import 'package:flutter/material.dart';

class Apropos extends StatefulWidget {
  const Apropos({super.key});

  @override
  State<Apropos> createState() => _AproposState();
}

class _AproposState extends State<Apropos> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 100,
              // backgroundImage: AssetImage('assets/dash.png'),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Version 1.20',
              style: TextStyle(fontWeight: FontWeight.w100),
            )
          ],
        ),
      ),
    );
  }
}
