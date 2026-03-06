import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Home_Page.dart';
import 'package:flutter_application_1/Utils/Dialog_Helper.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../widgets/Register.dart';
import 'package:provider/provider.dart';
import '../Provider/AuthProvider.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberMe = false;
  bool _isObscure = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Material(
      color: Colors.transparent,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.48,
          ),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 30),

              // Username / Email
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Username / Email",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),

              SizedBox(height: 8),

              // Password
              TextFormField(
                controller: passwordController,
                obscureText: _isObscure,
                obscuringCharacter: "●",
                decoration: InputDecoration(
                  labelText: "Password",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,

                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity(
                          horizontal: -2,
                          vertical: -4,
                        ),
                      ),
                      Text("Remember me"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.only(
                        left: 0,
                        right: 6,
                        top: 0,
                        bottom: 0,
                      ),
                    ),
                    child: Text("Forgat Password?"),
                  ),
                ],
              ),

              SizedBox(height: 15),

              InkWell(
                onTap: auth.isInitialized
                    ? () async {
                        final authRead = context.read<AuthProvider>();

                        final error = await authRead.login(
                          nameController.text,
                          passwordController.text,
                        );

                        if (error != null) {
                          showErrorDialog(context, error, title: 'Login Gagal');
                          return;
                        }

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => HomePage()),
                          (route) => false,
                        );
                      }
                    : null,

                child: SizedBox(
                  width: 380,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Color(0xff003466),

                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color(0xffffffff), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(77),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Have an Account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showMaterialModalBottomSheet(
                        context: context,
                        expand: false,
                        backgroundColor: Colors.transparent,
                        builder: (context) => Register(),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Color(0xff003466),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
