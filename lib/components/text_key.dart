import 'package:flutter/material.dart';

class TextKey extends StatelessWidget {
  const TextKey({
    Key? key,
    required this.text,
    required this.onTextInput,
  }) : super(key: key);

  final String text;
  final ValueSetter<String> onTextInput;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).primaryColorLight,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 3,
                spreadRadius: 1),
          ]),
      child: TextButton(
        onPressed: () {
          onTextInput.call(text);
        },
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).primaryColorDark, fontSize: 16),
        )),
      ),
    );
  }
}
