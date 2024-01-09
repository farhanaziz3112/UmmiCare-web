import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/charts/childEducationStatus.dart';
import 'package:ummicare/screens/charts/childHealthStatus.dart';
import 'package:ummicare/screens/charts/noOfChildsOverallStatus.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/screens/charts/noOfChildsCategoryWithParentId.dart';
import 'package:ummicare/shared/function.dart';

class parentStatistics extends StatefulWidget {
  const parentStatistics({super.key, required this.parentId});
  final String parentId;

  @override
  State<parentStatistics> createState() => _parentStatisticsState();
}

class _parentStatisticsState extends State<parentStatistics> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    
    return StreamBuilder<parentModel>(
      stream: parentDatabase(parentId: widget.parentId).parentData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          parentModel? parent = snapshot.data;
          return StreamBuilder<List<childModel>>(
              stream: parentDatabase(parentId: widget.parentId).allChildData,
              builder: (contextn, snapshot) {
                if (snapshot.hasData) {
                  List<childModel>? childs = snapshot.data;
                  return SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: 'Parent',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.go('/advisor/parent');
                                      }),
                              ),
                              const SizedBox(width: 10),
                              const Text('>'),
                              const SizedBox(width: 10),
                              RichText(
                                text: TextSpan(
                                  text: parent!.parentFirstName,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.go(
                                          '/advisor/parent/${parent.parentId}');
                                    },
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text('>'),
                              const SizedBox(width: 10),
                              RichText(
                                text: const TextSpan(
                                  text: 'Statistics',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              parent.parentFullName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 45.0,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              parent.parentEmail,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: double.infinity,
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 450,
                            width: double.maxFinite,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                          child: noOfChildsCategoryWithParentId(
                                              parentId: widget.parentId)),
                                      const SizedBox(height: 10),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 80),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              'Newborn to 3 Years Old: ${getNoOfChildCategory(childs!, 'Newborn to 3 years old')}',
                                              style: TextStyle(fontSize: screenSize.width<1300 ? 17 : 20),
                                            ),
                                            Text(
                                              '3 to 6 Years Old: ${getNoOfChildCategory(childs, '3 to 6 years old')}',
                                              style: TextStyle(fontSize: screenSize.width<1300 ? 17 : 20),
                                            ),
                                            Text(
                                              '7 to 12 Years Old: ${getNoOfChildCategory(childs, '7 to 12 years old')}',
                                              style: TextStyle(fontSize: screenSize.width<1300 ? 17 : 20),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                          child: noOfChildsOverallStatus(
                                              parentId: widget.parentId)),
                                      const SizedBox(height: 10),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 80),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              'Great: ${getNoOfChildStatus(childs, 'great')}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              'Normal ${getNoOfChildStatus(childs, 'normal')}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              'Needs Attention ${getNoOfChildStatus(childs, 'needs attention')}',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          childEducationStatus(parentId: parent.parentId,),
                          const SizedBox(height: 30),
                          childHealthStatus(parentId: parent.parentId,),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              });
        } else {
          return Container();
        }
      },
    );
  }
}
