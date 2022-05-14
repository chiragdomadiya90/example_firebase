import 'dart:convert';
import '../api_handler/api_handler.dart';
import '../model/apimodel.dart';

class ApiService {
  static Future<List<ApiModel>?> getCovid() async {
    var response = await API.apiHandler(
        url: 'https://corona.lmao.ninja/v3/covid-19/countries',
        apiType: ApiType.aGet);
    print(jsonDecode(response));
    return apiModelFromJson(response);
  }
}

class CovidService {
  static Future getAllCovid() async {
    var response = await API.apiHandler(
        url: 'https://corona.lmao.ninja/v3/covid-19/all',
        apiType: ApiType.aGet);
    print(jsonDecode(response));
    return jsonDecode(response);
  }
}
