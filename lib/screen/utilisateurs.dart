import 'package:flutter/material.dart';
import 'package:panel_langues/components/row_utilisateur.dart';

class Utilisateurs extends StatefulWidget {
  const Utilisateurs({super.key});

  @override
  State<Utilisateurs> createState() => _UtilisateursState();
}

class _UtilisateursState extends State<Utilisateurs> {
  //fonction du modale
  Future<void> showModal() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builder) {
          return AlertDialog(
            title: const Text('INFORMATION SUPPLEMENTAIRE'),
            content: Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  const Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 300,
                        width: 300,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'nom',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Ivankouamou21@gmail.com',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Numéro: ' + ' +237 693807284',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Ville:' + ' Douala',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                          ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Text('Ajouter'),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'BIENVENU, I V A N',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 203, 202, 202)),
                  child: const Icon(
                    Icons.search,
                    size: 25,
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        showModal();
                      },
                      child: rowUtilisateur(
                          'nom', 'email', 'numero', 'assets/back.png', () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    'Impossible d effectuer la suppression ')));
                      }),
                    ))),
          ),
        ]),
      ),
    );
  }
}
