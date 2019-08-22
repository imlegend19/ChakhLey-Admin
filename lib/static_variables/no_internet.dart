import 'package:flutter/material.dart';

Widget buildNoInternet(BuildContext context) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height - 60.0,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Transform.translate(
            child:
                Image(image: AssetImage('assets/no_internet_connection.gif')),
            offset: Offset(0, -50),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Transform.translate(
            offset: Offset(0, -50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                'No connection',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Avenir-Black',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Transform.translate(
            offset: Offset(0, -40),
            child: Text(
              'Please check your internet connection and try again.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Avenir-Bold',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}
