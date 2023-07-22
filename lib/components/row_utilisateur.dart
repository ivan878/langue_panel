import 'package:flutter/material.dart';

Widget rowUtilisateur(
    String nom, String email, String numero, String image, void fn()) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          maxRadius: 25,
          backgroundImage: AssetImage(image),
        ),
        Text(
          nom,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          email,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
        ),
        Text(
          numero,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
        ),
        ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
            onPressed: () {
              fn();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text('Supprimer'),
            )),
      ],
    ),
  );
}

Widget rowInstructeur(
    String nom, String email, String numero, String image, void fn()) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          maxRadius: 25,
          backgroundImage: AssetImage(image),
        ),
        Text(
          nom,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          email,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
        ),
        Text(
          numero,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
        ),
        Row(
          children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 24, 102, 218)),
                    shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  fn();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Text(
                    'Modifier',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 255, 40, 54)),
                    shape: MaterialStateProperty.all(ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  fn();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Text(
                    'Supprimer',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )),
          ],
        ),
      ],
    ),
  );
}
