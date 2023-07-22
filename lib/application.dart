import 'package:flutter/material.dart';
import 'package:panel_langues/screen/apropos.dart';
import 'package:panel_langues/screen/instituteurs.dart';
import 'package:panel_langues/screen/langues.dart';
import 'package:panel_langues/screen/paiements.dart';
import 'package:panel_langues/screen/utilisateurs.dart';
import 'package:sidebarx/sidebarx.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  List<Widget> body = [
    const Utilisateurs(),
    const Paiement(),
    const Langues(),
    const Instituteurs(),
    const Apropos(),
  ];
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SidebarX(
            controller: SidebarXController(
                selectedIndex: selectedindex, extended: true),
            theme: SidebarXTheme(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              hoverColor: const Color.fromARGB(255, 101, 154, 233),
              selectedTextStyle: const TextStyle(color: Colors.white),
              itemTextPadding: const EdgeInsets.only(left: 30),
              selectedItemTextPadding: const EdgeInsets.only(left: 30),
              itemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: const Color.fromARGB(255, 23, 87, 184)),
              ),
              selectedItemDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 23, 87, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              iconTheme: const IconThemeData(
                size: 25,
              ),
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
                size: 20,
              ),
            ),
            extendedTheme: const SidebarXTheme(
              width: 200,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
            ),
            footerDivider: const Divider(),
            headerBuilder: (context, extended) {
              return SizedBox(
                height: 100,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      color: Colors.blue,
                    )
                    // Image.asset('assets/dash.png'),
                    ),
              );
            },
            items: [
              SidebarXItem(
                label: "Utilisateurs",
                icon: Icons.person_2_sharp,
                onTap: () {
                  setState(() {
                    selectedindex = 0;
                  });
                },
              ),
              SidebarXItem(
                label: "Paiements",
                icon: Icons.trending_up_sharp,
                onTap: () {
                  setState(() {
                    selectedindex = 1;
                  });
                },
              ),
              SidebarXItem(
                label: "Langues",
                icon: Icons.bookmark_border,
                onTap: () {
                  setState(() {
                    selectedindex = 2;
                  });
                },
              ),
              SidebarXItem(
                label: "Instituteurs",
                icon: Icons.person_2_outlined,
                onTap: () {
                  setState(() {
                    selectedindex = 3;
                  });
                },
              ),
              SidebarXItem(
                label: "Apropos",
                icon: Icons.info_outline,
                onTap: () {
                  setState(() {
                    selectedindex = 4;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: body[selectedindex],
          )
        ],
      )),
    );
  }
}

// ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   backgroundColor: Colors.red,
//                                   content: Text(
//                                       'Impossible d effectuer la suppression ')));
