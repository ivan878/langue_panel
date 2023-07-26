import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panel_langues/commons/fonctions.dart';
import 'package:panel_langues/commons/style.dart';
import 'package:panel_langues/controllers/user_controller.dart';
import 'package:panel_langues/providers/user_provider.dart';
import 'package:panel_langues/views/screen/application.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSessionsave = false;
  bool showpass = true;
  bool loading = false;

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
                  key: formKey,
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
                        'User Email',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      spacerheight(10),
                      TextFormField(
                        controller: controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: primarystyle,
                        validator: (val) {
                          return val == null || val.trim().isEmpty
                              ? 'L\'email est obligatoire '
                              : !EmailValidator.validate(val)
                                  ? 'Email incorrecte'
                                  : null;
                        },
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
                        controller: controllerPass,
                        validator: (val) {
                          if (val == null ||
                              val.trim().isEmpty ||
                              val.length < 6) {
                            return 'entrer un mot de passe correcte';
                          } else {
                            return null;
                          }
                        },
                        style: primarystyle,
                        obscureText: showpass,
                        decoration: InputDecoration(
                            hintText: 'Entrez votre mots de passe',
                            prefixIcon: const Icon(Icons.lock),
                            filled: true,
                            suffixIcon: IconButton(
                                onPressed: () => setState(() {
                                      showpass = !showpass;
                                    }),
                                icon: Icon(showpass
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
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
                        child: loading
                            ? SizedBox(
                                height: 55,
                                child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    )),
                              )
                            : ElevatedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        ContinuousRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    try {
                                      await UserController()
                                          .loginUser(
                                        controllerEmail.text,
                                        controllerPass.text,
                                      )
                                          .then((value) async {
                                        if (value['statu'] == true) {
                                          await UserController()
                                              .getUser(context)
                                              .then((user) async {
                                            printer(value);
                                            if (user != null) {
                                              final userProvider =
                                                  UserProvider.user;
                                              userProvider.setCurrentUser(user);
                                              if (userProvider.currenUser !=
                                                  null) {
                                                await userProvider
                                                    .saveCurrentUser(user)
                                                    .then((val) {
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    PageTransition(
                                                      child:
                                                          const Application(),
                                                      type: PageTransitionType
                                                          .leftToRight,
                                                    ),
                                                    (rout) => false,
                                                  );
                                                });
                                              } else {
                                                userProvider.logOut();
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                  PageTransition(
                                                    child: const Login(),
                                                    type: PageTransitionType
                                                        .leftToRight,
                                                  ),
                                                  (rout) => false,
                                                );
                                              }
                                            } else {
                                              setState(() {
                                                loading = false;
                                              });
                                              toasterError(context,
                                                  "Impossible de récuperer les données dns le serveur");
                                            }
                                          });
                                        } else {
                                          setState(() {
                                            loading = false;
                                          });
                                          toasterError(
                                              context, value['message']);
                                        }
                                      });
                                    } catch (e) {
                                      setState(() {
                                        loading = false;
                                      });
                                      // ignore: use_build_context_synchronously
                                      toasterError(context, e.toString());
                                    }
                                  }
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
