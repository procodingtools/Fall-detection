import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final bool bottom;
  final TextCapitalization textCapitalization;
  final bool enabled;
  final bool readOnly;
  final Function onTap;
  final Function(String text) onChanged;
  bool autoFocus;
  Input(
      {this.controller,
      this.hintText,
      this.icon,
      this.obscureText = false,
      this.suffixIcon,
      this.keyboardType,
      this.bottom = true,
      this.textCapitalization = TextCapitalization.none,
      this.enabled = true,
      this.readOnly = false,
        this.autoFocus = false,
      this.onTap, this.onChanged});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            onChanged: onChanged,
            autofocus: autoFocus,
            enabled: enabled,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            style: TextStyle(
                fontFamily: "WorkSansSemiBold",
                fontSize: 16.0,
                color: Colors.black),
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  icon,
                  color: Colors.black,
                ),
                hintText: hintText,
                hintStyle:
                    TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                suffixIcon: suffixIcon),
          ),
        ),
        bottom
            ? Container(
                width: 250.0,
                height: 1.0,
                color: Colors.grey[400],
              )
            : Container()
      ],
    );
  }
}
