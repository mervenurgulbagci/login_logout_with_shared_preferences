import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Text("Welcome User"),
                  SizedBox(height: 30),
                  OutlinedButton.icon(
                      onPressed:  () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        await pref.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => LoginPage()),(route) => false);                    },
                      icon: Icon(Icons.logout),
                      label: Text("Logout"))
                ],
              ),

        )),
      ),
    );
  }
}
