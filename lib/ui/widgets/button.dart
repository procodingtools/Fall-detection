import 'package:flutter/material.dart';
import '../../style/theme.dart' as Theme;

class Button extends StatelessWidget {
  final Function onPressed;
  final String label;
  final EdgeInsets margin;
  final double labelSize;

  const Button(
      {Key key, this.onPressed, this.label, this.margin, this.labelSize = 25})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
//      margin: EdgeInsets.only(top: 160.0), //login top margin
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.Colors.buttonGradientStart,
            //offset: Offset(1.0, 6.0),
            //blurRadius: 0.0,
          ),
          BoxShadow(
            color: Theme.Colors.buttonGradientEnd,
            //offset: Offset(1.0, 2.0),
            //blurRadius: 0.0,
          ),
        ],
        gradient: new LinearGradient(
            colors: [
              Theme.Colors.buttonGradientEnd,
              Theme.Colors.buttonGradientStart
            ],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: Theme.Colors.buttonGradientEnd,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: labelSize,
                fontFamily: "WorkSansBold",
              ),
            ),
          ),
          onPressed: onPressed),
    );
  }
}
