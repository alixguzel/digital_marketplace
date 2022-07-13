import 'package:flutter/material.dart';
import 'package:digital_marketplace/style_elements/text_field.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFieldContainer(
        child: TextField(
          onChanged: onChanged,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.black26),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const PasswordField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFieldContainer(
        child: TextField(
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          onChanged: onChanged,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            icon: Icon(icon, color: Colors.black26),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
