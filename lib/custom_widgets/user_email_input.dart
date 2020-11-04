import 'package:flutter/material.dart';

class UserEmailInput extends StatelessWidget {
  UserEmailInput({@required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val.isEmpty) {
          return 'Enter an email';
        } else if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(val)) {
          return 'Wrong email';
        } else {
          return null;
        }
      },
      controller: controller,
      cursorColor: Color(0xFF40444E),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.email, color: Colors.grey),
        hintText: 'Email',
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
