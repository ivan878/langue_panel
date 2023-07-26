import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panel_langues/commons/fonctions.dart';
import 'package:panel_langues/commons/style.dart';
import 'package:panel_langues/controllers/langue_controller.dart';
import 'package:panel_langues/models/langues.dart';
import 'package:panel_langues/views/screen/lecons_page.dart';

class Langues extends StatefulWidget {
  const Langues({super.key});

  @override
  State<Langues> createState() => _LanguesState();
}

List<Map<String, dynamic>> liste = [];

class _LanguesState extends State<Langues> {
  List<Langue>? allUser;
  bool loading = true;
  String? error;

  initUserApp() async {
    await LangueController().getAllLangages(context).then((value) {
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Liste des langues diisponible',
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
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : error != null
                    ? Center(
                        child: Text(
                          error ??
                              "Erreur inconnue l'ors de la récupérations des langes",
                          style: primarystyle17.copyWith(color: Colors.red),
                        ),
                      )
                    : SingleChildScrollView(
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          padding: const EdgeInsets.all(10.0),
                          children: allUser!
                              .map(
                                (e) => InkWell(
                                    onTap: () {
                                      printer(e.toMap());
                                      Navigator.of(context).push(
                                        PageTransition(
                                            child: LeconPage(langue: e),
                                            type:
                                                PageTransitionType.leftToRight),
                                      );
                                    },
                                    child: langueModeUi(e)),
                              )
                              .toList(),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget langueModeUi(Langue e) {
    return SizedBox(
        width: 300,
        child: Container(
          height: 180,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        e.langue_name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        e.langue_origine ?? ' ',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Container(
                height: 120,
                child: Image.asset('assets/dash.png'),
              )
            ],
          ),
        ));
  }

  // Modal d'ajout de la langue

  final fomrkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  bool loadingadd = false;
  TextEditingController regionController = TextEditingController();

  Future<void> showModal2() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builder) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Ajouter un instructeur'),
              content: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 300,
                child: Column(
                  children: [
                    const Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
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
                        Form(
                          key: fomrkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nom de la langue',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  style: primarystyle17,
                                  controller: nameController,
                                  validator: (val) {
                                    return (val == null || val.length < 3)
                                        ? 'Entrer un nom correcte'
                                        : null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Entrez le nom de la langue',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Region d\'origine de la lange',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  style: primarystyle17,
                                  controller: regionController,
                                  validator: (val) {
                                    return (val == null || val.length < 3)
                                        ? 'Entrer un nom de région correcte'
                                        : null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "entrez la région",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              actions: loadingadd
                  ? [
                      SizedBox(
                        width: 100,
                        child: loadingWidget(() {
                          setState(() {
                            loadingadd = false;
                          });
                        }),
                      )
                    ]
                  : [
                      // Boutton pour annuler

                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 43, 255, 40)),
                              shape: MaterialStateProperty.all(
                                  ContinuousRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Text(
                              'Anuller',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),

                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 43, 255, 40)),
                              shape: MaterialStateProperty.all(
                                  ContinuousRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () async {
                            if (fomrkey.currentState!.validate()) {
                              try {
                                setState(() => loadingadd = true);
                                final Langue langue = Langue(
                                  langue_name: nameController.text,
                                  langue_origine: regionController.text,
                                );
                                await LangueController()
                                    .createLangue(context, langue)
                                    .then((value) {
                                  setState(() => loadingadd = false);
                                  if (value == true) {
                                    Navigator.of(context).pop();
                                  }
                                });
                              } catch (except) {
                                setState(() => loadingadd = false);
                                // ignore: use_build_context_synchronously
                                toasterError(context, except.toString());
                              }
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            child: Text(
                              'Ajouter',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )),
                    ],
            );
          });
        });
  }
}
