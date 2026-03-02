import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utils/Dialog_Helper.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../widgets/Login.dart';
import '../Provider/AuthProvider.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscure = true;
  bool _isConfirm = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emialController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confimPassController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emialController.dispose();
    passwordController.dispose();
    confimPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.only(top: 20, right: 20, left: 20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.56,
          ),
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 30),

              // Username / Email
              _inputField(labelText: "Username", controller: nameController),

              SizedBox(height: 10),

              // Number Phone
              _inputField(labelText: "Email", controller: emialController),

              SizedBox(height: 10),

              // Password
              _passwordField(
                hintText: "Password",
                controller: passwordController,
                isObscure: _isObscure,
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),

              SizedBox(height: 10),

              // Confirm Password
              _passwordField(
                hintText: "Confirm Password",
                controller: confimPassController,
                isObscure: _isConfirm,
                onPressed: () {
                  setState(() {
                    _isConfirm = !_isConfirm;
                  });
                },
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final auth = context.read<AuthProvider>();

                  final error = await auth.register(
                    nameInput: nameController.text.trim(),
                    emailInput: emialController.text.trim(),
                    passwordInput: passwordController.text.trim(),
                    confirmPassInput: confimPassController.text.trim(),
                  );

                  if (error != null) {
                    showErrorDialog(context, error);
                    return;
                  }

                  // 1. tutup modal register
                  Navigator.pop(context);

                  // 2. buka modal login
                  showMaterialModalBottomSheet(
                    context: context,
                    expand: false,
                    backgroundColor: Colors.transparent,
                    builder: (_) => Login(),
                  );
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 148,
                    ),
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
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
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
                        builder: (context) => Login(),
                      );
                    },
                    child: Text(
                      "Login",
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

Widget _passwordField({
  required String hintText,
  required bool isObscure,
  required TextEditingController controller,
  required VoidCallback onPressed,
}) {
  return TextField(
    controller: controller,
    obscureText: isObscure,
    obscuringCharacter: "●",
    decoration: InputDecoration(
      labelText: "Password",
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
        onPressed: onPressed,
        icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
      ),
    ),
  );
}

Widget _inputField({
  required String labelText,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
}) {
  {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
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
    );
  }
}
