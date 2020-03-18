import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAssetPath;
  final String price;
  final String description;
  final bool isActive;

  CarouselItem(
      {@required this.title,
      @required this.isActive,
      this.subtitle,
      this.imageAssetPath,
      this.price,
      this.description});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.symmetric(vertical: isActive ? 0 : 60),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Dish title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                SizedBox(height: 8.0),
                // Dish short description
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                //Dish image path
                imageAssetPath != null
                    ? Image.asset(imageAssetPath)
                    : Container(
                        height: 200.0,
                      ),
                SizedBox(height: 8.0),
                //Dish price
                Text(
                  price,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                // Dish description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                SizedBox(height: 16.0),
                // Buy button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                      child: Center(
                        child: Text('Buy'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
