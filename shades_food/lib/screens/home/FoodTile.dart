import 'package:flutter/material.dart';

class FoodTile extends StatefulWidget {
  final String image, title, price;
  const FoodTile({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  _FoodTileState createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                widget.image,
                height: 100,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\u{20B9}${widget.price}',
                      // textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.orange),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
