import 'package:flutter/material.dart';
import 'package:panel_langues/components/row_utilisateur.dart';

class Instituteurs extends StatefulWidget {
  const Instituteurs({super.key});

  @override
  State<Instituteurs> createState() => _InstituteursState();
}

class _InstituteursState extends State<Instituteurs> {
  //fonction du modale
  Future<void> showModal2() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builder) {
          return AlertDialog(
            title: const Text('Ajouter un instructeur'),
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
                        color: const Color.fromARGB(255, 212, 211, 211),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'nom',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Entrez le nom',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "entrez l'Email",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Numero de Téléphone',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "entrez le Numero de Téléphone",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Ville',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "entrez la Ville",
                                border: OutlineInputBorder(),
                              ),
                            ),
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
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 43, 255, 40)),
                      shape: MaterialStateProperty.all(
                          ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Text(
                      'Ajouter',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'INSTRUCTEURS',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 43, 255, 40)),
                  shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              onPressed: () {
                showModal2();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                child: Text(
                  'Ajouter',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: rowInstructeur('nom', 'instructeur1@gmail.com',
                          '+237 699 99 69 99', 'assets/back.png', () {})))))
        ]),
      ),
      // bottomNavigationBar: CircleAvatar(
      //   maxRadius: 30,
      //   child: IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.add),
      //   ),
      // ),
    );
  }
}
