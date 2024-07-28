import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {

  final String tilte;
  final VoidCallback onTap;
  final bool loading;

  const RoundButton({required this.tilte, required this.onTap, this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10)
        ),
        height: 75,
        child: Center(
          child: loading? CircularProgressIndicator(
            strokeWidth: 4,color: Colors.white,
          ): Text(tilte,
          style: const TextStyle(
            color: Colors.white
          ),),
        ),
      ),
    );
  }
}
