import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextInput extends StatefulWidget {
  const TextInput({Key? key, this.onChange, this.passwordUsing = false})
      : super(key: key);

  final Function? onChange;
  final bool passwordUsing;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _isVisisble = false;

  void _onPressedVisible() {
    setState(() {
      _isVisisble = !_isVisisble;
    });
  }

  void _onChange(String value) {
    if (widget.onChange != null) widget.onChange!(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: TextField(
            obscureText: widget.passwordUsing && _isVisisble,
            enableSuggestions: false,
            autocorrect: false,
            onChanged: _onChange,
          )),
          widget.passwordUsing
              ? GestureDetector(
                  onTap: _onPressedVisible,
                  child: Icon(_isVisisble
                      ? Icons.remove_red_eye
                      : Icons.remove_red_eye_outlined))
              : Container(),
        ],
      ),
    );
  }
}
