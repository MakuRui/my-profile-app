import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_profile_app/build_widgets/build_info.dart';
import 'package:my_profile_app/build_widgets/build_menu_items.dart';
import 'package:my_profile_app/build_widgets/build_profile_image.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference data =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[700],
          centerTitle: true,
          title: const Text(
            'User Profile',
            style: TextStyle(fontSize: 20),
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.blueGrey[800],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[buildHeader(), const BuildMenuItems()],
            ),
          ),
        ),
        body: RefreshIndicator(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [buildTop(), buildContent()],
            ),
            onRefresh: () async {
              return Future.delayed(const Duration(seconds: 0));
            }));
  }

  /*Future<UserModel> getUserDetails(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users').where('Email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<UserModel>> allUserDetails(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users').get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }*/

  /*Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());*/

  Widget buildTop() {
    return const Icon(
      Icons.person,
      size: 100,
    );
  }

  buildHeader() {
    return StreamBuilder(
        stream: data.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            for (var i = 0; i < streamSnapshot.data!.docs.length; i++) {
              DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[i];
              if (documentSnapshot.id != firebaseAuth.currentUser!.uid) {
                continue;
              } else {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
                  child: Column(
                    children: [
                      const BuildProfileImage(profileHeight: 104),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        documentSnapshot['name'],
                        style:
                            const TextStyle(fontSize: 28, color: Colors.black),
                      ),
                      Text(
                        user.email!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              }
            }
          } else {
            return const CircularProgressIndicator();
          }
          return const CircularProgressIndicator();
        });
  }

  buildContent() {
    return StreamBuilder(
        stream: data.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            for (var i = 0; i < streamSnapshot.data!.docs.length; i++) {
              DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[i];
              if (documentSnapshot.id != firebaseAuth.currentUser!.uid) {
                continue;
              } else {
                return Card(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                documentSnapshot['name'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        height: 8,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left:60.0),
                        child: Text(
                          'About',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:60.0),
                        child: Text(documentSnapshot['about']),
                      ),
                      const Divider(
                        height: 18,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left:60.0),
                        child: Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Divider(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:60.0),
                        child: BuildInfo(
                            infoType: 'Name :', info: documentSnapshot['name']),
                      ),
                      const Divider(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:60.0),
                        child: BuildInfo(
                            infoType: 'Age :',
                            info: documentSnapshot['age'].toString()),
                      ),
                      const Divider(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:60.0),
                        child: BuildInfo(
                            infoType: 'Birthdate :',
                            info: documentSnapshot['birthdate']),
                      ),
                      const Divider(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:60.0),
                        child: BuildInfo(
                            infoType: 'Sex :', info: documentSnapshot['sex']),
                      ),
                      const Divider(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:60.0),
                        child: BuildInfo(
                            infoType: 'Address :',
                            info: documentSnapshot['address']),
                      ),
                    ],
                  ),
                );
              }
            }
          } else {
            return const CircularProgressIndicator();
          }
          return const CircularProgressIndicator();
        });
  }
}
