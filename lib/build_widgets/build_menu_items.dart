import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuildMenuItems extends StatelessWidget {
  const BuildMenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite_border),
          title: const Text('Favorites'),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.update),
          title: const Text('Updates'),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications_outlined),
          title: const Text('Notification'),
          onTap: (){

          },
        ),
        ListTile(
          leading: const Icon(Icons.edit_rounded),
          title: const Text('Edit Profile'),
          onTap: (){

          },
        ),
        const Divider(color: Colors.black54,),
        ElevatedButton.icon(
            onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
            label: const Text(
              'Log Out',
              style: TextStyle(
                fontSize: 24
              ),
            )
        )
      ],
    );
  }
}
