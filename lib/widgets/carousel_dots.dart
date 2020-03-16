import 'package:flutter/material.dart';

class CarouselDots extends StatelessWidget {
  final int dotsNumber;
  final int activeDotIndex;

  CarouselDots({this.dotsNumber, this.activeDotIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: _buildDots());
  }

  List<Widget> _buildDots() {
    List<Widget> dots = List();
    for (int i = 0; i < dotsNumber; i++) {
      dots.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: 5.0,
          width: 5.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: activeDotIndex == i ? Colors.black : Colors.white),
        ),
      );
    }
    return dots;
  }
}
