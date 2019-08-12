import 'package:chakh_le_admin/static_variables/static_variables.dart';
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
  List<DropdownMenuItem<int>> _restaurantList = [];

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    for (final i in ConstantVariables.restaurantList) {
      _restaurantList.add(
        DropdownMenuItem(
          child: Text(i.name),
          value: i.id,
        ),
      );
    }
    _isButtonEnabled = false;
    _nameController.addListener(validate);
    _phnController.addListener(validate);
  }

//  loadRestaurants() async {
//    fetchRestaurant(ConstantVariables.businessID).then((val) async {
//      _restaurantController.add(val);
//      return val;
//    });
//  }

  validate() {
    if (_nameController != null &&
        _phnController.text.length == 10 &&
        selectedRestaurant != null) {
      _isButtonEnabled = true;
    } else {
      _isButtonEnabled = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextField(
      style: style,
      controller: _nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        hintText: "Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );

    final phnField = TextField(
      style: style,
      controller: _phnController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        hintText: "Mobile Number",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );

    final emailField = TextField(
      style: style,
      controller: _emailController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
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
              SizedBox(height: 30.0),
              nameField,
              SizedBox(height: 30.0),
              phnField,
              SizedBox(height: 30.0),
              emailField,
              SizedBox(height: 30.0),
              DropdownButton(
                hint: Text(
                  "Select Restaurant",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                value: selectedRestaurant,
                onChanged: (newValue) {
                  setState(() {
                    selectedRestaurant = newValue;
                    validate();
                  });
                },
                items: _restaurantList,
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: RaisedButton(
                  color: Colors.deepPurpleAccent,
                  disabledColor: Colors.redAccent,
                  onPressed: _isButtonEnabled ? () {} : null,
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
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
