import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class teacherMain extends StatefulWidget {
  const teacherMain({super.key});

  @override
  State<teacherMain> createState() => _teacherMainState();
}

class _teacherMainState extends State<teacherMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Teacher',
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
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.go('/admin/teacher/pending');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xff8290F0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.pending_actions_rounded,
                          color: Colors.white,
                          size: 65,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Pending Teacher',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'All the teacher application that are still in pending status.',
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.go('/admin/teacher/rejected');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xff8290F0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.cancel_outlined,
                          color: Colors.white,
                          size: 65,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Rejected Teacher',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'All the teacher application that has been rejected by administrator.',
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.go('/admin/teacher/verified');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xff8290F0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.verified_outlined,
                          color: Colors.white,
                          size: 65,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Verified Teacher',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'All teacher that have been verified by administrator.',
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.go('/admin/teacher/report');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xff8290F0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.comment,
                          color: Colors.white,
                          size: 65,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Report and Feedback',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Reports and feedback submitted by teachers and parents.',
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.go('/admin/teacher/announcement');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xff8290F0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.campaign,
                          color: Colors.white,
                          size: 65,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Announcement',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Announcement to publish to all teachers user.',
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.go('/admin/teacher/school');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xff8290F0),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        const Icon(
                          Icons.school,
                          color: Colors.white,
                          size: 65,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'School',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Register and manage school data.',
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 4,
                child: Container(),
              )
            ],
          )
        ],
      ),
    );
  }
}