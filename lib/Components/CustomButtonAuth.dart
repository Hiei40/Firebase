import 'package:flutter/material.dart';

class Custombuttonauth extends StatelessWidget {
  final  void Function() onPressed;
  final String Title;
  const Custombuttonauth({super.key, required this.onPressed, required this.Title});

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: double.infinity,
      child: MaterialButton(
        textColor: Colors.white,
        height: 40,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(Title),
        color: Colors.orange,
        onPressed:onPressed,
      ),
    );
  }
}
