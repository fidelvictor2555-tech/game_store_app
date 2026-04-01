import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/car_model.dart';

class shopping_cart extends StatelessWidget {
  const shopping_cart({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("MarketPlace"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView.builder(
            itemCount: myCarNames.length,
            itemBuilder: (context, index) {
              var yom = ["2010", "2015", "2020", "2018"];
              var myCarNames = ["Camry", "mercedes", "Elemento", "BMW 315"];
              var myCars = [
                CarModel(name: "Camry", year: "2010"),
                CarModel(name: "Elemento", year: "2015"),
                CarModel(name: "mercedes", year: "2020"),
                CarModel(name: "BMW 315", year: "2018"),
              ];

              return Row(
                children: [
                  Image.asset("assets/image/dental_logo.png"),
                  Column(children: [Text(myCarNames[index])]),
                  Column(children: [Text(myCars[index].name)]),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class myCarNames {
  static int? get length => null;
}
