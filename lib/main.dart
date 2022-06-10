import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:random_date/random_date.dart';
import 'package:random_string/random_string.dart' as rant;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().whenComplete(() async {
    // await FirebaseInAppMessaging.instance.setMessagesSuppressed(false);
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Practical interview',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int filterAgeStart = 13;
  int filterAgeEnd = 60;
  List<String> filterInterests = [
    "Football",
    "Basketball",
    "Cricket",
    "Kabaddi"
  ];

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;

    Future create500users(int num) async {
      var bat = db.batch();

      for (int i = num; i < num + 400; i++) {
        String id = rant.randomString(5);
        String name = rant.randomString(10);
        String gender = rant.randomString(1);
        String username = rant.randomString(11);
        DateTime dob = RandomDate.withRange(1900, 2022).random();
        DateTime createdAt = DateTime.now();
        String profession = rant.randomString(10);
        String placeOfWork = rant.randomString(10);
        String placeOfEdu = rant.randomString(10);
        String academicCourse = rant.randomString(10);
        String bio = rant.randomString(10);
        String email = rant.randomString(10);
        String inJumpInFor = rant.randomString(10);
        Map<String, dynamic> interests = {"interests": GeoPoint(40.0, 40.0)};
        List<String> interestList = [
          "Football",
          "Basketball",
          "Cricket",
          "Kabaddi"
        ].sublist(Random().nextInt(4));
        List<String> photoList = ["interest1,interest2"];
        List<String> contacts = ["interest1,interest2"];
        List<String> connection = ["interest1,interest2"];
        List<String> plans = ["interest1,interest2"];
        Map<String, dynamic> geoPoint = {"favorite": GeoPoint(40.0, 40.0)};
        String phoneNo = "kunal jain";
        String searchUname = "kunal jain";
        Map<String, dynamic> favourites = {"favorite": GeoPoint(40.0, 40.0)};
        int unseenTotalCount = 4;
        bool isOnline = true;
        String geohash = "kunal jain";
        Map<String, dynamic> location = {"location": GeoPoint(40.0, 40.0)};
        var data = {
          "id": id,
          "name": name,
          "gender": gender,
          "username": username,
          "dob": dob,
          "createdAt": createdAt,
          "profession": profession,
          "placeOfWork": placeOfWork,
          "placeOfEdu": placeOfEdu,
          "academicCourse": academicCourse,
          "bio": bio,
          "email": email,
          "inJumpInFor": inJumpInFor,
          'geoPoint': geoPoint,
          "interestList": interestList,
          "photoList": photoList,
          "contacts": contacts,
          "connection": connection,
          "plans": plans,
          'phoneNo': phoneNo,
          "searchUname": searchUname,
          "favourites": favourites,
          "unseenTotalCount": unseenTotalCount,
          "isOnline": isOnline,
          'geohash': geohash,
          "location": location,
        };
        bat.set(db.doc("mudit/$i"), data);
      }
      await bat
          .commit()
          .then((value) => {debugPrint(" ${num + 400} users present")});
    }

    Future create20000users() async {
      int i = 0;

      while (i < 20000) {
        await create500users(i);
        await Future.delayed(const Duration(seconds: 4));
        i = i + 400;
      }
      print("20000 users added succesfully");
    }

    GlobalKey globalKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, set) {
                        return AlertDialog(
                          content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select from wide range of filters",
                                  textScaleFactor: 1.2,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Age(in years)",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Badge(
                                  position: BadgePosition.topEnd(),
                                  padding: EdgeInsets.zero,
                                  shape: BadgeShape.circle,
                                  animationType: BadgeAnimationType.fade,
                                  elevation: 0,
                                  ignorePointer: true,
                                  badgeColor: Colors.transparent,
                                  badgeContent: Text(filterAgeStart
                                          .toString()
                                          .substring(0, 2) +
                                      " - " +
                                      filterAgeEnd.toString().substring(0, 2)),
                                  child: RangeSlider(
                                      min: 13.0,
                                      max: 60.0,
                                      divisions: 47,
                                      activeColor: Colors.black,
                                      labels: RangeLabels(
                                          filterAgeStart
                                              .toString()
                                              .substring(0, 2),
                                          filterAgeEnd
                                              .toString()
                                              .substring(0, 2)),
                                      values: RangeValues(
                                          filterAgeStart.toDouble(),
                                          filterAgeEnd.toDouble()),
                                      onChanged: (RangeValues val) {
                                        set(() {
                                          filterAgeStart = val.start.toInt();
                                          filterAgeEnd = val.end.toInt();
                                        });
                                      }),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Interests",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  children: [
                                    "Football",
                                    "Basketball",
                                    "Cricket",
                                    "Kabaddi"
                                  ]
                                      .map<Widget>((e) => Chip(
                                            label: Text(e),
                                            onDeleted: () {
                                              set(() {
                                                filterInterests.contains(e)
                                                    ? {
                                                        filterInterests
                                                            .remove(e)
                                                      }
                                                    : {filterInterests.add(e)};
                                              });
                                            },
                                            deleteIcon: Icon(
                                                filterInterests.contains(e)
                                                    ? CupertinoIcons.multiply
                                                    : Icons.add),
                                            backgroundColor:
                                                filterInterests.contains(e)
                                                    ? Colors.green
                                                    : null,
                                          ))
                                      .toList(),
                                )
                              ]),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    debugPrint(filterInterests.toString());
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text("Done"))
                          ],
                        );
                      });
                    });
              },
              icon: Icon(Icons.filter_list))
        ],
        // The title text which will be shown on the action bar
        title: Text("Flutter Demo-Kunal"),
      ),
      body: PaginateFirestore(
          key: globalKey,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, snapshot, index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: AlertDialog(
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan),
                    borderRadius: BorderRadius.circular(10)),
                title: Text(snapshot[index].id),
                content: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(snapshot[index]["dob"]
                        .toDate()
                        .toString()
                        .substring(0, 10)),
                    Text(snapshot[index]["interestList"].toString())
                  ],
                ),
              ),
            );
          },
          itemsPerPage: 10,
          query: db
              .collection("mudit")
              .where("interestList", isEqualTo: filterInterests)
              .where("dob",
                  isGreaterThan: Timestamp.fromDate(
                      DateTime(DateTime.now().year - filterAgeEnd)))
              .where("dob",
                  isLessThan: Timestamp.fromDate(
                      DateTime(DateTime.now().year - filterAgeStart)))
              .orderBy("dob")

          // .where("")
          // .where("dob", isLessThanOrEqualTo: Timestamp.now())
          ,
          itemBuilderType: PaginateBuilderType.listView),
      // floatingActionButton:
      //     FloatingActionButton(onPressed: () async => await create20000users()),
    );
  }
}
