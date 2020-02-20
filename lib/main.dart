import 'dart:async';
import 'dart:convert' as JSON;
import 'dart:io';
import 'package:chakh_le_admin/entity/api_static.dart';
import 'package:chakh_le_admin/home_page.dart';
import 'package:chakh_le_admin/pages/otp.dart';
import 'package:chakh_le_admin/static_variables/static_variables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sentry/sentry.dart';
import 'models/user_post.dart';
import 'models/user_pref.dart';
import 'utils/error_widget.dart';

final SentryClient _sentry = SentryClient(dsn: ConstantVariables.sentryDSN);

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  // print('Caught error: $error');

  // Errors thrown in development mode are unlikely to be interesting. You can
  // check if you are running in dev mode using an assertion and omit sending
  // the report.
  if (isInDebugMode) {
    print(stackTrace);
    print('In dev mode. Not sending report to Sentry.io.');
    return;
  }

  // print('Reporting to Sentry.io...');
  await _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );
}

void main() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZoned(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return getErrorWidget(context);
    };

    return MaterialApp(
      title: 'Chakh Ley - Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red, appBarTheme: AppBarTheme(elevation: 0)),
      home: LoginPage(),
      builder: (BuildContext context, Widget widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return getErrorWidget(context);
        };

        return widget;
      },
      debugShowMaterialGrid: false,
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => HomePage(),
        '/loginpage': (BuildContext context) => LoginPage(),
      },
    );
  }
}

String buttonText = "ENTER MOBILE";
bool enableLogin = false;
bool enableOtp = false;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Avenir - Bold', fontSize: 15.0);
  TextEditingController _phnController = TextEditingController();
  bool loggedIn = true;

  @override
  void initState() {
    super.initState();

    getDetails().then((val) {
      ConstantVariables.user = val;
    });

    isLoggedIn().then((val) {
      if (val) {
        Navigator.pushReplacementNamed(context, '/homepage');
      } else {
        setState(() {
          // Navigator.pushReplacementNamed(context, '/homepage'); 
          loggedIn = false;
        });
      }
    });

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );

    final loginButton = Material(
      elevation: enableLogin ? 5.0 : 0.0,
      borderRadius: BorderRadius.circular(30.0),
      color: enableLogin ? Colors.redAccent : Colors.red.shade200,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: enableLogin
            ? () {
                setState(() {
                  enableLogin = false;
                });
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
      body: loggedIn
          ? Container()
          : SingleChildScrollView(
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
            ),
    );
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
        // print(response.body);
        setState(() {
          enableLogin = false;
        });
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
        Fluttertoast.showToast(
          msg: json['detail'],
          fontSize: 13.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 2,
        );
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
          msg: "Not a valid admin!",
          fontSize: 13.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 2,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Not a valid admin!",
          fontSize: 13.0,
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIos: 2,
        );
      }
    }).catchError((error) {
      print('error : $error');
    });
  }
}
