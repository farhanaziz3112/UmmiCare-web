import 'package:flutter/material.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:url_launcher/url_launcher.dart';

class pendingApplicationPage extends StatefulWidget {
  const pendingApplicationPage({super.key, required this.staffId});

  final String staffId;

  @override
  State<pendingApplicationPage> createState() => _pendingApplicationPageState();
}

class _pendingApplicationPageState extends State<pendingApplicationPage> {
  // staffApplicationDatabaseService _applicationDatabaseService =
  //     staffApplicationDatabaseService();
  // AuthService _authService = AuthService();
  //DatabaseService _db = DatabaseService(userId: 'uF2hP0oVG4TFvOUeMfXM34kPocw2');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<staffUserModel>(
        stream: adminDatabase().staffData(widget.staffId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            staffUserModel? staff = snapshot.data;
            print(staff?.staffId);
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Pending Application",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 3,
                //iconTheme: IconThemeData(color: Colors.black),
              ),
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    child: Column(
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
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
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
                            onTap: () => launchUrl(Uri.parse(
                                staff.staffSupportingDocumentLink)),
                            child: Text(staff.staffSupportingDocumentLink,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline)),
                          ),
                        ),
                        const SizedBox(height: 30),
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
                                                Navigator.of(context)
                                                  ..pop()
                                                  ..pop();
                                              }),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const Text('Confirm'),
                                              ),
                                            )
                                          ],
                                        ));
                              }),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text(
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
                                            'The system will verify this user account. Are you sure you want to approve this user?\n\nAn email will be sent to the user to notify the account verification process.',
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
                                                Navigator.of(context)
                                                  ..pop()
                                                  ..pop();
                                              }),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: const Text('Confirm'),
                                              ),
                                            )
                                          ],
                                        ));
                              }),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: const Text(
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
            return Scaffold(
              appBar: AppBar(
                title: const Text('No Data'),
              ),
              body: const Text('No Data'),
            );
          }
        });
  }
}


// class _applicationPageState extends State<applicationPage> {
//   staffApplicationDatabaseService _applicationDatabaseService =
//       staffApplicationDatabaseService();
//   AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<StaffApplicationModel>(
//         stream: _applicationDatabaseService
//             .advisorPendingApplication(widget.applicationId),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             StaffApplicationModel? application = snapshot.data;
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text(
//                   "Pending Application",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 centerTitle: true,
//                 backgroundColor: Colors.white,
//                 iconTheme: IconThemeData(color: Colors.black),
//               ),
//               resizeToAvoidBottomInset: false,
//               body: Padding(
//                 padding: EdgeInsets.only(
//                     bottom: MediaQuery.of(context).viewInsets.bottom),
//                 child: SingleChildScrollView(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             'First Name',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             '${application!.firstName}',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             'Last Name',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             '${application.lastName}',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             'Full Name',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             '${application.fullName}',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             'Email',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             '${application.email}',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             'Phone Number',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             '${application.phoneNumber}',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             'Supporting Document Link',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: InkWell(
//                             onTap: () => launchUrl(Uri.parse(
//                                 '${application.supportingDocumentLink}')),
//                             child: Text('${application.supportingDocumentLink}',
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue,
//                                     decoration: TextDecoration.underline)),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             'Submission Date',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             '${convertTimeToDate(application.submissionDate)}',
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.normal,
//                                 color: Colors.black),
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: <Widget>[
//                             ElevatedButton(
//                               onPressed: (() {
//                                 showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                           title: const Text(
//                                               'Confirmation Required'),
//                                           content: const Text(
//                                             'Are you sure you want to reject this application?',
//                                             textAlign: TextAlign.start,
//                                           ),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               onPressed: (() {
//                                                 Navigator.of(context).pop();
//                                               }),
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(10),
//                                                 child: const Text('Cancel'),
//                                               ),
//                                             ),
//                                             TextButton(
//                                               onPressed: (() {
//                                                 _applicationDatabaseService
//                                                     .editStaffApplicationData(
//                                                         application.firstName,
//                                                         application.lastName,
//                                                         application.fullName,
//                                                         application.email,
//                                                         application.phoneNumber,
//                                                         application
//                                                             .supportingDocumentLink,
//                                                         application.userType,
//                                                         'rejected',
//                                                         application
//                                                             .submissionDate,
//                                                         application
//                                                             .applicationId);
//                                                 Navigator.of(context)
//                                                   ..pop()
//                                                   ..pop();
//                                               }),
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(10),
//                                                 child: Text('Confirm'),
//                                               ),
//                                             )
//                                           ],
//                                         ));
//                               }),
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red),
//                               child: Text(
//                                 'Reject',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ),
//                             ElevatedButton(
//                               onPressed: (() {
//                                 showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                           title: const Text(
//                                               'Confirmation Required'),
//                                           content: const Text(
//                                             'The system will automatically register this user once you confirm this application. Are you sure you want to approve this user?\n\nAn email with account details will be sent to the user\'s email.',
//                                             textAlign: TextAlign.start,
//                                           ),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               onPressed: (() {
//                                                 Navigator.of(context).pop();
//                                               }),
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(10),
//                                                 child: const Text('Cancel'),
//                                               ),
//                                             ),
//                                             TextButton(
//                                               onPressed: (() async {
//                                                 _authService
//                                                     .registerStaffWithEmailAndPassword(
//                                                         application.email,
//                                                         'test1234',
//                                                         application.userType);
//                                                 final Email email = Email(
//                                                   body:
//                                                       'Hello new user!\n\nWe are glad to inform to you that your application has been approved by our admin. The details about your new account can be seen below. Your account is now active and can be signed in.\n\nEmail: ${application.email}\nPassword: test1234\n\nThank you for applying with us!',
//                                                   subject:
//                                                       'UmmiCare Application Approval and Account Activation',
//                                                   recipients: [
//                                                     '${application.email}'
//                                                   ],
//                                                   isHTML: false,
//                                                 );
//                                                 await FlutterEmailSender.send(
//                                                     email);
//                                                 _applicationDatabaseService
//                                                     .editStaffApplicationData(
//                                                         application.firstName,
//                                                         application.lastName,
//                                                         application.fullName,
//                                                         application.email,
//                                                         application.phoneNumber,
//                                                         application
//                                                             .supportingDocumentLink,
//                                                         application.userType,
//                                                         'passed',
//                                                         application
//                                                             .submissionDate,
//                                                         application
//                                                             .applicationId);
//                                                 Navigator.of(context)
//                                                   ..pop()
//                                                   ..pop();
//                                               }),
//                                               child: Container(
//                                                 padding:
//                                                     const EdgeInsets.all(10),
//                                                 child: Text('Confirm'),
//                                               ),
//                                             )
//                                           ],
//                                         ));
//                               }),
//                               style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green),
//                               child: Text(
//                                 'Approve',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return Container();
//           }
//         });
//   }
// }
