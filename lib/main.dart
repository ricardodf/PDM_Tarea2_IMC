import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2 - is714522',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tip time'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum ServiceRating { amazing, good, okay }

class _MyHomePageState extends State<MyHomePage> {
  final numberInputController = TextEditingController();
  ServiceRating? _currentServiceRating = ServiceRating.amazing;
  bool isRounded = false;
  var _tipTotal = "0";

  @override
  void dispose() {
    numberInputController.dispose();
    super.dispose();
  }

  void checkout() {
    switch (_currentServiceRating) {
      case (ServiceRating.amazing):
        double total = double.parse(numberInputController.text);
        setState(() {
          if (isRounded)
            _tipTotal = (total + (total * .20)).toStringAsFixed(0);
          else
            _tipTotal = (total + (total * .20)).toString();
        });
        break;
      case (ServiceRating.good):
        double total = double.parse(numberInputController.text);
        setState(() {
          if (isRounded)
            _tipTotal = (total + (total * .18)).toStringAsFixed(0);
          else
            _tipTotal = (total + (total * .18)).toString();
        });
        break;
      case (ServiceRating.okay):
        double total = double.parse(numberInputController.text);
        setState(() {
          if (isRounded)
            _tipTotal = (total + (total * .15)).toStringAsFixed(0);
          else
            _tipTotal = (total + (total * .15)).toString();
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.room_service),
                Container(width: 18),
                Expanded(
                    child: TextField(
                        controller: numberInputController,
                        decoration:
                            const InputDecoration(hintText: 'Cost of service'),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ]))
              ],
            ),
            Container(height: 18),
            Row(children: [
              Icon(Icons.food_bank),
              Container(width: 18),
              Text("How was the service?", style: TextStyle(fontSize: 16))
            ]),
            Column(children: [
              RadioListTile(
                  title: Text(
                    "Amazing 20%",
                    style: TextStyle(fontSize: 16),
                  ),
                  value: ServiceRating.amazing,
                  groupValue: _currentServiceRating,
                  onChanged: (ServiceRating? value) {
                    setState(() {
                      _currentServiceRating = value;
                    });
                  }),
              RadioListTile(
                  title: Text(
                    "Good 18%",
                    style: TextStyle(fontSize: 16),
                  ),
                  value: ServiceRating.good,
                  groupValue: _currentServiceRating,
                  onChanged: (ServiceRating? value) {
                    setState(() {
                      _currentServiceRating = value;
                    });
                  }),
              RadioListTile(
                  title: Text("Okay 15%"),
                  value: ServiceRating.okay,
                  groupValue: _currentServiceRating,
                  onChanged: (ServiceRating? value) {
                    setState(() {
                      _currentServiceRating = value;
                    });
                  }),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(Icons.credit_card),
                  Container(width: 18),
                  Text("Round up tip", style: TextStyle(fontSize: 16))
                ]),
                Switch(
                  value: isRounded,
                  onChanged: (value) {
                    setState(() {
                      isRounded = value;
                    });
                  },
                  activeTrackColor: Colors.green,
                  activeColor: Colors.greenAccent,
                ),
              ],
            ),
            Container(height: 18),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 16),
                  primary: Colors.green,
                  padding: EdgeInsets.all(16),
                  minimumSize: Size(MediaQuery.of(context).size.width, 20)),
              onPressed: checkout,
              child: const Text('CALCULATE'),
            ),
            Container(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('Tip amount: $_tipTotal')],
            )
          ],
        ),
      )),
    );
  }
}
