import 'package:flutter/material.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool loading = false;

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xff71cbca),
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0.0,
            //   title: Text('Sign In To Your Account'),
            //   actions: <Widget>[
            //     TextButton.icon(
            //       icon: Icon(
            //         Icons.person,
            //         color: Colors.black,
            //       ),
            //       label: Text(
            //         'Register',
            //         style: TextStyle(color: Colors.black),
            //       ),
            //       onPressed: () => widget.toggleView(),
            //     )
            //   ],
            // ),
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 200.0,
                      child: Center(
                        child: Text(
                          'UmmiCare',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold
                          ),
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
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (value) => value!.length < 8
                          ? 'Enter a password with more than 8 characters'
                          : null,
                      onChanged: (value) => {setState(() => password = value)},
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xfff29180)),
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              errorMessage =
                                  'Account details entered is not available';
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () => widget.toggleView(),
                          child: Text(
                            'Register here',
                            style: TextStyle(
                              color: Colors.black, 
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
