import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_profile_app/main.dart';
import 'package:my_profile_app/pages/forgot_password_page.dart';
import 'package:my_profile_app/utils_class.dart';


class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;


  const LoginWidget({
    Key? key,
    required this.onClickedSignUp
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
            const SizedBox(height: 60,),
            const FlutterLogo(size: 120,),
            const SizedBox(height: 20,),
            const Text('Hey User, \n Welcome Back!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40,),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value){
                return value == null
                    || value.isEmpty ? 'Email is Required' : null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value){
                return value == null
                    || value.isEmpty ? 'Password is Required' : null;
              },
              obscureText: true,
            ),
            const SizedBox(height: 20,),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: (){
                    signIn();
                },
                icon: const Icon(Icons.lock_open, size: 24,),
                label: const Text(
                  'Log In',
                  style: TextStyle(fontSize: 24),
                )
            ),
            const SizedBox(height: 24,),
            GestureDetector(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20
                ),
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ForgotPasswordPage(),));
              },
            ),
            RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  text: 'No Account?  ',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'Register Now',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20
                      )
                    )
                  ]
                )
            ),
          ],
        ),
      ),
    );
  }
  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator())
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    //Navigator.of(context) not working!
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
