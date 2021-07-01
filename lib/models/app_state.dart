import 'search_options.dart';
import 'package:restaurant_app/models/api.dart';
class AppState{
  final SearchOptions searchOptions = SearchOptions(
    location: zLocations.first,
    order: zOrder[1],
    sort: zSort[1],
    count: count,
  );
}