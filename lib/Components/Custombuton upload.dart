import 'package:flutter/material.dart';

class Custombuttonupload extends StatelessWidget {
  final void Function() onPressed;
  final String Title;
  final bool Isselected;
  const Custombuttonupload(
      {super.key, required this.onPressed, required this.Title, required this.Isselected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: MaterialButton(
        textColor: Colors.white,
        height: 40,
        minWidth: 200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(Title),
        color: Isselected? Colors.green:Colors.orange,
        onPressed: onPressed,
      ),
    );
  }
}
