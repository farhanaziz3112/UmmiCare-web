import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/charts/noOfChildsCategory.dart';
import 'package:ummicare/screens/charts/noOfChildsOverMonth.dart';
import 'package:ummicare/screens/charts/noOfParentsOverMonth.dart';
import 'package:ummicare/screens/charts/numberOfStaffUser.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/services/advisorDatabase.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/services/staffDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/function.dart';

class adminMain extends StatefulWidget {
  const adminMain({super.key});

  @override
  State<adminMain> createState() => _adminMainState();
}

class _adminMainState extends State<adminMain> {
  AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);
    var screenSize = MediaQuery.of(context).size;
    return StreamBuilder<staffUserModel>(
        stream: staffDatabase(staffId: user!.userId).staffData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            staffUserModel? staff = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome, ${staff!.staffFullName}!',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Last login: ${_auth.getUserLastSignedIn()}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
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
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'User Statistics',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: StreamBuilder<List<advisorModel>>(
                              stream:
                                  advisorDatabase(advisorId: '').allAdvisorData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "background/advisorcardbg.png")),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor:
                                                  Colors.purple[800]!,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              'Advisor',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          snapshot.data!.length.toString(),
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              })),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: StreamBuilder<List<teacherModel>>(
                              stream:
                                  teacherDatabase(teacherId: '').allTeacherData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "background/teachercardbg.png")),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor:
                                                  Colors.green[800]!,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              'Teacher',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          snapshot.data!.length.toString(),
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              })),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: StreamBuilder<List<medicalStaffModel>>(
                              stream:
                                  medicalStaffDatabase().allMedicalStaffData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "background/medicalcardbg.png")),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor: Colors.red[800]!,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              'Medical Staff',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          snapshot.data!.length.toString(),
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              })),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: StreamBuilder<List<staffUserModel>>(
                              stream:
                                  adminDatabase().allStaffData('true', 'admin'),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "background/admincardbg.png")),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor:
                                                  Colors.blue[800]!,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              'Admin',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          snapshot.data!.length.toString(),
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              })),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const numberOfStaffUser()),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: StreamBuilder<List<parentModel>>(
                              stream: adminDatabase().allParentData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "background/parentcardbg.png")),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Row(
                                          children: [
                                            Text(
                                              'Parent',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Total: ${snapshot.data!.length.toString()}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const noOfParentsOverMonth()
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              })),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: StreamBuilder<List<childModel>>(
                              stream: adminDatabase().allChildData,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "background/childcardbg.png")),
                                      color: Colors.white,
                                      border: Border.all(color: Colors.grey),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Row(
                                          children: [
                                            Text(
                                              'Children',
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Total: ${snapshot.data!.length.toString()}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const noOfChildsOverMonth()
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              })),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  StreamBuilder<List<childModel>>(
                    stream: adminDatabase().allChildData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<childModel>? childList = snapshot.data;
                        return Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              const Expanded(
                                  child: noOfChildsCategory()),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          const CircleAvatar(
                                            radius: 10,
                                            backgroundColor:
                                                Color(0xff71CBCA),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('Newborn to 3 Years Old: ',style: TextStyle(fontSize: 20),),
                                          const SizedBox(width: 5),
                                          Text(
                                            getNoOfChildCategory(childList!,
                                                    'Newborn to 3 years old')
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          const CircleAvatar(
                                            radius: 10,
                                            backgroundColor:
                                                Color(0xffF29180),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('3 to 6 Years Old: ',style: TextStyle(fontSize: 20),),
                                          const SizedBox(width: 5),
                                          Text(
                                            getNoOfChildCategory(childList,
                                                    '3 to 6 years old')
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          const CircleAvatar(
                                            radius: 10,
                                            backgroundColor:
                                                Color(0xff8290F0),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('7 to 12 Years Old: ',style: TextStyle(fontSize: 20),),
                                          const SizedBox(width: 5),
                                          Text(
                                            getNoOfChildCategory(childList,
                                                    '7 to 12 years old')
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )
                                        ],
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
