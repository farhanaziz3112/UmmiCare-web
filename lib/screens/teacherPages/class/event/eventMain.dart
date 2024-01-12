import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class eventMain extends StatefulWidget {
  const eventMain({super.key, required this.academicCalendarId});
  final String academicCalendarId;

  @override
  State<eventMain> createState() => _eventMainState();
}

class _eventMainState extends State<eventMain> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<academicCalendarModel>(
      stream: academicCalendarDatabase()
          .academicCalendarData(widget.academicCalendarId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          academicCalendarModel? academicCalendar = snapshot.data;
          return Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: StreamBuilder<classModel>(
                  stream: schoolDatabase().classData(academicCalendar!.classId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      classModel? classDetail = snapshot.data;
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: 'Class',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.go('/teacher/class');
                                      }),
                              ),
                              const SizedBox(width: 10),
                              const Text('>'),
                              const SizedBox(width: 10),
                              RichText(
                                text: TextSpan(
                                    text:
                                        '${classDetail!.classYear} : ${classDetail.className}',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.go(
                                            '/teacher/class/${academicCalendar.academicCalendarId}');
                                      }),
                              ),
                              const SizedBox(width: 10),
                              const Text('>'),
                              const SizedBox(width: 10),
                              RichText(
                                text: const TextSpan(
                                  text: 'Event',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${classDetail.classYear} : ${classDetail.className} \'s Event',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 35.0,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Add, view and manage class event.',
                              style: TextStyle(
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
                          Container(
                            alignment: Alignment.topLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.event,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xffF29180),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      final _formKey = GlobalKey<FormState>();

                                      String name = '';
                                      String description = '';
                                      DateTime startDate = DateTime.now();
                                      DateTime endDate = DateTime.now();

                                      return Form(
                                        key: _formKey,
                                        child: StatefulBuilder(
                                          builder: (stfContext, stfSetState) {
                                            return AlertDialog(
                                              scrollable: true,
                                              title: const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Text('Add Event'),
                                              ),
                                              content: SizedBox(
                                                width: 500,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: const Text(
                                                          'Title',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      TextFormField(
                                                        initialValue: name,
                                                        decoration:
                                                            textInputDecoration
                                                                .copyWith(
                                                                    hintText:
                                                                        'Name'),
                                                        validator: (value) =>
                                                            value == ''
                                                                ? 'Please enter name'
                                                                : null,
                                                        onChanged: (value) =>
                                                            setState(() =>
                                                                name = value),
                                                      ),
                                                      const SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: const Text(
                                                          'Description',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      TextFormField(
                                                        initialValue:
                                                            description,
                                                        maxLines: 5,
                                                        minLines: 1,
                                                        maxLength: 200,
                                                        decoration:
                                                            textInputDecoration
                                                                .copyWith(
                                                                    hintText:
                                                                        'Description'),
                                                        validator: (value) =>
                                                            value == ''
                                                                ? 'Please enter description'
                                                                : null,
                                                        onChanged: (value) =>
                                                            setState(() =>
                                                                description =
                                                                    value),
                                                      ),
                                                      const SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: const Text(
                                                          'Event Start Date',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <Widget>[
                                                                Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Day',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      startDate
                                                                          .day
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                const Text(
                                                                  ' / ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Month',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      startDate
                                                                          .month
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                const Text(
                                                                  ' / ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Year',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      startDate
                                                                          .year
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    width: 20),
                                                                IconButton(
                                                                  icon: Icon(
                                                                    Icons.edit,
                                                                    color: Colors
                                                                            .grey[
                                                                        800],
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          startDate,
                                                                      firstDate: convertTimeToDate(academicCalendar
                                                                              .academicCalendarStartDate)
                                                                          .add(const Duration(
                                                                              days: 1)),
                                                                      lastDate:
                                                                          convertTimeToDate(
                                                                              academicCalendar.academicCalendarEndDate),
                                                                    ).then(
                                                                        (date) {
                                                                      stfSetState(
                                                                          () {
                                                                        startDate =
                                                                            date!;
                                                                        endDate =
                                                                            date;
                                                                      });
                                                                    });
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                    width: 20),
                                                              ],
                                                            ),
                                                          ]),
                                                      const SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: const Text(
                                                          'Event End Date',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: <Widget>[
                                                                Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Day',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      endDate
                                                                          .day
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                const Text(
                                                                  ' / ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Month',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      endDate
                                                                          .month
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                const Text(
                                                                  ' / ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Year',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.grey),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      endDate
                                                                          .year
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    width: 20),
                                                                IconButton(
                                                                  icon: Icon(
                                                                    Icons.edit,
                                                                    color: Colors
                                                                            .grey[
                                                                        800],
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    showDatePicker(
                                                                      context:
                                                                          context,
                                                                      initialDate:
                                                                          endDate,
                                                                      firstDate:
                                                                          startDate,
                                                                      lastDate:
                                                                          convertTimeToDate(
                                                                              academicCalendar.academicCalendarEndDate),
                                                                    ).then(
                                                                        (date) {
                                                                      stfSetState(
                                                                          () {
                                                                        endDate =
                                                                            date!;
                                                                      });
                                                                    });
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                    width: 20),
                                                              ],
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xffF29180),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff8290F0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                  ),
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      DateTime createdAt =
                                                          DateTime.now();
                                                      academicCalendarDatabase()
                                                          .createClassEventData(
                                                              academicCalendar
                                                                  .academicCalendarId,
                                                              name,
                                                              description,
                                                              startDate
                                                                  .millisecondsSinceEpoch
                                                                  .toString(),
                                                              endDate
                                                                  .millisecondsSinceEpoch
                                                                  .toString(),
                                                              createdAt
                                                                  .millisecondsSinceEpoch
                                                                  .toString());
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                  child: const Text("Confirm",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      );
                                    });
                              },
                              label: const Text(
                                'Add New Event',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        constraints: const BoxConstraints(
                                            minWidth: 100, maxWidth: 200),
                                        child: const Text(
                                          'Title',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        constraints: const BoxConstraints(
                                            minWidth: 100, maxWidth: 200),
                                        child: const Text(
                                          'Created At',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        constraints: const BoxConstraints(
                                            minWidth: 100, maxWidth: 200),
                                        child: const Text(
                                          'Start Date',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.center,
                                        constraints: const BoxConstraints(
                                            minWidth: 100, maxWidth: 200),
                                        child: const Text(
                                          'End Date',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: StreamBuilder<List<classEvent>>(
                                  stream: academicCalendarDatabase()
                                      .allClassEventWithAcademicCalendarId(
                                          academicCalendar.academicCalendarId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<classEvent>? classEvents =
                                          snapshot.data;
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: classEvents!.length,
                                        itemBuilder: ((context, index) {
                                          classEvent? data = classEvents[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          scrollable: true,
                                                          title: const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child: Text(
                                                                'Announcement Description'),
                                                          ),
                                                          content: SizedBox(
                                                              width: 500,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10.0),
                                                                child: Text(data
                                                                    .eventDescription),
                                                              )));
                                                    });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(1)),
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset: const Offset(0,
                                                          0), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: Text(
                                                          data.eventName,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: Text(
                                                          convertTimeToDateWithStringMonth(
                                                              data.createdAt),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: Text(
                                                          convertTimeToDateWithStringMonth(
                                                              data.eventStartDate),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: Text(
                                                          convertTimeToDateWithStringMonth(
                                                              data.eventEndDate),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  final _formKey =
                                                                      GlobalKey<
                                                                          FormState>();

                                                                  String name =
                                                                      data.eventName;
                                                                  String
                                                                      description =
                                                                      data.eventDescription;
                                                                  DateTime
                                                                      startDate =
                                                                      convertTimeToDate(data.eventStartDate);
                                                                  DateTime
                                                                      endDate =
                                                                      convertTimeToDate(data.eventEndDate);

                                                                  return Form(
                                                                    key:
                                                                        _formKey,
                                                                    child:
                                                                        StatefulBuilder(
                                                                      builder:
                                                                          (stfContext,
                                                                              stfSetState) {
                                                                        return AlertDialog(
                                                                          scrollable:
                                                                              true,
                                                                          title:
                                                                              const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(10.0),
                                                                            child:
                                                                                Text('Edit Event'),
                                                                          ),
                                                                          content:
                                                                              SizedBox(
                                                                            width:
                                                                                500,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    padding: const EdgeInsets.only(left: 20.0),
                                                                                    child: const Text(
                                                                                      'Title',
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(
                                                                                        fontSize: 15.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5.0,
                                                                                  ),
                                                                                  TextFormField(
                                                                                    initialValue: name,
                                                                                    decoration: textInputDecoration.copyWith(hintText: 'Name'),
                                                                                    validator: (value) => value == '' ? 'Please enter name' : null,
                                                                                    onChanged: (value) => setState(() => name = value),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 20.0,
                                                                                  ),
                                                                                  Container(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    padding: const EdgeInsets.only(left: 20.0),
                                                                                    child: const Text(
                                                                                      'Description',
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(
                                                                                        fontSize: 15.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5.0,
                                                                                  ),
                                                                                  TextFormField(
                                                                                    initialValue: description,
                                                                                    maxLines: 5,
                                                                                    minLines: 1,
                                                                                    maxLength: 200,
                                                                                    decoration: textInputDecoration.copyWith(hintText: 'Description'),
                                                                                    validator: (value) => value == '' ? 'Please enter description' : null,
                                                                                    onChanged: (value) => setState(() => description = value),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 20.0,
                                                                                  ),
                                                                                  Container(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    padding: const EdgeInsets.only(left: 20.0),
                                                                                    child: const Text(
                                                                                      'Event Start Date',
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(
                                                                                        fontSize: 15.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10.0,
                                                                                  ),
                                                                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: <Widget>[
                                                                                        Column(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Day',
                                                                                              style: TextStyle(color: Colors.grey),
                                                                                            ),
                                                                                            const SizedBox(height: 5),
                                                                                            Text(
                                                                                              startDate.day.toString(),
                                                                                              style: const TextStyle(fontSize: 20.0),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(width: 10),
                                                                                        const Text(
                                                                                          ' / ',
                                                                                          style: TextStyle(fontSize: 20),
                                                                                        ),
                                                                                        const SizedBox(width: 10),
                                                                                        Column(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Month',
                                                                                              style: TextStyle(color: Colors.grey),
                                                                                            ),
                                                                                            const SizedBox(height: 5),
                                                                                            Text(
                                                                                              startDate.month.toString(),
                                                                                              style: const TextStyle(fontSize: 20.0),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(width: 10),
                                                                                        const Text(
                                                                                          ' / ',
                                                                                          style: TextStyle(fontSize: 20),
                                                                                        ),
                                                                                        const SizedBox(width: 10),
                                                                                        Column(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Year',
                                                                                              style: TextStyle(color: Colors.grey),
                                                                                            ),
                                                                                            const SizedBox(height: 5),
                                                                                            Text(
                                                                                              startDate.year.toString(),
                                                                                              style: const TextStyle(fontSize: 20.0),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(width: 20),
                                                                                        IconButton(
                                                                                          icon: Icon(
                                                                                            Icons.edit,
                                                                                            color: Colors.grey[800],
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            showDatePicker(
                                                                                              context: context,
                                                                                              initialDate: startDate,
                                                                                              firstDate: convertTimeToDate(academicCalendar.academicCalendarStartDate).add(const Duration(days: 1)),
                                                                                              lastDate: convertTimeToDate(academicCalendar.academicCalendarEndDate),
                                                                                            ).then((date) {
                                                                                              stfSetState(() {
                                                                                                startDate = date!;
                                                                                                endDate = date;
                                                                                              });
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                        const SizedBox(width: 20),
                                                                                      ],
                                                                                    ),
                                                                                  ]),
                                                                                  const SizedBox(
                                                                                    height: 20.0,
                                                                                  ),
                                                                                  Container(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    padding: const EdgeInsets.only(left: 20.0),
                                                                                    child: const Text(
                                                                                      'Event End Date',
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(
                                                                                        fontSize: 15.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        color: Colors.black,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 10.0,
                                                                                  ),
                                                                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: <Widget>[
                                                                                        Column(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Day',
                                                                                              style: TextStyle(color: Colors.grey),
                                                                                            ),
                                                                                            const SizedBox(height: 5),
                                                                                            Text(
                                                                                              endDate.day.toString(),
                                                                                              style: const TextStyle(fontSize: 20.0),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(width: 10),
                                                                                        const Text(
                                                                                          ' / ',
                                                                                          style: TextStyle(fontSize: 20),
                                                                                        ),
                                                                                        const SizedBox(width: 10),
                                                                                        Column(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Month',
                                                                                              style: TextStyle(color: Colors.grey),
                                                                                            ),
                                                                                            const SizedBox(height: 5),
                                                                                            Text(
                                                                                              endDate.month.toString(),
                                                                                              style: const TextStyle(fontSize: 20.0),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(width: 10),
                                                                                        const Text(
                                                                                          ' / ',
                                                                                          style: TextStyle(fontSize: 20),
                                                                                        ),
                                                                                        const SizedBox(width: 10),
                                                                                        Column(
                                                                                          children: [
                                                                                            const Text(
                                                                                              'Year',
                                                                                              style: TextStyle(color: Colors.grey),
                                                                                            ),
                                                                                            const SizedBox(height: 5),
                                                                                            Text(
                                                                                              endDate.year.toString(),
                                                                                              style: const TextStyle(fontSize: 20.0),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(width: 20),
                                                                                        IconButton(
                                                                                          icon: Icon(
                                                                                            Icons.edit,
                                                                                            color: Colors.grey[800],
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            showDatePicker(
                                                                                              context: context,
                                                                                              initialDate: endDate,
                                                                                              firstDate: startDate,
                                                                                              lastDate: convertTimeToDate(academicCalendar.academicCalendarEndDate),
                                                                                            ).then((date) {
                                                                                              stfSetState(() {
                                                                                                endDate = date!;
                                                                                              });
                                                                                            });
                                                                                          },
                                                                                        ),
                                                                                        const SizedBox(width: 20),
                                                                                      ],
                                                                                    ),
                                                                                  ]),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          actions: [
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: const Color(0xffF29180),
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                                                                            ),
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: const Color(0xff8290F0),
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                              ),
                                                                              onPressed: () {
                                                                                if (_formKey.currentState!.validate()) {
                                                                                  DateTime createdAt = DateTime.now();
                                                                                  academicCalendarDatabase().updateClassEventData(data.classEventId, academicCalendar.academicCalendarId, name, description, startDate.millisecondsSinceEpoch.toString(), endDate.millisecondsSinceEpoch.toString(), createdAt.millisecondsSinceEpoch.toString());
                                                                                  Navigator.of(context).pop();
                                                                                }
                                                                              },
                                                                              child: const Text("Confirm", style: TextStyle(color: Colors.white)),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          icon:
                                                              Icon(Icons.edit),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    } else {
                                      return const Text('The list is empty');
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
