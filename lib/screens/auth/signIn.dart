import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:go_router/go_router.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:ummicare/screens/auth/forgotPassword.dart';
import 'package:ummicare/screens/auth/staff_registration/advisorRegistration.dart';
import 'package:ummicare/screens/auth/staff_registration/medicalStaffRegistration.dart';
import 'package:ummicare/screens/auth/staff_registration/staffRegistration.dart';
import 'package:ummicare/screens/auth/staff_registration/teacherRegistration.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/emailService.dart';
import 'package:ummicare/shared/constant.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool loading = false;

  //reset password
  bool resetPasswordStatus = true;

  //text field state
  String email = '';
  String password = '';

  int page = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      page = widget.currentPage;
    });
  }

//   final Email send_email = Email(
//   body: 'body of email',
//   subject: 'subject of email',
//   recipients: ['farhanaziz3112@gmail.com'],
//   cc: ['farhanaziz3112@gmail.com'],
//   bcc: ['farhanaziz3112@gmail.com'],
//   attachmentPaths: [''],
//   isHTML: false,
// );

  //assets/background/authbg.png is the right way
  //if still cannot, put / at the front

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff71cbca),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: 800,
              width: 800,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: page == 0
                        ? const AssetImage("assets/background/authbg.png")
                        : page == 1
                            ? const AssetImage(
                                "assets/background/forgotpasswordbg.png")
                            : const AssetImage("assets/background/registerbg.png"),
                    fit: BoxFit.contain),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: VerticalDivider(
                color: Colors.grey[700],
                thickness: 1,
              ),
            ),
            page == 0
                ? Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 100),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Welcome to UmmiCare!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40.0,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Please insert your email and password to sign in.',
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 17),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Email'),
                              validator: (value) =>
                                  value!.isEmpty ? 'Enter an email' : null,
                              onChanged: (value) =>
                                  {setState(() => email = value)},
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              'Password',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 17),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  hintText: 'Password'),
                              obscureText: true,
                              validator: (value) => value!.length < 8
                                  ? 'Enter a password with more than 8 characters'
                                  : null,
                              onChanged: (value) =>
                                  {setState(() => password = value)},
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      page = 1;
                                    });
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              errorMessage,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14.0),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xfff29180),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email, password);
                                    context.go('/');
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
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      page = 2;
                                    });
                                  },
                                  child: const Text(
                                    'Register here',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : page == 1
                    ? Expanded(
                        child: resetPasswordStatus
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 100.0, horizontal: 50.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                                Icons.arrow_back_ios),
                                            onPressed: () {
                                              setState(() {
                                                page = 0;
                                              });
                                            },
                                          ),
                                          const Text(
                                            'Sign In Page',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 40.0,
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Please insert your email and a link to changing password will be sent.',
                                        style:
                                            TextStyle(color: Colors.grey[800]),
                                      ),
                                      const SizedBox(
                                        height: 70,
                                      ),
                                      TextFormField(
                                        decoration: textInputDecoration
                                            .copyWith(hintText: 'Email'),
                                        validator: (value) => value!.isEmpty
                                            ? 'Enter an email'
                                            : null,
                                        onChanged: (value) =>
                                            {setState(() => email = value)},
                                      ),
                                      const SizedBox(height: 20.0),
                                      Text(
                                        errorMessage,
                                        style: const TextStyle(
                                            color: Colors.red, fontSize: 14.0),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Container(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xfff29180),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          child: const Text(
                                            'Reset Password',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              dynamic result = await _auth
                                                  .resetPassword(email);
                                              if (result = true) {
                                                setState(() {
                                                  resetPasswordStatus = false;
                                                });
                                              }
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 100.0, horizontal: 50.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          icon:
                                              const Icon(Icons.arrow_back_ios),
                                          onPressed: () {
                                            setState(() {
                                              page = 0;
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Sign In Page',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 40.0,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Please insert your email and a link to changing password will be sent.',
                                      style: TextStyle(color: Colors.grey[800]),
                                    ),
                                    const SizedBox(
                                      height: 70,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 10, 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: const Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Icon(Icons.info),
                                          ),
                                          Expanded(
                                            flex: 6,
                                            child: Text(
                                              'A link has been sent to your email. Kindly check your email and click on the link to reset the password. If there is no email received, please go back and try again.',
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      )
                    : Expanded(
                        child: Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 100),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back_ios),
                                      onPressed: () {
                                        setState(() {
                                          page = 0;
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Sign In Page',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                const Text(
                                  'Staff Registration',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40.0,
                                      fontFamily: 'Comfortaa',
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Choose your role.',
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xfff29180),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            30.0)),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 0),
                                                  child: const Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.support_agent,
                                                        size: 50.0,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        'Advisor',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const advisorRegistration()));
                                                },
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xfff29180),
                                                  minimumSize:
                                                      const Size.fromHeight(
                                                          30.0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 0),
                                                  child: const Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.school,
                                                        size: 50.0,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        'Teacher',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const teacherRegistration()));
                                                },
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xfff29180),
                                                  minimumSize:
                                                      const Size.fromHeight(
                                                          30.0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 0),
                                                  child: const Column(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.health_and_safety,
                                                        size: 50.0,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        'Medical Staff',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const medicalStaffRegistration()));
                                                },
                                              ),
                                            ],
                                          ),
                                        )),
                                    Expanded(flex: 1, child: Container())
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
