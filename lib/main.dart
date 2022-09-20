import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_logout_with_shared_preferences/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Login", style: TextStyle(fontSize: 35),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.email)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.password)),
              ),
              SizedBox(
                height: 10,
              ),
              OutlinedButton.icon(onPressed: (){
                login();
              }, icon: Icon(Icons.login),
              label: Text("Login"))
            ],
          ),
        ),
      )
    );
  }

  void login() async{
    if( emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var response = await http.post(Uri.parse("https://reqres.in/api/login"),
      body: ({
        "email" : emailController.text,
        "password" : passwordController.text

      }));
      if(response.statusCode == 200){
        final body =jsonDecode(response.body);
        //print("Login Token " + body.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Token : ${body['token']}")));

        pageRoute(body['token']);
      } else{
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Blank Value Found")));
    }
  }

  void pageRoute(String token) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("login", token);
      Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
  }
}
