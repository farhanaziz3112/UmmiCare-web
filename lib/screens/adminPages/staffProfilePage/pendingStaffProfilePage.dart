import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/services/staffDatabase.dart';
import 'package:url_launcher/url_launcher.dart';

class pendingStaffProfilePage extends StatefulWidget {
  const pendingStaffProfilePage({super.key, required this.staffId});
  final String staffId;

  @override
  State<pendingStaffProfilePage> createState() =>
      _pendingStaffProfilePageState();
}

class _pendingStaffProfilePageState extends State<pendingStaffProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<staffUserModel>(
      stream: staffDatabase(staffId: widget.staffId).staffData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          staffUserModel? staff = snapshot.data;
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'User Type',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            staff!.staffUserType,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 150, maxWidth: 400),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Status',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Pending',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'First Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            staff.staffFirstName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 150, maxWidth: 400),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Last Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            staff.staffLastName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 150, maxWidth: 400),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Full Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            staff.staffFullName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Email',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            staff.staffEmail,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 150, maxWidth: 400),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Phone Number',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            staff.staffPhoneNumber,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Supporting Document Link',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: () =>
                        launchUrl(Uri.parse(staff.staffSupportingDocumentLink)),
                    child: Text(staff.staffSupportingDocumentLink,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            decoration: TextDecoration.underline)),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    onPressed: (() {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Confirmation Required'),
                                content: const Text(
                                  'Are you sure you want to reject this application?',
                                  textAlign: TextAlign.start,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: (() {
                                      Navigator.of(context).pop();
                                    }),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (() {
                                      adminDatabase().updateStaffData(
                                          staff.staffId,
                                          staff.staffUserType,
                                          staff.staffFullName,
                                          staff.staffFirstName,
                                          staff.staffLastName,
                                          staff.staffEmail,
                                          staff.staffPhoneNumber,
                                          staff.staffSupportingDocumentLink,
                                          staff.staffProfileImg,
                                          'rejected');
                                      context.go('/admin/${staff.staffUserType}/pending');
                                    }),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text('Confirm'),
                                    ),
                                  )
                                ],
                              ));
                    }),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        fixedSize: const Size(150, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide.none)),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Reject',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    onPressed: (() {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Confirmation Required'),
                                content: const Text(
                                  'The system will verify this user account. Are you sure you want to approve this user?\n\nAn email will be sent to the user to notify the account verification process.',
                                  textAlign: TextAlign.start,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: (() {
                                      Navigator.of(context).pop();
                                    }),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: (() async {
                                      adminDatabase().updateStaffData(
                                          staff.staffId,
                                          staff.staffUserType,
                                          staff.staffFullName,
                                          staff.staffFirstName,
                                          staff.staffLastName,
                                          staff.staffEmail,
                                          staff.staffPhoneNumber,
                                          staff.staffSupportingDocumentLink,
                                          staff.staffProfileImg,
                                          'true');
                                      context.go('/admin/${staff.staffUserType}/pending');
                                    }),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Text('Confirm'),
                                    ),
                                  )
                                ],
                              ));
                    }),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        fixedSize: const Size(150, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide.none)),
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Approve',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
