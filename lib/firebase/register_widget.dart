import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_profile_app/main.dart';
import 'package:my_profile_app/utils_class.dart';

class RegisterWidget extends StatefulWidget {
  final Function() onClickedLogIn;

  const RegisterWidget({Key? key, required this.onClickedLogIn})
      : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final aboutCon = TextEditingController();
  final nameCon = TextEditingController();
  final ageCon = TextEditingController();
  final birthdateCon = TextEditingController();
  var sexVal = '';
  final addressCon = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Icon(
              Icons.lock,
              size: 120,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome \n Create Your Account',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Enter a valid email'
                    : null;
              },
            ),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return value == null || value.length < 6
                    ? 'Enter 6 Minimum Password'
                    : null;
              },
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.black54,
            ),
            const SizedBox(
              height: 20,
              child: Text(
                'Please Fill Up',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              color: Colors.black54,
            ),
            TextFormField(
              controller: aboutCon,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'About',
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Enter a valid about'
                    : null;
              },
            ),
            const SizedBox(
              height: 4,
            ),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: nameCon,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Enter a valid name'
                    : null;
              },
            ),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: ageCon,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Enter a valid age'
                    : null;
              },
            ),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: birthdateCon,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'BirthDate',
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Enter a valid birthdate'
                    : null;
              },
            ),
            const SizedBox(
              height: 4,
            ),
            DropdownButtonFormField(
              hint: const Text('Sex'),
              items: const [
                DropdownMenuItem(value: 'Male', child: Text('Male')),
                DropdownMenuItem(value: 'Female', child: Text('Female')),
                DropdownMenuItem(
                    value: 'Transgender', child: Text('Transgender')),
                DropdownMenuItem(
                    value: 'Non-binary', child: Text('Non-binary')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (sexValue) {
                sexVal = sexValue.toString();
              },
              validator: (yearValue) =>
                  yearValue == null ? 'Year required' : null,
            ),
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: addressCon,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'Enter a valid address'
                    : null;
              },
            ),
            const SizedBox(
              height: 4,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromRadius(20),
                  backgroundColor: Colors.blueGrey[700]
                ),
                onPressed: () async {
                  await createUser(
                      email: emailController.text,
                      password: passwordController.text,
                      about: aboutCon.text,
                      name: nameCon.text,
                      age: int.parse(ageCon.text),
                      birthdate: birthdateCon.text,
                      sex: sexVal,
                      address: addressCon.text);
                  signUp();
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 24,
                ),
                label: const Text(
                  'Register',
                  style: TextStyle(fontSize: 24),
                )),
            const SizedBox(
              height: 24,
            ),
            RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    text: 'Already have an account?  ',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedLogIn,
                      text: 'Log In',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.secondary))
                ])),
          ],
        ),
      ),
    );
  }

  Future createUser(
      {required String email,
      required String password,
      required String about,
      required String name,
      required int age,
      required String birthdate,
      required String sex,
      required String address}) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    Map<String, dynamic> userDetailsMap = {
      'email': email,
      'password': password,
      'about': about,
      'name': name,
      'age': age,
      'birthdate': birthdate,
      'sex': sex,
      'address': address,
    };

    /// Reference to document
    /*final docUser = FirebaseFirestore.instance.
    collection('users').doc(firebaseAuth.currentUser!.uid);*/

    /*final user = UserModel(
        email: email,
        password: password,
        about: about,
        workStats: workStats,
        iconFb: 'https://www.facebook.com/',
        iconIg: 'https://www.instagram.com/',
        iconTw: 'https://twitter.com/',
        iconGh: 'https://github.com/',
        name: name,
        age: age,
        birthdate: birthdate,
        sex: sex,
        address: address,
        contactNo: contactNo,
        religion: religion,
        maritalStats: maritalStats
    );*/
    /*final json = user.toJson();*/

    /// Create document and write data to Firebase
    /*await docUser.set(userDetailsMap);*/

    if (userCredential != null) {
      final docUser = FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid);
      await docUser.set(userDetailsMap);
    }
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    //Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
