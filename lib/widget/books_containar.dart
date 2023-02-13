import 'package:flutter/material.dart';
class BooksContainar extends StatelessWidget {
  final String name;
  final String image;
  const BooksContainar({Key? key, required this.name, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left:5,right: 5,top: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.indigo.shade400,
            borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(image),fit: BoxFit.fill),
              ),
            ),
            SizedBox(height: 5),
            Text(name),
          ],
        ),
      ),
    );
  }
}
