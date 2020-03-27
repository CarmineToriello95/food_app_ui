import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app_ui/models/dish.dart';
import 'package:food_app_ui/widgets/carousel_dots.dart';
import 'package:food_app_ui/widgets/carousel_item.dart';

import 'details.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _nationalities;
  List<Dish> _dishes;
  PageController _pageController;
  int _nationalitiesSelectedIndex = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    _nationalities = ['Polish', 'Peruvian', 'Italian', 'French', 'Spanish'];
    _dishes = DishesGenerator.dishes;
    _pageController.addListener(() {
      int next = _pageController.page.round();
      if (_currentIndex != next) {
        setState(() {
          _currentIndex = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Fast Food',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: AppBarLeadingIcon(),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: CircleAvatar(
              maxRadius: 15.0,
              minRadius: 15.0,
              backgroundColor: Colors.black.withOpacity(0.5),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 40.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _nationalities.length,
              itemBuilder: (_, index) => NationalityListItem(
                text: _nationalities[index],
                isSelected: _nationalitiesSelectedIndex == index,
                onItemTap: () {
                  setState(() {
                    _nationalitiesSelectedIndex = index;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 550,
            child: PageView.builder(
                controller: _pageController,
                itemCount: _dishes.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Details(dish: _dishes[index]),
                        ),
                      ),
                      child: CarouselItem(
                        isActive: index == _currentIndex,
                        title: _dishes[index].name,
                        description: _dishes[index].description,
                        subtitle: _dishes[index].shortDescription,
                        imageAssetPath: _dishes[index].imagePath,
                        price: _dishes[index].price,
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(height: 8.0),
          CarouselDots(
            dotsNumber: _dishes.length,
            activeDotIndex: _currentIndex,
          ),
        ],
      ),
    );
  }
}

class AppBarLeadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Icon(Icons.menu),
    );
  }
}

class NationalityListItem extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function onItemTap;
  NationalityListItem({@required this.text, this.isSelected, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: isSelected ? Colors.black : Colors.white),
        child: Text(text,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
      ),
    );
  }
}
