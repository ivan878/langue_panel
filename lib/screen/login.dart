import 'package:flutter/material.dart';
import 'package:panel_langues/application.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/back.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(31, 18, 17, 17)),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'C O N N E X I O N',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'User ID',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Entrez votre identifiants',
                        prefixIcon: const Icon(Icons.person_2_rounded),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Entrez votre mots de passe',
                        prefixIcon: const Icon(Icons.lock),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Application()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Text('CONNECTEZ VOUS '),
                        )),
                  )
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
