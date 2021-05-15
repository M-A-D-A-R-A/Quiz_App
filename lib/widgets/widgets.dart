import 'package:flutter/material.dart';

class appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 22
        ),
        children: <TextSpan>[
          TextSpan(text: 'IITV', style: TextStyle(fontWeight: FontWeight.w600
              , color: Colors.black54)),
          TextSpan(text: 'Quiz', style: TextStyle(fontWeight: FontWeight.w600
              , color: Colors.blue)),
        ],
      ),
    );
  }
}

Widget blueButton({BuildContext context, String label,buttonWidth}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(30)),
    height: 60,
    alignment: Alignment.center,
    width:buttonWidth!=null?buttonWidth: MediaQuery.of(context).size.width - 12,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}
