// import 'package:flutter/material.dart';
// import 'package:ummicare/screens/advisor_pages/mentee/menteeProfile/menteeProfile.dart';
// import 'package:ummicare/screens/parent_pages/child/childprofile/childProfile.dart';
// import 'package:ummicare/screens/parent_pages/child/childprofile/childStory.dart';
// import 'package:ummicare/screens/parent_pages/child/childprofile/editChildProfile.dart';
// import 'package:ummicare/screens/parent_pages/child/childprofile/addNewChildStory.dart';
// import 'package:ummicare/screens/parent_pages/child/registerChild.dart';
// import 'package:ummicare/screens/parent_pages/child/advisory/advisoryMain.dart';
// import 'package:ummicare/screens/parent_pages/child/advisory/advisorProfile.dart';
// import 'package:ummicare/screens/parent_pages/child/advisory/chatting.dart';
// import 'package:ummicare/screens/parent_pages/child/education/academicCalendar.dart';
// import 'package:ummicare/screens/parent_pages/child/education/addNewExamResult.dart';
// import 'package:ummicare/screens/parent_pages/child/education/addNewSchoolFee.dart';
// import 'package:ummicare/screens/parent_pages/child/education/editChildEducation.dart';
// import 'package:ummicare/screens/parent_pages/child/education/educationMain.dart';
// import 'package:ummicare/screens/parent_pages/child/health/healthMain.dart';
// import 'package:ummicare/screens/parent_pages/child/health/addNewVaccineAppointment.dart';
// import 'package:ummicare/screens/parent_pages/child/health/editChildHealth.dart';
// import 'package:ummicare/screens/parent_pages/child/health/vaccinationCalendar.dart';
// import 'package:ummicare/screens/verification/wrapper.dart';
// import 'package:ummicare/screens/advisor_pages/mentee/menteeProfile/childProgress.dart';
// import 'package:ummicare/screens/advisor_pages/mentee/menteeProfile/chattingAdvisor.dart';

// //first name in the route name is the 'type of user'
// //example: /parent/child/childprofile : parent user

// Map<String, WidgetBuilder> routes = {
//   '/': (context) => Wrapper(),
//   //'/parent/child/childprofile': (context) => childProfile(),
//   //'/parent/child/childprofile/editchildprofile': (context) => editChildProfile(),
//   '/parent/child/childprofile/childstory': (context) => childStory(),
//   '/parent/child/childprofile/addnewchildstory': (context) => addNewChildStory(),
//   //'/parent/child/registerchild': (context) => registerChild(),
//   '/parent/child/advisory': (context) => advisoryMain(),
//   '/parent/child/advisory/advisorprofile': (context) => advisorProfile(),
//   '/parent/child/advisory/chatting': (context) => chatting(),
//   //'/parent/child/childprofile/education': (context) => educationMain(),
//   '/parent/child/childprofile/education/academiccalendar': (context) => academicCalendar(),
//   '/parent/child/childprofile/education/addnewexamresult': (context) => addNewExamResult(),
//   '/parent/child/childprofile/education/addnewschoolfee': (context) => addNewSchoolFee(),
//   //'/parent/child/childprofile/education/editchildeducation': (context) => editChildEducation(),
//   //'/parent/child/childprofile/health': (context) => healthMain(),
//   '/parent/child/childprofile/health/addnewvaccineappointment': (context) => addNewVaccineAppointment(),
//   '/parent/child/childprofile/health/editchildhealth': (context) => editChildHealth(),
//   //'/parent/child/childprofile/health/vaccinationcalendar': (context) => vaccinationCalendar(),
//   '/advisor/mentee/menteeprofile': (context) => menteeProfile(),
//   '/advisor/mentee/childprogress': (context) => childProgress(),
//   '/advisor/mentee/chattingadvisor': (context) => chattingAdvisor(),
//   //'/settings/editprofile': (context) => editProfile(),
// };

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/adminPages/adminHome.dart';
import 'package:ummicare/screens/adminPages/advisor/adminAdvisor.dart';
import 'package:ummicare/screens/adminPages/advisor/staffPages/advisorProfilePageDecider.dart';
import 'package:ummicare/screens/adminPages/home/adminMain.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/adminMedicalStaff.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/staffPages/medicalStaffProfilePageDecider.dart';
import 'package:ummicare/screens/adminPages/settings/adminSettings.dart';
import 'package:ummicare/screens/adminPages/teacher/adminTeacher.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/teacherProfilePageDecider.dart';
import 'package:ummicare/screens/advisorPages/advisorHome.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorSettings.dart';
import 'package:ummicare/screens/auth/authenticate.dart';
import 'package:ummicare/screens/auth/register.dart';
import 'package:ummicare/screens/auth/signIn.dart';
import 'package:ummicare/screens/verification/wrapper.dart';
import 'package:ummicare/services/auth.dart';

AuthService _auth = new AuthService();

final GoRouter routes = GoRouter(
    redirect: (BuildContext context, GoRouterState state) async {
      // final CollectionReference staffCollection =
      // FirebaseFirestore.instance.collection('Staff');
      // final snapshot = await staffCollection.doc(_auth.currentUser.userId).get();
      if (_auth.isAuthenticated()) {
        return null;
      } else {
        return '/auth';
      }
    },
    initialLocation: '/auth',
    routes: <RouteBase>[
      GoRoute(
          path: '/auth',
          builder: (BuildContext context, GoRouterState state) {
            return const Authenticate();
          }),
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const Wrapper();
          }),
      GoRoute(
          path: '/admin',
          builder: (BuildContext context, GoRouterState state) {
            return const adminHome(currentPage: 0);
          },
          routes: [
            GoRoute(
                path: 'home',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const adminHome(currentPage: 0),
                    )),
            GoRoute(
                path: 'advisor',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const adminHome(currentPage: 1),
                    ),
                routes: [
                  GoRoute(
                    path: 'pending',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminAdvisor(currentPage: 0)),
                    routes: [
                      GoRoute(
                          path: ':id',
                          pageBuilder: (context, state) =>
                              NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: advisorProfilePageDecider(
                                      currentPage: 0,
                                      staffId: state.pathParameters['id']!))),
                    ],
                  ),
                  GoRoute(
                    path: 'rejected',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminAdvisor(currentPage: 1)),
                    routes: [
                      GoRoute(
                          path: ':id',
                          pageBuilder: (context, state) =>
                              NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: advisorProfilePageDecider(
                                      currentPage: 1,
                                      staffId: state.pathParameters['id']!))),
                    ],
                  ),
                  GoRoute(
                    path: 'verified',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminAdvisor(currentPage: 2)),
                    routes: [
                      GoRoute(
                          path: ':id',
                          pageBuilder: (context, state) =>
                              NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: advisorProfilePageDecider(
                                      currentPage: 2,
                                      staffId: state.pathParameters['id']!))),
                    ],
                  ),
                  GoRoute(
                    path: 'report',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminAdvisor(currentPage: 3)),
                  ),
                  GoRoute(
                    path: 'announcement',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminAdvisor(currentPage: 4)),
                  ),
                ]),
            GoRoute(
                path: 'teacher',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const adminHome(currentPage: 2),
                    ),
                routes: [
                  GoRoute(
                    path: 'pending',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminTeacher(currentPage: 0)),
                    routes: [
                      GoRoute(
                          path: ':id',
                          pageBuilder: (context, state) =>
                              NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: teacherProfilePageDecider(
                                      currentPage: 0,
                                      staffId: state.pathParameters['id']!))),
                    ],
                  ),
                  GoRoute(
                    path: 'rejected',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminTeacher(currentPage: 1)),
                    routes: [
                      GoRoute(
                          path: ':id',
                          pageBuilder: (context, state) =>
                              NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: teacherProfilePageDecider(
                                      currentPage: 1,
                                      staffId: state.pathParameters['id']!))),
                    ],
                  ),
                  GoRoute(
                    path: 'verified',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminTeacher(currentPage: 2)),
                    routes: [
                      GoRoute(
                          path: ':id',
                          pageBuilder: (context, state) =>
                              NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: teacherProfilePageDecider(
                                      currentPage: 2,
                                      staffId: state.pathParameters['id']!))),
                    ],
                  ),
                  GoRoute(
                    path: 'report',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminTeacher(currentPage: 3)),
                  ),
                  GoRoute(
                    path: 'announcement',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminTeacher(currentPage: 4)),
                  ),
                ]),
            GoRoute(
                path: 'medicalstaff',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const adminHome(currentPage: 3),
                    ),
                routes: [
                  GoRoute(
                    path: 'pending',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminMedicalStaff(currentPage: 0)),
                    routes: [
                      GoRoute(
                          path: ':id',
                          pageBuilder: (context, state) =>
                              NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: medicalStaffProfilePageDecider(
                                      currentPage: 0,
                                      staffId: state.pathParameters['id']!))),
                    ],
                  ),
                  GoRoute(
                    path: 'rejected',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminMedicalStaff(currentPage: 1)),
                    routes: [
                      GoRoute(
                          path: ':id',
                          pageBuilder: (context, state) =>
                              NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: medicalStaffProfilePageDecider(
                                      currentPage: 1,
                                      staffId: state.pathParameters['id']!))),
                    ],
                  ),
                  GoRoute(
                    path: 'verified',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminMedicalStaff(currentPage: 2)),
                    routes: [
                      GoRoute(
                          path: ':id',
                          pageBuilder: (context, state) =>
                              NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: medicalStaffProfilePageDecider(
                                      currentPage: 2,
                                      staffId: state.pathParameters['id']!))),
                    ],
                  ),
                  GoRoute(
                    path: 'report',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminMedicalStaff(currentPage: 3)),
                  ),
                  GoRoute(
                    path: 'announcement',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminMedicalStaff(currentPage: 4)),
                  ),
                ]),
            GoRoute(
                path: 'settings',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const adminHome(currentPage: 4),
                    ),
                routes: [
                  GoRoute(
                    path: 'editprofile',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminSettings(currentPage: 0)),
                  ),
                  GoRoute(
                    path: 'systemsettings',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminSettings(currentPage: 1)),
                  ),
                  GoRoute(
                    path: 'version',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminSettings(currentPage: 2)),
                  ),
                  GoRoute(
                    path: 'privacyofpolicy',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminSettings(currentPage: 3)),
                  ),
                  GoRoute(
                    path: 'termsofuse',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminSettings(currentPage: 4)),
                  ),
                  GoRoute(
                    path: 'contactus',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const adminSettings(currentPage: 5)),
                  ),
                ]),
          ]),
      GoRoute(
          path: '/advisor',
          builder: (BuildContext context, GoRouterState state) {
            return const advisorHome(currentPage: 0);
          },
          routes: [
            GoRoute(
                path: 'home',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const advisorHome(currentPage: 0),
                    )),
            GoRoute(
                path: 'parent',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const advisorHome(currentPage: 1),
                    )),
            GoRoute(
                path: 'settings',
                pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const advisorHome(currentPage: 2),
                    ),
                routes: [
                  GoRoute(
                    path: 'editprofile',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const advisorSettings(currentPage: 0)),
                  ),
                  GoRoute(
                    path: 'systemsettings',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const advisorSettings(currentPage: 1)),
                  ),
                  GoRoute(
                    path: 'version',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const advisorSettings(currentPage: 2)),
                  ),
                  GoRoute(
                    path: 'privacyofpolicy',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const advisorSettings(currentPage: 3)),
                  ),
                  GoRoute(
                    path: 'termsofuse',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const advisorSettings(currentPage: 4)),
                  ),
                  GoRoute(
                    path: 'contactus',
                    pageBuilder: (context, state) => NoTransitionPage<void>(
                        key: state.pageKey,
                        child: const advisorSettings(currentPage: 5)),
                  ),
                ]),
          ]),
      // GoRoute(
      //     path: '/teacher',
      //     builder: (BuildContext context, GoRouterState state) {
      //       return const test2(currentPage: 0);
      //     },
      //     routes: [
      //       GoRoute(
      //           path: 'home',
      //           pageBuilder: (context, state) => NoTransitionPage<void>(
      //                 key: state.pageKey,
      //                 child: const test2(currentPage: 0),
      //               )),
      //       GoRoute(
      //           path: 'parent',
      //           pageBuilder: (context, state) => NoTransitionPage<void>(
      //                 key: state.pageKey,
      //                 child: const test2(currentPage: 1),
      //               )),
      //       GoRoute(
      //           path: 'chat',
      //           pageBuilder: (context, state) => NoTransitionPage<void>(
      //                 key: state.pageKey,
      //                 child: const test2(currentPage: 2),
      //               )),
      //       GoRoute(
      //           path: 'settings',
      //           pageBuilder: (context, state) => NoTransitionPage<void>(
      //                 key: state.pageKey,
      //                 child: const test2(currentPage: 3),
      //               )),
      //     ]),
      // GoRoute(
      //     path: '/medicalstaff',
      //     builder: (BuildContext context, GoRouterState state) {
      //       return const test3(currentPage: 0);
      //     },
      //     routes: [
      //       GoRoute(
      //           path: 'home',
      //           pageBuilder: (context, state) => NoTransitionPage<void>(
      //                 key: state.pageKey,
      //                 child: const test3(currentPage: 0),
      //               )),
      //       GoRoute(
      //           path: 'parent',
      //           pageBuilder: (context, state) => NoTransitionPage<void>(
      //                 key: state.pageKey,
      //                 child: const test3(currentPage: 1),
      //               )),
      //       GoRoute(
      //           path: 'chat',
      //           pageBuilder: (context, state) => NoTransitionPage<void>(
      //                 key: state.pageKey,
      //                 child: const test3(currentPage: 2),
      //               )),
      //       GoRoute(
      //           path: 'settings',
      //           pageBuilder: (context, state) => NoTransitionPage<void>(
      //                 key: state.pageKey,
      //                 child: const test3(currentPage: 3),
      //               )),
      //     ]),
      // GoRoute(
      //   path: '/advisor/home',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const test(currentPage: 0);
      //   },
      // ),
      // GoRoute(
      //     path: '/advisor/home',
      //     pageBuilder: (context, state) => NoTransitionPage<void>(
      //           key: state.pageKey,
      //           child: test(currentPage: 0),
      //         )),
      // GoRoute(
      //     path: '/advisor/parent',
      //     pageBuilder: (context, state) => NoTransitionPage<void>(
      //           key: state.pageKey,
      //           child: test(currentPage: 1),
      //         )),
      // GoRoute(
      //     path: '/advisor/chat',
      //     pageBuilder: (context, state) => NoTransitionPage<void>(
      //           key: state.pageKey,
      //           child: test(currentPage: 2),
      //         )),
      // GoRoute(
      //     path: '/advisor/settings',
      //     pageBuilder: (context, state) => NoTransitionPage<void>(
      //           key: state.pageKey,
      //           child: test(currentPage: 3),
      //         )),
    ]);
// GoRoute(
//     path: '/home',
//     pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: test(currentPage: 0),
//         )),
// GoRoute(
//     path: '/parent',
//     pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: test(currentPage: 1),
//         )),
// GoRoute(
//     path: '/chat',
//     pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: test(currentPage: 2),
//         )),
// GoRoute(
//     path: '/settings',
//     pageBuilder: (context, state) => NoTransitionPage<void>(
//           key: state.pageKey,
//           child: test(currentPage: 3),
//         ))
//   GoRoute(
//       path: '/parent',
//       builder: (BuildContext context, GoRouterState state) {
//         return const test(currentPage: 1);
//       }),
//   GoRoute(
//       path: '/chat',
//       builder: (BuildContext context, GoRouterState state) {
//         return const test(currentPage: 2);
//       }),
//   GoRoute(
//       path: '/settings',
//       builder: (BuildContext context, GoRouterState state) {
//         return const test(currentPage: 3);
//       }),
// ],    // observers: [_noAnimationObservers()],

// class _noAnimationObservers extends NavigatorObserver {
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     if (route is PageRoute && previousRoute is PageRoute) {
//       // Disable transition for all routes
//       // route.maintainState = true;
//       // route.opaque = true;
//       // route.transitionsBuilder = (_, __, ___, child) {
//       //   return FadeTransition(
//       //     opacity: AlwaysStoppedAnimation(1.0),
//       //     child: child,
//       //   );
//       // };
//       route.transitionDuration == Duration.zero;
//     }
//     super.didPush(route, previousRoute);
//   }
