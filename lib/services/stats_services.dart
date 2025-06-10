import 'dart:convert';
import 'package:covid_tracker/models/WorldStatsModel.dart';
import 'package:covid_tracker/services/utilities/app_uri.dart';
import 'package:http/http.dart' as http;
class StatsServices{
  Future<WorldStatsModel> fetchWorldStatsRecords()async{
    final response = await http.get(Uri.parse(AppUri.worldStatesApi));
if(response.statusCode == 200){
  var data = jsonDecode(response.body);
return WorldStatsModel.fromJson(data);
}
else{
throw Exception('Error');}}

  Future<List<dynamic>> countriesListApi()async{
    var data;
    final response = await http.get(Uri.parse(AppUri.countriesList));
    if(response.statusCode == 200){
       data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');}}

}