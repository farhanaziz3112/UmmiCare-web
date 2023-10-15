import 'package:flutter/material.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/shared/constant.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool status = true;

  //text field state
  String email = '';

  @override
  Widget build(BuildContext context) {
    return status
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: Color(0xfff29180),
            ),
            backgroundColor: Color(0xff71cbca),
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: Text(
                          'Please insert your email. We will send a link to reset the password to your email.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter an email' : null,
                      onChanged: (value) => {setState(() => email = value)},
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff29180),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                      child: Text(
                        'Reset Password',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth.resetPassword(email);
                          if (result = true) {
                            setState(() {
                              status = false;
                            });
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: Color(0xfff29180),
            ),
            backgroundColor: Color(0xff71cbca),
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Text(
                'A link has been sent to your email. Kindly check your email and click on the link to reset the password. If there is no email received, please go back and try again.',
                textAlign: TextAlign.justify,
              ),
            ),
          );
  }
}
