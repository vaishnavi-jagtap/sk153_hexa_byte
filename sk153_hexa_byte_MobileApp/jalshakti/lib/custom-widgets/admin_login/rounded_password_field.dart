import 'package:flutter/material.dart';
import 'package:jalshakti/custom-widgets/admin_login/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _showPassword,
        onChanged: widget.onChanged,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.deepPurpleAccent,
          ),
          suffixIcon: IconButton(
            icon: _showPassword
                ? Icon(
                    Icons.visibility,
                    color: Colors.deepPurpleAccent,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: Colors.deepPurpleAccent,
                  ),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
