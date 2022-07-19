import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:manageuz/providers/login_provider.dart';
import 'package:manageuz/screens/home_page.dart';
import 'package:manageuz/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool login_error = Provider.of<LoginProvider>(context).loginError;
    bool login_loading = Provider.of<LoginProvider>(context).loginLoading;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 45),
                  const Center(
                      child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 30),
                  TextFormField(
                    autofocus: false,
                    decoration: buildInputDecoration('Login', Icons.man),
                    onChanged: (value) => {
                      Provider.of<LoginProvider>(context, listen: false)
                          .updateUsername(value)
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    autofocus: false,
                    obscureText: true,
                    onChanged: (value) => {
                      Provider.of<LoginProvider>(context, listen: false)
                          .updatePassword(value)
                    },
                    validator: (value) => value!.isEmpty
                        ? "Iltimos parolni to'g'ri kiriting"
                        : null,
                    decoration: buildInputDecoration('Password', Icons.lock),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  login_error
                      ? const Text(
                          "Iltimos login yoki parolingizni to'g'ri kiriting",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox(height: 0),
                  const SizedBox(height: 30),
                  login_loading
                      ? const SpinKitCircle(
                          color: Colors.blue,
                          size: 50.0,
                        )
                      : GestureDetector(
                          onTap: () async {
                            String data = await Provider.of<LoginProvider>(
                                    context,
                                    listen: false)
                                .login();

                            if (data == 'foward') {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const MyHomePage()));
                            }
                          },
                          child: buttonStyle('Kirish'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
