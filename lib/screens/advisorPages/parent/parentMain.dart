import 'package:flutter/material.dart';

class parentMain extends StatefulWidget {
  const parentMain({super.key});

  @override
  State<parentMain> createState() => _parentMainState();
}

class _parentMainState extends State<parentMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Parent',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.0,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
