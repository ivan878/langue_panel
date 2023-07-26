import 'package:flutter/material.dart';
import 'package:panel_langues/models/app_user.dart';

Widget rowUtilisateur(UserApp appuser, String image, void fn()) {
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
          appuser.userName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          appuser.userEmail,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
        ),
        Text(
          appuser.phone,
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

Widget rowInstructeur(UserApp app, String image, void fn()) {
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
          app.userName,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          app.userEmail,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
        ),
        Text(
          app.phone,
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
