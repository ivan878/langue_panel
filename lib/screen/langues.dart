import 'package:flutter/material.dart';

class Langues extends StatefulWidget {
  const Langues({super.key});

  @override
  State<Langues> createState() => _LanguesState();
}

List<Map<String, dynamic>> liste = [];

class _LanguesState extends State<Langues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            padding: const EdgeInsets.all(10.0),
            children: liste
                .map(
                  (e) => SizedBox(
                      width: 300,
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 180,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.blue, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                const Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'test',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'test2',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'test3',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 130,
                                  child: Image.asset('assets/dash.png'),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
