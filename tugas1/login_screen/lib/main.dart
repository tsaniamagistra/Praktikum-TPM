import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFCDE0E7),
        body: Column(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: (MediaQuery.of(context).size.height) * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Cupid_Dash_BlueBG.width-635.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(21.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: buildInputDecoration('Email'),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        decoration: buildInputDecoration('Password'),
                        obscureText: true,
                      ),
                      SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: buildButtonStyle(),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(fontSize: 17.0, letterSpacing: 3.0, color: Colors.white),
                          ),

                        ),
                      ),
                      SizedBox(height: 15.0),
                      GestureDetector(
                        onTap: () {
                          print('Forgot Password? pressed');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
