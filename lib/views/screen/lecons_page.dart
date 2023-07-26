// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:panel_langues/commons/constances.dart';
import 'package:panel_langues/commons/fonctions.dart';
import 'package:panel_langues/commons/style.dart';
import 'package:panel_langues/controllers/lecon_controller.dart';
import 'package:panel_langues/controllers/module_controller.dart';
import 'package:panel_langues/models/langues.dart';
import 'package:panel_langues/models/lecon_model.dart';
import 'package:panel_langues/models/module.dart';

class LeconPage extends StatefulWidget {
  final Langue langue;
  const LeconPage({super.key, required this.langue});
  @override
  State<LeconPage> createState() => _LeconPageState();
}

class _LeconPageState extends State<LeconPage> {
  late Langue langue;

  @override
  void initState() {
    langue = widget.langue;
    initModules();
    super.initState();
  }

  initModules() async {
    await ModuleController().getAllModules(context, langue).then((value) async {
      loadin = false;
      if (value != null) {
        modules = value;
        if (modules.isNotEmpty) {
          seletedmodule = modules[0].module_id!;
          await iniLecons();
        } else {
          loadinLecon = false;
        }
      } else {
        loadinLecon = false;
      }
      setState(() {});
    });
  }

  iniLecons() async {
    setState(() {
      loadinLecon = true;
    });
    await LeconController().getAllLecons(context, seletedmodule!).then((value) {
      loadinLecon = false;
      if (value != null) lecons = value;
      setState(() {});
    });
  }

  loadModuleList() async {
    await ModuleController().getAllModules(context, langue).then((value) {
      loadin = false;
      if (value != null) {
        modules = value;
      }
      setState(() {});
    });
  }

  int? seletedmodule;
  List<Module> modules = [];
  List<Lecon> lecons = [];
  bool loadin = true;
  bool loadinLecon = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(langue.langue_name, style: primarystyle17),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rowModules(),
            spacerheight(20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: loadinLecon
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ...lecons.map(
                            (lecon) => leconModeUi(lecon, false),
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (seletedmodule == null) {
              toasterError(context, "Aucun module n'est séléctionné");
            } else {
              showModalLecon();
            }
          },
          label: Text("Ajouter un cour", style: primarystyle17)),
    );
  }

  ///
  ///function de récupération des fichiers
  ///

  Future<void> pickFileVoice() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final fileName = result.files.first.name;
      final fichier = File(result.files.single.path!);
      voice_cour = fichier;
      voiceName = fileName;
    }
  }

  SizedBox rowModules() {
    return SizedBox(
      height: 70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
                onPressed: () => showModalModule(),
                child: Text('Ajouter un module', style: primarystyle17),
              ),
            ),
            spacerwidth(15),
            if (!loadin)
              ...modules
                  .map(
                    (module) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                        label: Text(module.module_name),
                        selected: seletedmodule == module.module_id,
                        onSelected: (val) async {
                          setState(() {
                            seletedmodule = module.module_id!;
                          });
                          await iniLecons();
                        },
                      ),
                    ),
                  )
                  .toList()
            else
              const SizedBox(
                width: 250,
                child: LinearProgressIndicator(
                  minHeight: 20,
                ),
              )
          ],
        ),
      ),
    );
  }

  Future<void> showModalLecon() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext builder) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: ListTile(
                title: Text(
                  'Ajouter un cour',
                  style: primarystyle17,
                ),
                subtitle: Text(
                  error ?? '',
                  style: primarystyle.copyWith(color: Colors.red),
                ),
              ),
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
                          color: Colors.grey.shade300,
                          width: 130,
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await pickFileVoice()
                                      .then((value) => setState(() {}));
                                },
                                icon: const Icon(
                                  Icons.file_upload_outlined,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                              ),
                              spacerheight(5),
                              Text(
                                voiceName ?? "Acune image sélectionné",
                                style: primarystyle17,
                              )
                            ],
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
                                'Titre de la lecon',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  style: primarystyle17,
                                  controller: controllerTitre,
                                  validator: (val) {
                                    return (val == null || val.length < 3)
                                        ? 'Entrer un titre correcte'
                                        : null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Titre de la lecon',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Description du cours',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  style: primarystyle17,
                                  controller: controllerDesc,
                                  validator: (val) {
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "Description",
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

// Pour valider l'ajout
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 43, 255, 40)),
                              shape: MaterialStateProperty.all(
                                  ContinuousRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          onPressed: () async {
                            if (fomrkey.currentState!.validate() &&
                                voice_cour != null) {
                              setState(() => loadingadd = true);
                              final Lecon langue = Lecon(
                                voice_lecon: voice_cour,
                                image_lecon: image_cour,
                                lecon_title: controllerTitre.text,
                                lecon_description: controllerDesc.text,
                                module_id: seletedmodule!,
                              );
                              await LeconController()
                                  .createLecon(langue)
                                  .then((value) async {
                                setState(() => loadingadd = false);
                                if (value['statu'] == true) {
                                  controllerTitre.clear();
                                  Navigator.of(context).pop();
                                  await iniLecons();
                                } else {
                                  error = '${value['message']}';
                                  setState(() {});
                                  toasterError(context, value['message']);
                                }
                              });
                            } else {
                              voiceName = "Le fichier est obligatoire";
                              setState(() {});
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

  ///
  ///Les varibale du formulaire d'ajout du Module.
  ///
  TextEditingController prixController = TextEditingController();

  ///
  ///Ajout du module
  ///

  Future<void> showModalModule() async {
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
                          color: const Color.fromARGB(255, 212, 211, 211),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.file_upload_outlined,
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
                                'Titre du module',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  style: primarystyle17,
                                  controller: controllerTitre,
                                  validator: (val) {
                                    return (val == null || val.length < 3)
                                        ? 'Entrer un titre correcte'
                                        : null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Titre du module',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Prix du module',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: TextFormField(
                                  style: primarystyle17,
                                  controller: prixController,
                                  validator: (val) {
                                    try {
                                      double.parse(val!.trim());
                                      return null;
                                    } catch (e) {
                                      return "Entrer un nombre correcte";
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: "prix du module",
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
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

// Pour valider l'ajout
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
                              setState(() => loadingadd = true);
                              final Module langue = Module(
                                module_name: controllerTitre.text,
                                module_price: double.parse(prixController.text),
                                image_module: image_module,
                                langue_id: widget.langue.langue_id!,
                              );
                              await ModuleController()
                                  .createModule(langue)
                                  .then((value) async {
                                setState(() => loadingadd = false);
                                if (value['statu'] == true) {
                                  await loadModuleList().then((val) {
                                    controllerTitre.clear();
                                    controllerDesc.clear();
                                    Navigator.of(context).pop();
                                  });
                                } else {
                                  toasterError(context, value['message']);
                                }
                              });
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

  ///
  ///Les variables du formaulaire d'ajour du cours
  ///

  final fomrkey = GlobalKey<FormState>();
  TextEditingController controllerTitre = TextEditingController();
  bool loadingadd = false;
  TextEditingController controllerDesc = TextEditingController();
  File? image_module;
  File? image_cour;
  File? voice_cour;
  String? voiceName;
  String? error;

  ///
  ///Wiget d'affichage de la lecons
  ///

  Widget leconModeUi(Lecon lecon, bool played) {
    return SizedBox(
        width: 200,
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
                        lecon.lecon_title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: primarystyle17,
                      ),
                      subtitle: Text(
                        lecon.lecon_description ?? ' ',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: primarystyle,
                      ),
                    ),
                    spacerheight(5),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () async {
                      printer('$base_get_url${lecon.lecon_voice}');
                      setState(() {
                        played = !played;
                      });
                      if (played)
                        await player.pause();
                      else {
                        player.play(
                            UrlSource('$base_get_url${lecon.lecon_voice}'));
                      }
                    },
                    icon: !played
                        ? const Icon(
                            Icons.play_circle_outlined,
                            size: 50,
                          )
                        : const Icon(
                            Icons.pause_circle_outlined,
                          ),
                  ),
                  spacerwidth(10),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 50),
                  )
                ],
              )
            ],
          ),
        ));
  }

  final player = AudioPlayer();
}
