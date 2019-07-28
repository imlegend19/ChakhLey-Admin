import 'dart:io';
import 'dart:convert' as JSON;

import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/home_page.dart';
import 'package:chakh_le_admin/pages/otp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'models/user_post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chakh Le - Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          elevation: 0
        )
      ),
      home: LoginPage(
        title: "ChakhLe - Login",
      ),
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => HomePage(),
      },
    );
  }
}

String buttonText = "ENTER MOBILE";
bool enableLogin = false;
bool enableOtp = false;

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Avenir - Bold', fontSize: 15.0);
  TextEditingController _phnController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _phnController.addListener(getButtonText);
  }

  void getButtonText() {
    if (_phnController.text.length != 10) {
      setState(() {
        buttonText = "ENTER VALID MOBILE";
        enableLogin = false;
      });
    } else {
      setState(() {
        enableLogin = true;
        buttonText = "SEND OTP";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final phnField = TextField(
      style: style,
      controller: _phnController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          hintText: "Mobile Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.redAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: enableLogin
            ? () {
          loginUserPost();
              }
            : null,
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 130.0,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    phnField,
                    SizedBox(
                      height: 35.0,
                    ),
                    loginButton,
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<http.Response> createPost(LoginPost post) async {
    final response = await http.post(UserStatic.keyOtpURL,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: postLoginToJson(post));

    return response;
  }
  
  loginUserPost() {
    LoginPost post = LoginPost(
      destination: _phnController.text,
      isLogin: "true",
    );

    // ignore: missing_return
    createPost(post).then((response) {
      if (response.statusCode == 201) {
        print(response.body);
        Navigator.of(context).pop();
        showOTPBottomSheet(context, _phnController.text, true);
        Fluttertoast.showToast(
          msg: "OTP has been sent to your registered email.",
          fontSize: 13.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 2,
        );
        return "true";
      } else if (response.statusCode == 403) {
        // OTP requesting not allowed
        var json = JSON.jsonDecode(response.body);
        assert(json is Map);
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: json['detail'],
          fontSize: 13.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 2,
        );
      } else if (response.statusCode == 400) {
        print(response.statusCode);
      } else {
        print(response.statusCode);
      }
    }).catchError((error) {
      print('error : $error');
    });
  }
}
