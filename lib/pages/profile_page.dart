import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_profile_app/build_widgets/build_cover_image.dart';
import 'package:my_profile_app/build_widgets/build_info.dart';
import 'package:my_profile_app/build_widgets/build_menu_items.dart';
import 'package:my_profile_app/build_widgets/build_profile_image.dart';
import 'package:my_profile_app/build_widgets/build_social_icon.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference data = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Profile', style: TextStyle(fontSize: 20),),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              buildHeader(),
              const BuildMenuItems()
            ],
          ),
        ),
      ),
        body: RefreshIndicator(
          child: ListView(
                  padding: EdgeInsets.zero,
                  children:[
                    buildTop(),
                    buildContent()
                  ],
                ),
            onRefresh: ()async {
              return Future.delayed(const Duration(seconds: 0));
            })
    );
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
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(bottom: bottom),
            child: BuildCoverImage(coverHeight: coverHeight)),
        Positioned(
            top: top,
            child: BuildProfileImage(profileHeight: profileHeight))
      ],
    );
  }

  buildHeader() {
    return StreamBuilder(
      stream: data.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            for (var i = 0; i < streamSnapshot.data!.docs.length; i++){
              DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[i];
              if(documentSnapshot.id != firebaseAuth.currentUser!.uid){
                continue;
              }else{
                return Container(
                  color: Colors.indigo,
                  padding: EdgeInsets.only(
                      top: 24 + MediaQuery.of(context).padding.top,
                      bottom: 24
                  ),
                  child: Column(
                    children: [
                      const BuildProfileImage(profileHeight: 104),
                      const SizedBox(height: 12,),
                      Text(documentSnapshot['name'],
                        style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white),
                      ),
                      Text(user.email!,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              }
            }
          }else{
            return const CircularProgressIndicator();
          }
          return const CircularProgressIndicator();
        });
  }

  buildContent() {
    return StreamBuilder(
      stream: data.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            for (var i = 0; i < streamSnapshot.data!.docs.length; i++){
              DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[i];
              if(documentSnapshot.id != firebaseAuth.currentUser!.uid){
                continue;
              }else{
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(documentSnapshot['name'],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const Divider(height: 8,),
                    Center(
                      child: Text(documentSnapshot['workStats'],
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Divider(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BuildSocialIcon(
                            icon: FontAwesomeIcons.facebook,
                            url: documentSnapshot['iconFb']
                        ),
                        const SizedBox(width: 12),
                        BuildSocialIcon(
                            icon: FontAwesomeIcons.instagram,
                            url: documentSnapshot['iconIg']
                        ),
                        const SizedBox(width: 12),
                        BuildSocialIcon(
                            icon: FontAwesomeIcons.twitter,
                            url: documentSnapshot['iconTw']
                        ),
                        const SizedBox(width: 12),
                        BuildSocialIcon(
                            icon: FontAwesomeIcons.github,
                            url: documentSnapshot['iconGh']
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const Divider(
                      height: 10,
                    ),
                    const Text('About',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Divider(
                      height: 16,
                    ),
                    Text(documentSnapshot['about']
                    ),
                    const Divider(
                      height: 18,
                    ),
                    const Text('Personal Information',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Divider(
                      height: 16,
                    ),
                    BuildInfo(
                        infoType: 'Name :',
                        info: documentSnapshot['name']),
                    const Divider(height: 8,),
                    BuildInfo(
                        infoType: 'Age :',
                        info: documentSnapshot['age'].toString()),
                    const Divider(height: 8,),
                    BuildInfo(
                        infoType: 'Birthdate :',
                        info: documentSnapshot['birthdate']),
                    const Divider(height: 8,),
                    BuildInfo(
                        infoType: 'Sex :',
                        info: documentSnapshot['sex']),
                    const Divider(height: 8,),
                    BuildInfo(
                        infoType: 'Address :',
                        info: documentSnapshot['address']),
                    const Divider(height: 8,),
                    BuildInfo(
                        infoType: 'Contact No. :',
                        info: documentSnapshot['contactNo'].toString()),
                    const Divider(height: 8,),
                    BuildInfo(
                        infoType: 'Religion :',
                        info: documentSnapshot['religion']),
                    const Divider(height: 8,),
                    BuildInfo(
                        infoType: 'Marital Status :',
                        info: documentSnapshot['maritalStats']),
                  ],
                );
              }
        }
      }else{
            return const CircularProgressIndicator();
          }
          return const CircularProgressIndicator();
      });
  }
}
