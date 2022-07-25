import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mod_app/src/constants/colors.dart';

class BigButton extends StatelessWidget {
  const BigButton({Key? key, this.onPressed, this.child, this.icon})
      : super(key: key);
  final Function()? onPressed;
  final Widget? child;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        height: 40,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: GestureDetector(
          child: Row(
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor),
                      fixedSize:
                          MaterialStateProperty.all(Size(width - 48, 40)),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 20)),
                      elevation: MaterialStateProperty.all(0)),
                  onPressed: onPressed,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 40,
                        child: icon ?? Container(),
                      ),
                      Center(
                        child: child ?? Container(),
                      ),
                    ],
                  )),
            ],
          ),
        ));
  }
}
