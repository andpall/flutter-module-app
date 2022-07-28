import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mod_app/constants/colors.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {Key? key,
      this.onChange,
      this.passwordUsing = false,
      this.label = "",
      this.placeholder = ""})
      : super(key: key);

  final Function? onChange;
  final String placeholder;
  final String label;
  final bool passwordUsing;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _isVisible = false;

  void _onPressedVisible() {
    setState(() => _isVisible = !_isVisible);
  }

  void _onChange(String value) {
    if (widget.onChange != null) widget.onChange!(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 40,
            child: TextField(
              toolbarOptions: const ToolbarOptions(
                  copy: true, paste: true, selectAll: true, cut: true),
              obscureText: widget.passwordUsing && !_isVisible,
              enableSuggestions: false,
              autocorrect: false,
              cursorColor: mainColor,
              onChanged: _onChange,
              decoration: InputDecoration(
                  fillColor: const Color.fromRGBO(224, 231, 255, 0.3),
                  filled: true,
                  hintText: widget.placeholder,
                  suffixIcon: widget.passwordUsing
                      ? GestureDetector(
                          onTap: _onPressedVisible,
                          child: Icon(
                            _isVisible
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined,
                            color: _isVisible ? disabledBtn : disabledBtn,
                          ))
                      : null,
                  border: const UnderlineInputBorder(),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: mainColor))),
            ),
          ),
        ],
      ),
    );
  }
}
