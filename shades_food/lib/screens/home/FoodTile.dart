import 'package:flutter/material.dart';

class FoodTile extends StatefulWidget {
  String image, title, price, description;
  FoodTile({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  _FoodTileState createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Color(0xffFEF1E6), borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 4.0),
          child: Row(
            children: [
              Container(
                // width: MediaQuery.of(context).size.width * 0.4,
                // padding: EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 4.0, top: 4.0, bottom: 4.0, right: 50.0),
                  child: Image.network(
                    widget.image,
                    height: 80,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          fontFamily: 'MenuIcon',
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '\u{20B9}${widget.price}',
                        // textAlign: TextAlign.left,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            fontFamily: 'MenuIcon',
                            color: Colors.orange),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
