import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:mock_data/mock_data.dart';

class User {
  String name;
  String id;
  String address;
  int phoneNumber;
  User(this.name, this.id, this.phoneNumber, this.address);
}

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  List<User> userList = List<User>();
  List<User> searchResults = List<User>();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    super.dispose();
  }

  @override
  void initState() {
    for (int i = 0; i < 100; i++) {
      User newUser =
          User(mockName(), mockString(), mockInteger(), "${mockName()}street");
      userList.add(newUser);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage subscriptions"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width / 2,
          child: FloatingSearchBar.builder(
            itemCount: searchResults.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      " User ID: ${searchResults[index].id}   Name: ${searchResults[index].name}"),
                  FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctxt) => new AlertDialog(
                                title: _buildDialog(),
                              ));
                      myController1.text = searchResults[index].id;
                      myController2.text = searchResults[index].name;
                      myController3.text = searchResults[index].address;
                      myController4.text =
                          searchResults[index].phoneNumber.toString();
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.edit),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Edit"),
                      ],
                    ),
                  ),
                ],
              );
            },
            onChanged: (String value) {
              if (value.isEmpty) {
                setState(() {
                  searchResults.removeRange(0, searchResults.length);
                });
                return;
              }

              userList.forEach((userDetail) {
                if (userDetail.name.contains(value)) {
                  setState(() {
                    searchResults.add(userDetail);
                  });
                }
              });
            },
            onTap: () {},
            decoration: InputDecoration(
              hintText: "Search with id or name",
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialog() {
    return Column(children: <Widget>[
      TextField(
        decoration: new InputDecoration(hintText: 'ID'),
        controller: myController1,
      ),
      TextField(
        decoration: new InputDecoration(hintText: 'Name'),
        controller: myController2,
      ),
      TextField(
        decoration: new InputDecoration(hintText: 'Adress'),
        controller: myController3,
      ),
      TextField(
        decoration: new InputDecoration(hintText: 'Number'),
        controller: myController4,
      ),
      Row(
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
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
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.close),
                SizedBox(
                  width: 5,
                ),
                Text("Close"),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}
