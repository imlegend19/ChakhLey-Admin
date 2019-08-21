import 'package:chakh_le_admin/pages/select_product.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';

class AddOrderPage extends StatefulWidget {
  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  int selectedRestaurant;
  TextStyle style = TextStyle(fontFamily: 'Avenir - Bold', fontSize: 15.0);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phnController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  List _restaurantList = [];

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    if (ConstantVariables.restaurantList != null) {
      for (final i in ConstantVariables.restaurantList) {
        _restaurantList.add({
          "display": i.name,
          "value": i.id,
        });
      }
    }

    _isButtonEnabled = false;
    _nameController.addListener(validate);
    _phnController.addListener(validate);
  }

  validate() {
    if (_nameController != null &&
        _phnController.text.length == 10 &&
        selectedRestaurant != null) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
      child: Theme(
        data: ThemeData(cursorColor: Colors.red),
        child: TextFormField(
          controller: _nameController,
          cursorColor: Colors.red,
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'Avenir'),
          decoration: InputDecoration(
            labelText: "NAME",
            icon: Icon(
              Icons.person,
              color: Colors.red,
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              fontFamily: 'Avenir',
            ),
          ),
        ),
      ),
    );

    final phnField = Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
      child: Theme(
        data: ThemeData(cursorColor: Colors.red),
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: _phnController,
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'Avenir'),
          decoration: InputDecoration(
            labelText: "PHONE NUMBER",
            icon: Icon(Icons.phone_iphone),
            labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                fontFamily: 'Avenir'),
          ),
        ),
      ),
    );

    final emailField = Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
      child: Theme(
        data: ThemeData(cursorColor: Colors.red),
        child: TextFormField(
          controller: _emailController,
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              fontFamily: 'Avenir'),
          decoration: InputDecoration(
            labelText: "EMAIL",
            icon: Icon(Icons.mail),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              fontFamily: 'Avenir',
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text('Add Order')),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              nameField,
              phnField,
              emailField,
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                child: DropDownFormField(
                  titleText: 'Restaurant',
                  hintText: 'Please choose one',
                  value: selectedRestaurant,
                  onSaved: (value) {
                    setState(() {
                      selectedRestaurant = value;
                      validate();
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedRestaurant = value;
                      validate();
                    });
                  },
                  dataSource: _restaurantList,
                  textField: 'display',
                  valueField: 'value',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.redAccent,
                    disabledColor: Colors.red.shade200,
                    onPressed: _isButtonEnabled
                        ? () {
                            SelectProductPage.restaurantID = selectedRestaurant;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectProductPage(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  phoneNumber: _phnController.text.trim(),
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
