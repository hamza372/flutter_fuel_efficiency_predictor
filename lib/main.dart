import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> regionlist;
  String region;
  String result = '?';
  double imgHeight = 100;
  TextEditingController accelC = TextEditingController(),
      displaceC = TextEditingController(),
      weiC = TextEditingController(),
      horsePC = TextEditingController(),
      cylinC = TextEditingController(),
      modelY = TextEditingController();
  var mean = [
    5.477707,
    195.318471,
    104.869427,
    2990.251592,
    15.559236,
    75.898089,
    0.624204,
    0.178344,
    0.197452
  ];
  var std = [
    1.699788,
    104.331589,
    38.096214,
    843.898596,
    2.789230,
    3.675642,
    0.485101,
    0.383413,
    0.398712
  ];
  Interpreter interpreter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
    regionlist = ["USA", "Europe", "Canada"];
    region = regionlist.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.cyan,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    color: Colors.cyan,
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 20, bottom: 30),
                            child: Image.asset(
                              'images/car3.png',
                              height: 150,
                            )),
                        Container(
                            child: Text(
                          'Fuel Efficiency = $result',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    color: Colors.red,
                    child: Row(
                      children: [
                        Image.asset(
                          'images/car3.png',
                          height: imgHeight,
                        ),
                        Container(
                          child: TextField(
                            controller: cylinC,
                            decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: false,
                                hintText: 'Cylinders',
                                hintStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          width: 100,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    color: Colors.orange,
                    child: Row(
                      children: [
                        Container(
                          child: TextField(
                            controller: displaceC,
                            decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: false,
                                hintText: 'displacement',
                                hintStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          width: 100,
                        ),
                        Image.asset(
                          'images/car3.png',
                          height: imgHeight,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    color: Colors.yellowAccent,
                    child: Row(
                      children: [
                        Image.asset(
                          'images/car3.png',
                          height: imgHeight,
                        ),
                        Container(
                          child: TextField(
                            controller: horsePC,
                            decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: false,
                                hintText: 'Horse Power',
                                hintStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          width: 100,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    color: Colors.lightGreen,
                    child: Row(
                      children: [
                        Container(
                          child: TextField(
                            controller: weiC,
                            decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: false,
                                hintText: 'Weight',
                                hintStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          width: 100,
                        ),
                        Image.asset(
                          'images/car3.png',
                          height: imgHeight,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Image.asset(
                          'images/car3.png',
                          height: imgHeight,
                        ),
                        Container(
                          child: TextField(
                            controller: accelC,
                            decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: false,
                                hintText: 'Accelration',
                                hintStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          width: 100,
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    color: Colors.indigoAccent,
                    child: Row(
                      children: [
                        Container(
                          child: TextField(
                            controller: modelY,
                            decoration: InputDecoration(
                                fillColor: Colors.black,
                                filled: false,
                                hintText: 'Model Year',
                                hintStyle: TextStyle(color: Colors.black)),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          width: 100,
                        ),
                        Image.asset(
                          'images/car3.png',
                          height: imgHeight,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25, bottom: 25),
                    color: Colors.indigo,
                    child: Row(
                      children: [
                        Image.asset(
                          'images/car3.png',
                          height: imgHeight,
                        ),
                        Container(
                          child: DropdownButton<String>(
                            value: '$region',
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            underline: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                            onChanged: (String data) {
                              setState(() {
                                region = data;
                              });
                            },
                            items: regionlist
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          width: 100,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                  ),    
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              doInference();
            },
            tooltip: 'Increment',
            child: Icon(Icons.done_outline),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }


  void loadModel() async {
    // Creating the interpreter using Interpreter.fromAsset
    interpreter = await Interpreter.fromAsset('automobile.tflite');
    print('Interpreter loaded successfully');
  }

  doInference() {
    // For ex: if input tensor shape [1,1] and type is float32
    var usa = 0, europe = 0, japan = 0;
    if (region == regionlist[0]) {
      usa = 1;
    } else if (region == regionlist[1]) {
      europe = 1;
    } else if (region == regionlist[2]) {
      japan = 1;
    }
    var inputArr = [
      (double.parse(cylinC.text) - mean[0]) / std[0],
      (double.parse(displaceC.text) - mean[1]) / std[1],
      (double.parse(horsePC.text) - mean[2]) / std[2],
      (double.parse(weiC.text) - mean[3]) / std[3],
      (double.parse(accelC.text) - mean[4]) / std[4],
      (double.parse(modelY.text) - mean[5]) / std[5],
      double.parse(((usa-mean[6])/std[6]).toString()),
      double.parse(((europe-mean[7])/std[7]).toString()),
      double.parse(((japan-mean[8])/std[8]).toString())
    ];
    // if output tensor shape [1,2] and type is float32
    var output = List(1 * 1).reshape([1, 1]);
    // inference
    interpreter.run(inputArr, output);
    // print the output
    print(output);
    setState(() {
      result = output[0][0].toStringAsFixed(2) + " MPG";
      print(result);
    });
  }
}
