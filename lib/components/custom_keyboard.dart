

import 'package:flutter/material.dart';
import 'backspace_key.dart';
import 'text_key.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
    Key? key,
    required this.onTextInput,
    required this.onBackspace,
  }) : super(key: key);

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;

  void _textInputHandler(String text) => onTextInput.call(text);

  void _backspaceHandler() => onBackspace.call();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextKey(
              text: '1',
              onTextInput: _textInputHandler,
            ),
            const SizedBox(width: 7,),
            TextKey(
              text: '2',
              onTextInput: _textInputHandler,
            ),
            const SizedBox(width: 7,),
            TextKey(
              text: '3',
              onTextInput: _textInputHandler,
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextKey(
              text: '4',
              onTextInput: _textInputHandler,
            ),
            const SizedBox(width: 7,),
            TextKey(
              text: '5',
              onTextInput: _textInputHandler,
            ),
            const SizedBox(width: 7,),
            TextKey(
              text: '6',
              onTextInput: _textInputHandler,
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextKey(
              text: '7',
              onTextInput: _textInputHandler,
            ),
            const SizedBox(width: 7,),
            TextKey(
              text: '8',
              onTextInput: _textInputHandler,
            ),
            const SizedBox(width: 7,),
            TextKey(
              text: '9',
              onTextInput: _textInputHandler,
            ),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextKey(
              text: '0',
              onTextInput: _textInputHandler,
            ),
            const SizedBox(width: 7,),
            BackspaceKey(
              onBackspace: _backspaceHandler,
            ),
          ],
        ),
      ],
    );
  }

}
