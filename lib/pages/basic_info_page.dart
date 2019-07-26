import 'package:chakh_le_admin/utils/basic_details_card.dart';
import 'package:flutter/material.dart';

class BasicInfoPage extends StatefulWidget {
  @override
  _BasicInfoPageState createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return BasicDetailsCard('Surat','HOD Pizza','Jatin','jatin@gmail.com');
        },
      ),
    );
  }
}
