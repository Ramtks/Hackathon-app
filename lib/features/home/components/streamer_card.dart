import 'package:flutter/material.dart';

class PartyCard extends StatelessWidget {
  final String name;
  final String movieName;
  final VoidCallback onPressed;
  const PartyCard(
      {super.key,
      required this.name,
      required this.movieName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 100,
        child: Card(
            child: Row(
          children: [
            SizedBox(height: 60, width: 70, child: CircleAvatar()),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Name: $name'), Text('Movie name: $movieName')],
            )
          ],
        )),
      ),
    );
  }
}
