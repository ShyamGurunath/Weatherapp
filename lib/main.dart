import 'package:flutter/material.dart';
import 'weathermain.dart';


void main() => runApp(Myapp());


class Myapp extends StatelessWidget {
  const Myapp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Weatherapp(),
     theme: ThemeData.dark(), 
    );
  }
}


class Weatherapp extends StatefulWidget {
  
  
  @override
  _WeatherappState createState() => _WeatherappState();
}

class _WeatherappState extends State<Weatherapp> {

  

  Weathermodel data = Weathermodel();
  TextEditingController _controller = TextEditingController();
  String cityname = '';
  int temp;
  String desc;
  String url;
  int windspeed;
  

 
   @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text("Weather app"),backgroundColor: Colors.green,),
    body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
          color: Colors.white70,
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:2,horizontal:20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Enter your desired city",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    autofocus: true,
                    cursorColor: Colors.amberAccent,
                    controller: _controller,
                  ),
                ),
                SizedBox(height:20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                        minimumSize: Size(88, 36),
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        ),
                      ),

                  onPressed: () async {
                    try {
                    
                  setState(()   {
                    cityname = _controller.text;
                    });
                    
                    var weatherdata = await data.getthesedata(cityname);
                    if (weatherdata != null) {
                      setState(() {
                        temp = weatherdata['current']['temperature'];
                        url = weatherdata['current']['weather_icons'][0];
                        desc = weatherdata['current']['weather_descriptions'][0];
                        windspeed = weatherdata['current']['wind_speed'];
                      });
                    }
                    else {
                      setState(() {
                        temp = 0;
                        url = 'Erroe';
                        desc = "Erroe";
                        windspeed = 0;

                      });
                    }
                    }
                    catch (e) {
                      final snackBar = SnackBar(content: Text("Enter a city name"));

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    
                    }
                },
               child: Text("Get Weather details",style: TextStyle(color: Colors.white),)),
                
              ],
            ),
          ),
        ),
        temp == null ? Text("Enter some City") : Container(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Text("Temperature : $temp",style: TextStyle(fontSize: 25),),
             SizedBox(height:10),
             Text("Wind Speed : $windspeed",style: TextStyle(fontSize: 25)),
             SizedBox(height:10),
             Text('$desc',style: TextStyle(fontSize: 25)),
             SizedBox(height:10),
             
             
           ],
         ), 
        )
            ],
      ),
    ),
    );
  }
}