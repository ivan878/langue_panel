import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

TextStyle primarystyle = GoogleFonts.poppins(fontSize: 15);
TextStyle primarystyle17 = GoogleFonts.poppins(fontSize: 17);

spacerheight(val) => SizedBox(height: double.parse(val.toString()));
spacerwidth(val) => SizedBox(width: double.parse(val.toString()));
Size taille(context) => MediaQuery.sizeOf(context);
// inputAppp() => TextFormField() ;

Widget leconModel(
    Color colors, String leconName, String leconTitle, leconDescription) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue.shade100,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      title: Text(
        leconTitle,
        style: primarystyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle:
          Text(leconDescription, overflow: TextOverflow.ellipsis, maxLines: 2),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            leconName,
            style: primarystyle.copyWith(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

Widget leconModelReading(Color colors, String leconName, String leconTitle,
    leconDescription, double percent) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue[50],
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      trailing: CircularPercentIndicator(
        radius: 25,
        percent: percent,
        progressColor: Colors.green,
        center: Text(
          '${(percent * 100).toInt()}%',
          style: GoogleFonts.poppins(),
        ),
      ),
      title: Text(
        leconTitle,
        style: primarystyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle:
          Text(leconDescription, overflow: TextOverflow.ellipsis, maxLines: 2),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            leconName,
            style: primarystyle.copyWith(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}

Widget loadingWidget(void Function()? onpress) => SizedBox(
      height: 55,
      child: ElevatedButton(
          onPressed: onpress,
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Center(
            child: CircularProgressIndicator(),
          )),
    );
