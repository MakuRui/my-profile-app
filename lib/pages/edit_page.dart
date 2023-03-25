import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var formKey = GlobalKey<FormState>();

  final aboutCon = TextEditingController();
  final workStatsCon = TextEditingController();
  final iconFbCon = TextEditingController();
  final iconIgCon = TextEditingController();
  final iconTwCon = TextEditingController();
  final iconGhCon = TextEditingController();
  final nameCon = TextEditingController();
  final ageCon = TextEditingController();
  final birthdateCon = TextEditingController();
  var sexVal = '';
  final addressCon = TextEditingController();
  final contactNoCon = TextEditingController();
  final religionCon = TextEditingController();
  var maritalStatsVal = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
