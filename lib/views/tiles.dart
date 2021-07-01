import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/models/restaurants.dart';
import 'package:restaurant_app/views/restaurant_view.dart';

class Tiles extends StatelessWidget {
  Tiles({this.restaurants});
  final List restaurants;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          Restaurant restaurant = Restaurant(restaurants[index]);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Restaurant_View(
                      url: restaurant.url.toString(),
                    ),
                  ),
                );
              },
              child: Parent(
                style: ParentStyle()..elevation(10),
                child: Card(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  borderOnForeground: true,
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: [
                      restaurant.thumbnail != null && restaurant.thumbnail.isNotEmpty
                          ? Ink(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                image: DecorationImage(
                                  image: NetworkImage(restaurant.thumbnail),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              color: Colors.blueGrey,
                              child: Icon(
                                Icons.restaurant,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                      Flexible(
                        // fit: FlexFit.tight,
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      restaurant.locality,
                                      // overflow: TextOverflow.clip,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RatingBarIndicator(
                                  rating: double.parse(restaurant.rating),
                                  itemSize: 20,
                                  itemBuilder: (context, _) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.yellowAccent,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
