import 'weather.dart';


const the_url = "http://api.weatherstack.com/current";
const api_key = '973845b58ea1698c00daafd81ec4b7c1&query';


class Weathermodel {
  
  int temp;
  String desc;
  int windspeed;
  String image;
  Map data_response;


  Future<dynamic> getthesedata(String cityname) async {

    String url = '$the_url?access_key=$api_key&query=$cityname';
    NetworkHelper weatherdata = NetworkHelper(url: Uri.parse(url));
    var data = await weatherdata.getweatherdata();
    
    if (data == null) {
      return "Data null";
 }
 else {

    return data;
 }


  }


}