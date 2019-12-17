import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:software_modeling_ui/ad_manager_page.dart';
import 'package:software_modeling_ui/admin_page.dart';
import 'package:software_modeling_ui/main.dart';
import 'package:software_modeling_ui/state.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (_, state, __) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      state.changeUserType(USER_TYPE.OLD_USER);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Old user"),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      state.changeUserType(USER_TYPE.SUBSCRIPTION_USER);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Subscription user"),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      state.changeUserType(USER_TYPE.NO_ACCOUNT);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(
                          width: 5,
                        ),
                        Text("No account user"),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AdminPage()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.settings),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Admin user"),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdManagerPage()));
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Ad manager user"),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.person),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Manage subscriptions user"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
