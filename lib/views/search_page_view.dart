import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:restaurant_app/models/choicechip.dart';
import 'package:restaurant_app/models/constants.dart';
import 'package:restaurant_app/models/custom_clipper.dart';
import 'package:restaurant_app/models/search_options.dart';
import 'package:restaurant_app/models/app_state.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/location.dart';
import 'package:restaurant_app/views/search_filter.dart';
import 'package:restaurant_app/views/search_form.dart';
import 'package:restaurant_app/views/tiles.dart';
import 'package:division/division.dart';





class SearchPage extends StatefulWidget {
  final String title;
  final dio = Dio(BaseOptions(
    baseUrl: 'https://developers.zomato.com/api/v2.1/',
    headers: {
      'user-key': apiKey,
    },
  ));
  SearchPage({this.title});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List _restaurants;

  Location location = Location();
  double latitude;
  double longitude;
  String query;
  Future<List> searchRestaurants(String query, SearchOptions options) async {
    final response = await widget.dio.get(
      "search",
      queryParameters: {
        'q': query,
        'lat': location.latitude,
        'lon': location.longitude,
        // ignore: unnecessary_null_comparison
        ...(options != null ? options.toJson() : {}),
      },
    );
    return response.data['restaurants'];
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AppState>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 320.0,
              decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [firstColor, secondColor],
              )),
              child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Zomato-Clone',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Tell us about your Cravings!!',
                  style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Search_Form(onSearch: (value){
                setState(() {
                  query=value;
                });
              },),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchFilters(
                            dio: widget.dio,
                          )));
                },
                child: Choicechip(
                  icon: Icons.tune,
                  text: 'Filter',
                  isSelected: true,
                ),
              ),
            ],
              ),
            )
            ),
            query == null
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black12,
                          size: 110,
                        ),
                        Text(
                          'No results to display',
                          style: TextStyle(fontSize: 20, color: Colors.black12),
                        )
                      ],
                    ),
                  )
                : FutureTiles(
                    searchRestaurants:
                        searchRestaurants(query, state.searchOptions),
                  )
          ],
        ),
      ),
    );
  }
}





class FutureTiles extends StatelessWidget {
  FutureTiles({this.searchRestaurants});
  final Future searchRestaurants;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: searchRestaurants,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return Expanded(
              child: Tiles(
                restaurants: snapshot.data,
              ),
            );
          } else {
            return Text('Error retrieving results: ${snapshot.error}');
          }
        },);
  }
}
