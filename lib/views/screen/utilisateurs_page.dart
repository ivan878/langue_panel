import 'package:flutter/material.dart';
import 'package:panel_langues/controllers/user_controller.dart';
import 'package:panel_langues/models/app_user.dart';
import 'package:panel_langues/providers/user_provider.dart';
import 'package:panel_langues/views/components/row_utilisateur.dart';

class Utilisateurs extends StatefulWidget {
  const Utilisateurs({super.key});

  @override
  State<Utilisateurs> createState() => _UtilisateursState();
}

class _UtilisateursState extends State<Utilisateurs> {
  //fonction du modale
  Future<void> showModal(UserApp appuser) async {
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appuser.userName,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            appuser.userEmail,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Numéro: ${appuser.phone}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Ville: ${appuser.ville}',
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
                    child: Text('Fermer'),
                  )),
            ],
          );
        });
  }

  List<UserApp>? allUser;
  bool loading = true;
  String? error;

  initUserApp() async {
    await UserController().getAllUser(context).then((value) {
      loading = false;
      if (value == null) {
        error = "Impossible de récupérer les utilisateurs";
      } else {
        allUser = value;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    initUserApp();
    super.initState();
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
              Text(
                'Bonjour ${UserProvider.user.currenUser!.userName}',
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
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
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : error != null
                    ? Center(
                        child: Text(
                          error!,
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      )
                    : ListView.builder(
                        itemCount: allUser!.length,
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                showModal(allUser![index]);
                              },
                              child: rowUtilisateur(
                                  allUser![index], 'assets/back.png', () {
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
