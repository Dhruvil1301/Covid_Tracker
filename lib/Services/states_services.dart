import 'dart:convert';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:http/http.dart'as http;
import '../Models/world_states_model.dart';
class StatesServices{
  Future<WorldStatesModel> fetchWorldStatesRecords () async{
    final response= await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode==200){
      var data =jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception("Error");
    }

  }
Future<List<dynamic>>countriesList() async{
    var data;
  final response= await http.get(Uri.parse(AppUrl.countriesList));
  if(response.statusCode==200){
     data =jsonDecode(response.body);
    return data;
  }
  else{
    throw Exception("Error");
  }

}}