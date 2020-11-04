import 'package:flutter/material.dart';

class UserPasswordInput extends StatefulWidget {
  UserPasswordInput({@required this.icon, this.controller});

  IconData icon;
  final TextEditingController controller;

  @override
  _UserPasswordInputState createState() => _UserPasswordInputState();
}

class _UserPasswordInputState extends State<UserPasswordInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        if (val.length < 6) {
          return 'Enter a password 6+ chars long';
        } else {
          return null;
        }
      },
      controller: widget.controller,
      obscureText: widget.icon == Icons.lock_outline ? true : false,
      cursorColor: Color(0xFF40444E),
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: Icon(
              widget.icon,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                if (widget.icon == Icons.lock_open) {
                  widget.icon = Icons.lock_outline;
                } else {
                  widget.icon = Icons.lock_open;
                }
              });
            }),
        hintText: 'Password',
        hintStyle: TextStyle(fontWeight: FontWeight.w600),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
