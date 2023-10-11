import 'package:flutter/material.dart';
import 'package:ummicare/models/staffapplicationmodel.dart';
import 'package:ummicare/screens/admin_pages/staff/advisorApplication/advisorAllApplication.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/staffApplicationDatabaseService.dart';
import 'package:ummicare/shared/function.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class applicationPage extends StatefulWidget {
  const applicationPage({super.key, required this.applicationId});

  final String applicationId;

  @override
  State<applicationPage> createState() => _applicationPageState();
}

class _applicationPageState extends State<applicationPage> {
  staffApplicationDatabaseService _applicationDatabaseService =
      staffApplicationDatabaseService();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StaffApplicationModel>(
        stream: _applicationDatabaseService
            .advisorPendingApplication(widget.applicationId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            StaffApplicationModel? application = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Pending Application",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
              ),
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'First Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '${application!.firstName}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Last Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '${application.lastName}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Full Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '${application.fullName}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Email',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '${application.email}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Phone Number',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '${application.phoneNumber}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Supporting Document Link',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: InkWell(
                            onTap: () => launchUrl(Uri.parse(
                                '${application.supportingDocumentLink}')),
                            child: Text('${application.supportingDocumentLink}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline)),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Submission Date',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            '${convertTimeToDate(application.submissionDate)}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: (() {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                              'Confirmation Required'),
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
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const Text('Cancel'),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: (() {
                                                _applicationDatabaseService
                                                    .editStaffApplicationData(
                                                        application.firstName,
                                                        application.lastName,
                                                        application.fullName,
                                                        application.email,
                                                        application.phoneNumber,
                                                        application
                                                            .supportingDocumentLink,
                                                        application.userType,
                                                        'rejected',
                                                        application
                                                            .submissionDate,
                                                        application
                                                            .applicationId);
                                                Navigator.of(context)
                                                  ..pop()
                                                  ..pop();
                                              }),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text('Confirm'),
                                              ),
                                            )
                                          ],
                                        ));
                              }),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: Text(
                                'Reject',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: (() {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                              'Confirmation Required'),
                                          content: const Text(
                                            'The system will automatically register this user once you confirm this application. Are you sure you want to approve this user?\n\nAn email with account details will be sent to the user\'s email.',
                                            textAlign: TextAlign.start,
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: (() {
                                                Navigator.of(context).pop();
                                              }),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const Text('Cancel'),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: (() async {
                                                _authService
                                                    .registerStaffWithEmailAndPassword(
                                                        application.email,
                                                        'test1234',
                                                        application.userType);
                                                final Email email = Email(
                                                  body:
                                                      'Hello new user!\n\nWe are glad to inform to you that your application has been approved by our admin. The details about your new account can be seen below. Your account is now active and can be signed in.\n\nEmail: ${application.email}\nPassword: test1234\n\nThank you for applying with us!',
                                                  subject:
                                                      'UmmiCare Application Approval and Account Activation',
                                                  recipients: [
                                                    '${application.email}'
                                                  ],
                                                  isHTML: false,
                                                );
                                                await FlutterEmailSender.send(
                                                    email);
                                                _applicationDatabaseService
                                                    .editStaffApplicationData(
                                                        application.firstName,
                                                        application.lastName,
                                                        application.fullName,
                                                        application.email,
                                                        application.phoneNumber,
                                                        application
                                                            .supportingDocumentLink,
                                                        application.userType,
                                                        'passed',
                                                        application
                                                            .submissionDate,
                                                        application
                                                            .applicationId);
                                                Navigator.of(context)
                                                  ..pop()
                                                  ..pop();
                                              }),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text('Confirm'),
                                              ),
                                            )
                                          ],
                                        ));
                              }),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: Text(
                                'Approve',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
