import 'package:flutter/material.dart';
import 'package:ummicare/screens/auth/staff_registration/staffRegistration.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/shared/loading.dart';
import 'package:ummicare/shared/constant.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool loading = false;

  //current text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xff71cbca),
            // appBar: AppBar(
            //   backgroundColor: Colors.grey[500],
            //   elevation: 0.0,
            //   title: Text('Register new user account'),
            //   actions: <Widget>[
            //     TextButton.icon(
            //       icon: Icon(
            //         Icons.person,
            //         color: Colors.black,
            //       ),
            //       label: Text(
            //         'Sign In',
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
                              fontWeight: FontWeight.bold),
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
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xfff29180)),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerParentWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    errorMessage =
                                        'Please enter a valid email and password';
                                  });
                                }
                              }
                            }),
                        // ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: Color(0xfff29180)),
                        // child: Text(
                        //   'Register As Staff',
                        //   style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        // ),
                        // onPressed: () async {
                        //   if (_formKey.currentState!.validate()) {
                        //     setState(() => loading = true);
                        //     dynamic result = await _auth
                        //         .registerWithEmailAndPassword(email, password);
                        //     if (result == null) {
                        //       setState(() {
                        //         loading = false;
                        //         errorMessage =
                        //             'Please enter a valid email and password';
                        //       });
                        //     }
                        //   }
                        // }),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () => widget.toggleView(),
                          child: Text(
                            'Sign In here',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Registration for staff?',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => staffRegistration()));
                          },
                          child: Text(
                            'Click here',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
