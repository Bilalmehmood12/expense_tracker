import 'package:flutter/material.dart';

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    Key? key,
    required this.onBackspace,
  }) : super(key: key);

  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 91,
      height: 42,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.red,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 3,
                spreadRadius: 1),
          ]),
      child: TextButton(
        onPressed: () {
          onBackspace.call();
        },
        child: Center(
            child: Text(
          "Delete",
          style: TextStyle(
              color: Theme.of(context).primaryColorLight, fontSize: 16),
        )),
      ),
    );
  }
}
