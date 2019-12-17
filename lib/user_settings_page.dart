import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';

class UserSettingsPage extends StatefulWidget {
  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  String value = "Choose";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Your subscription information: ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Name : ${mockName()}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Address : ${mockName()}street",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Subscription started : ${mockDate()}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Subscription ending : ${mockDate()}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Cost : 10€/month",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Your subscription information: ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButton<String>(
                    hint: Text(value),
                    items: <String>['Check', 'Card', 'Paypal', 'Bank account']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        value = newValue;
                      });
                    },
                  ),
                  value == "Card"
                      ? TextField(
                          decoration:
                              new InputDecoration(hintText: 'Card number'),
                        )
                      : Container(),
                  value == "Card"
                      ? TextField(
                          decoration:
                              new InputDecoration(hintText: 'Card date'),
                        )
                      : Container(),
                  value == "Card"
                      ? TextField(
                          decoration:
                              new InputDecoration(hintText: 'Card secret'),
                        )
                      : Container(),
                  FlatButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.save),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Save"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
