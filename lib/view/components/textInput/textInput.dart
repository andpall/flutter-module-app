import 'package:flutter/material.dart';
import 'package:flutter_mod_app/constants/colors.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {Key? key,
      this.onChange,
      this.passwordUsing = false,
      this.label = "",
      this.initialValue = "",
      this.placeholder = ""})
      : super(key: key);

  final Function? onChange;
  final String initialValue;
  final String placeholder;
  final String label;
  final bool passwordUsing;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _isVisible = false;
  late FocusNode _focusNode;

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller.text = widget.initialValue;
    _controller.addListener(_controllerCallback);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _controllerCallback() {
    _onChange(_controller.text);
  }

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
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.white, width: 1),
                    right: BorderSide(color: Colors.white, width: 1),
                    top: BorderSide(color: Colors.white, width: 1),
                    bottom: BorderSide(color: Colors.white, width: 1)),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: SizedBox(
              height: 40,
              child: TextField(
                toolbarOptions: const ToolbarOptions(
                    copy: true, paste: true, selectAll: true, cut: true),
                obscureText: widget.passwordUsing && !_isVisible,
                enableSuggestions: false,
                focusNode: _focusNode,
                autocorrect: false,
                cursorColor: AppColors.mainColor,
                controller: _controller,
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
                            color: _isVisible
                                ? AppColors.disabledBtn
                                : AppColors.disabledBtn,
                          ))
                      : null,
                  focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.mainColor, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  border:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      const UnderlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
