import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

  NetworkHelper({@required this.url});
  final Uri url;
  
  Future<dynamic> getweatherdata() async {

    var response = await http.get(url);

    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else {
      print("Not connected");
      return "None";
    }



  }


}