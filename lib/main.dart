import 'package:food_app_ui/models/plate.dart';
import 'package:food_app_ui/widgets/carousel_dots.dart';
import 'package:food_app_ui/widgets/carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange[300],
        accentColor: Colors.black,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _nationalities;
  List<Plate> _plates = List();
  PageController _pageController;
  int _nationalitiesSelectedIndex = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    _nationalities = ['Polish', 'Peruvian', 'Italian', 'French', 'Spanish'];
    for (int i = 0; i < 3; i++) {
      _plates.add(
        Plate(
            name: 'Grilled beef',
            shortDescription: 'Peruvian food',
            imagePath: 'assets/images/peruvian_grilled_beef.jpg',
            price: '\$ 8.00',
            description: 'grilled beaf steak and potatoes on plate isolated'),
      );
    }
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
          'FAST FOOD',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                itemCount: _plates.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CarouselItem(
                      isActive: index == _currentIndex,
                      title: _plates[index].name,
                      description: _plates[index].description,
                      subtitle: _plates[index].shortDescription,
                      imageAssetPath: _plates[index].imagePath,
                      price: _plates[index].price,
                    ),
                  );
                }),
          ),
          SizedBox(height: 8.0),
          CarouselDots(dotsNumber: _plates.length,activeDotIndex: _currentIndex,),
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
