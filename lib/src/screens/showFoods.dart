import 'package:flutter/material.dart';
import 'package:nirogi/src/models/foodtips.dart';

class ShowFoods extends StatelessWidget {
  final FoodTips foodTips;
  ShowFoods({
    Key key,
    @required this.foodTips,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(foodTips.diseaseName,
                style: Theme.of(context).textTheme.headline),
            SizedBox(
              width: 65,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TipsBox(
              foods: foodTips.toEat,
              heading: 'Foods To Eat: ',
              headingColor: Colors.green[600],
              lineColor: Colors.green,
              backgroundColor: Colors.green[100],
              tipIcon: Icons.check,
            ),
            TipsBox(
              foods: foodTips.toAvoid,
              heading: 'Foods To Avoid: ',
              headingColor: Colors.redAccent,
              lineColor: Colors.red,
              backgroundColor: Colors.red[100],
              tipIcon: Icons.close,
            ),
          ],
        ),
      ),
    );
  }
}

class TipsBox extends StatelessWidget {
  const TipsBox({
    Key key,
    @required this.foods,
    @required this.heading,
    this.headingColor,
    this.lineColor,
    this.tipIcon, this.backgroundColor,
  }) : super(key: key);

  final List<String> foods;
  final String heading;
  final Color lineColor;
  final Color headingColor;
  final Color backgroundColor;
  final IconData tipIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5  , 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,2),
            child: Text(
              heading,
              style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.headline.fontFamily,
                  color: headingColor,
                  fontSize: 22),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 2.0,
                color: lineColor,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: Icon(
                  tipIcon,
                  color: lineColor,
                ),
              ),
              Container(
                height: 2.0,
                color: lineColor,
                width: 100,
              ),
            ],
          ),
          SizedBox(
            height: 3.0,
          ),
          Container(
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: foods.length,
              itemBuilder: (BuildContext context, int index) {
                return FoodCard(foods: foods[index], backgroundColor: backgroundColor);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 13.0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  const FoodCard({
    Key key,
    @required this.foods, this.backgroundColor,
  }) : super(key: key);

  final String foods;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: backgroundColor,
        height: 45.0,
        child: Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            Container(
              height: 260,
              width: 160,
              child: Image.asset(
                'assets/images/icons/foodtips.png',
                width: 30,
              ),
            ),
            Positioned(
              left: 0.0,
              bottom: 0.0,
              height: 290,
              width: 160,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
              ),
            ),
            Positioned(
              bottom: 7,
              left: 10,
              child: Text(
                foods,
                style: TextStyle(
                    fontFamily: Theme.of(context)
                        .textTheme
                        .headline
                        .fontFamily,
                    color: Colors.white,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

