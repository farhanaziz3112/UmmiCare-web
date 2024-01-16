import 'package:flutter/material.dart';
import 'package:ummicare/screens/auth/signIn.dart';

class applicationCompletion extends StatefulWidget {
  const applicationCompletion({super.key});

  @override
  State<applicationCompletion> createState() => _applicationCompletionState();
}

class _applicationCompletionState extends State<applicationCompletion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Staff Registration",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xfff29180),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(top: 40.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Application completed!',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Kindly check your email for further notice about the application. Thank you for applying with UmmiCare!',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff8290F0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text(
                    'Go Back',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn(currentPage: 0,)));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
