import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/models/categories.dart';
import 'package:restaurant_app/models/api.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/app_state.dart';
import 'package:restaurant_app/models/custom_clipper.dart';

class SearchFilters extends StatefulWidget {
  SearchFilters({this.dio});
  final Dio dio;
  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}



class _SearchFiltersState extends State<SearchFilters> {
  List<Category> _categories;
  Future<List<Category>> getCategories() async{
    final response =await widget.dio.get('categories');
    final data=response.data['categories'];
    return data.map<Category>((json)=>Category(
      json['categories']['id'],
      json['categories']['name'],
    )).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getCategories().then((categories){
      setState(() {
        _categories=categories;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final state=Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Your Search'),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: ListView(
        children: [
          // SizedBox(height: 10),
          _categories is List<Category>?
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 400.0,
              // decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [firstColor, secondColor],
                  // ),
                // ),
              color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: Text(
                      'Categories',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Wrap(
                      spacing: 10,
                      children: List<Widget>.generate(
                          _categories.length,
                              (index) {
                            final category=_categories[index];
                            final isSelected=state.searchOptions.categories.contains(category.id);
                            return  FilterChip(
                              label: Text(category.name),
                              labelStyle: TextStyle(
                                color:isSelected? Colors.red:
                                Colors.black,
                                fontWeight: isSelected?FontWeight.bold:FontWeight.w300,
                              ),
                              selected: isSelected,
                              selectedColor: Colors.white,
                              checkmarkColor: Colors.red,
                              onSelected: (bool selected){
                                setState(() {
                                  if(selected){
                                    state.searchOptions.categories.add(category.id);
                                  }
                                  else{
                                    state.searchOptions.categories.remove(category.id);
                                  }
                                });
                              },
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ):
          Center(child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircularProgressIndicator(),
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(
                  'Location type:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                    isExpanded: true,
                    value: state.searchOptions.location,
                    items: zLocations.map<DropdownMenuItem<String>>(
                          (value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        state.searchOptions.location = value;
                      });
                    }),
                SizedBox(height: 30),
                Text(
                  'Order by:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                for (int idx = 0; idx < zOrder.length; idx++)
                  RadioListTile(
                      title: Text(zOrder[idx]),
                      value: zOrder[idx],
                      groupValue: state.searchOptions.order,
                      onChanged: (selection) {
                        setState(() {
                          state.searchOptions.order = selection;
                        });
                      }),
                SizedBox(height: 30),
                Text(
                  'Sort by:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: 10,
                  children: zSort.map<ChoiceChip>((sort) {
                    return ChoiceChip(
                      label: Text(sort),
                      selected: state.searchOptions.sort == sort,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            state.searchOptions.sort = sort;
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 30),
                Text(
                  '# of results to show:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                    value: state.searchOptions.count ?? 5,
                    min: 5,
                    max: count,
                    label: state.searchOptions.count?.round().toString(),
                    divisions: 3,
                    onChanged: (value) {
                      setState(() {
                        state.searchOptions.count = value;
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
