import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BuildMenuItems extends StatelessWidget {
  const BuildMenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.black54,
        ),
        ElevatedButton.icon(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromRadius(20),
                backgroundColor: Colors.blueGrey[700]),
            icon: const Icon(Icons.logout),
            label: const Text(
              'Log Out',
              style: TextStyle(fontSize: 24),
            ))
      ],
    );
  }
}
