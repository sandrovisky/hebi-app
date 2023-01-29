library numeric_keyboard;

import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class ModifiedNumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Icon? rightIcon;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Icon? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  const ModifiedNumericKeyboard(
      {Key? key,
      required this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightIcon,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ModifiedNumericKeyboardState();
  }
}

class _ModifiedNumericKeyboardState extends State<ModifiedNumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                _calcButton('1'),
                _calcButton('2'),
                _calcButton('3'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                _calcButton('4'),
                _calcButton('5'),
                _calcButton('6'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                _calcButton('7'),
                _calcButton('8'),
                _calcButton('9'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                      onTap: widget.leftButtonFn,
                      child: Container(
                          alignment: Alignment.center, child: widget.leftIcon)),
                ),
                _calcButton('0'),
                Expanded(
                  child: InkWell(
                      onTap: widget.rightButtonFn,
                      child: Container(
                          alignment: Alignment.center,
                          child: widget.rightIcon)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return Expanded(
      flex: 1,
      child: InkWell(
        highlightColor: Colors.white,
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              value,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: widget.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
