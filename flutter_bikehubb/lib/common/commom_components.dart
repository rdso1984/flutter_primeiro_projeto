import 'package:flutter/material.dart';

class CommomComponents extends StatelessWidget {

  const CommomComponents({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text(''),),
           body: Container(),
       );
  }
}

class NavigationButton extends StatelessWidget {
  final String label;
  final String navigationTo;

  const NavigationButton({
    super.key,
    required this.label,
    required this.navigationTo,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, navigationTo);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1c222e),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(
            color: Color(0xFF22c55e),
            width: 1,
          ),
        ),
        elevation: 4,
      ),
      child: Text(label),
    );
  }
}