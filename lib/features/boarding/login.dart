import 'package:bimskrip/utils/colors.dart';
import 'package:bimskrip/utils/constraint.dart';
import 'package:bimskrip/utils/widgets.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard/presentation/pages/layout.dart';
import '../dashboard/presentation/provider/login_provider.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool showPass = true;

  @override
  build(BuildContext context) {
    var load = Provider.of<LoginProvider>(context).isLoading;
    var log = Provider.of<LoginProvider>(context).login;
    if (load == kLoadStop) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (log != null) {
          if (log.statusCode == 200) {
            CherryToast.success(
              animationDuration: const Duration(milliseconds: 500),
              displayCloseButton: false,
              toastDuration: Duration(seconds: 2),
              animationType: AnimationType.fromTop,
              title: Text(log.message, style: TextStyle(color: Colors.black)),
            ).show(context);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LayoutPage()),
              (Route<dynamic> route) => false,
            );
          } else {
            CherryToast.error(
              animationDuration: const Duration(milliseconds: 500),
              displayCloseButton: false,
              toastDuration: Duration(seconds: 2),
              animationType: AnimationType.fromTop,
              title: Text(log.message, style: TextStyle(color: Colors.black)),
            ).show(context);
          }
        }
        Provider.of<LoginProvider>(context, listen: false).isLoading =
            kLoadNothing;
      });
    }
    return Scaffold(
      backgroundColor: MyColors.forthColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textRandom(
                      text: "SELAMAT DATANG",
                      size: 22,
                      color: MyColors.blackColor,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: emailController,
                      cursorColor: MyColors.blackColor,
                      style: TextStyle(fontSize: 13.0),
                      cursorHeight: 20,
                      onChanged: (v) => setState(() {}),
                      decoration: inputDecoration(text: 'Email'),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      cursorColor: MyColors.blackColor,
                      onChanged: (v) => setState(() {}),
                      cursorHeight: 20,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: showPass,
                      style: TextStyle(fontSize: 13.0),
                      decoration: InputDecoration(
                        labelText: "Password",
                        isDense: true,
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() => showPass = !showPass),
                          child: Icon(
                            showPass
                                ? Icons.no_encryption_gmailerrorred_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 12,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: MyColors.blackColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: MyColors.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    buttonCustom(
                      onTap: () async {
                        Provider.of<LoginProvider>(
                          context,
                          listen: false,
                        ).eitherFailureOrLogin(
                          context,
                          password: passwordController.text,
                          email: emailController.text,
                        );
                      },
                      disable:
                          load == kLoading
                              ? true
                              : emailController.text == "" ||
                                  passwordController.text == ""
                              ? true
                              : false,
                      text: load == kLoading ? "Loading..." : "Login",
                    ),
                    const SizedBox(height: 15),
                    textRandom(
                      text: "Belum punya akun?",
                      size: 11,
                      color: MyColors.blackColor,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w300,
                    ),
                    GestureDetector(
                      onTap:
                          () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          ),
                      child: textRandom(
                        text: "Register",
                        size: 11,
                        fontWeight: FontWeight.bold,
                        color: MyColors.blackColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
