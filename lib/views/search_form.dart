import 'package:flutter/material.dart';

final _searchFieldTextController = TextEditingController();
const TextStyle dropDownMenuItemStyle =
TextStyle(color: Colors.black, fontSize: 16.0);
class Search_Form extends StatefulWidget {
  Search_Form({this.onSearch});
  final void Function(String search) onSearch;
  @override
  _Search_FormState createState() => _Search_FormState();
}

class _Search_FormState extends State<Search_Form> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 25.0),
             child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: TextField(
                controller: _searchFieldTextController,
                style: dropDownMenuItemStyle,
                cursorColor: Color(0xFFF3791A),
                decoration: InputDecoration(
                  hintText: 'Enter you search',
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 14.0),
                  suffixIcon: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: InkWell(
                      onTap: () {
                          widget.onSearch(_searchFieldTextController.text);
                          FocusScope.of(context).unfocus();
                          _searchFieldTextController.clear();
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
          ),
           ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}