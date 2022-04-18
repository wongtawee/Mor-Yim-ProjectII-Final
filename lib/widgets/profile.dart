import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final bool autovalidate;
  final TextInputType textInputType;
  final InputDecoration decoration;
  final String Function(String) validator;
  final bool obscureText;

  const TextFormFieldWidget({
    Key key,
    @required this.textController,
    this.autovalidate,
    this.textInputType,
    this.decoration,
    this.validator,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
      child: TextFormField(
        obscureText: obscureText,
        controller: textController,
        keyboardType: textInputType,
        validator: validator,
        decoration: decoration,
      ),
    );
  }
}
