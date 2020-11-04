import 'package:flutter/material.dart';

class UserNameInput extends StatelessWidget {
  UserNameInput({@required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val.isEmpty) {
          return 'Name field is empty';
        } else {
          return null;
        }
      },
      controller: controller,
      cursorColor: Color(0xFF40444E),
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.person, color: Colors.grey),
        hintText: 'Your name',
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
