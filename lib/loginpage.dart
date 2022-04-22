import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oppo/clientpage.dart';
import 'package:oppo/registerpage.dart';
import 'package:http/http.dart' as http;
import 'package:oppo/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: splash_screen(),
  ));
}

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String eemail = "";
  String eepassword = "";

  bool estatus = false;
  bool pstatus = false;

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/gree.png"), fit: BoxFit.fill)),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Container(
              width: 250,
              height: theight * .15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage("images/oppo.png"), fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              width: 320,
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                      color: Colors.green,
                    ),
                    labelText: "Email",
                    fillColor: Colors.white30,
                    filled: true,
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 320,
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.vpn_key_outlined,
                      size: 30,
                      color: Colors.green,
                    ),
                    labelText: "Password",
                    fillColor: Colors.white30,
                    filled: true,
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () async {
                estatus = false;
                pstatus = false;

                setState(() {});

                setState(() {
                  eemail = email.text;
                  eepassword = password.text;
                });


                Map map = {
                  "email": eemail,
                  "password": eepassword,
                };

                var url = Uri.parse('https://ashwinbhaiamzon.000webhostapp.com/mylogin.php');

                var response = await http.post(url, body: map);
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                var rr=jsonDecode(response.body);
                loginResponse ll=loginResponse.fromJson(rr);


                if(ll.connection==1)
                  {
                    if(ll.result==1)
                      {
                        String? id=ll.userdata!.id;
                        String?  name=ll.userdata!.name;
                        String?  email=ll.userdata!.email;
                        String?  number=ll.userdata!.number;
                        String?  password=ll.userdata!.password;
                        String?  imagename=ll.userdata!.imagename;


                        splash_screen.preferences!.setBool("loginstatus", true);

                            splash_screen.preferences!.setString("id", id!);
                        splash_screen.preferences!.setString("name", name!);
                        splash_screen.preferences!.setString("email", email!);
                        splash_screen.preferences!.setString("number", number!);
                        splash_screen.preferences!.setString("password", password!);
                        splash_screen.preferences!.setString("imagename", imagename!);

                           setState(() {

                           });
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                  return clientpage();
                                },));
                        Lottie.asset("raw/loading1.json");

                      }
                  }

              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
                width: 220,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              child: Text(
                "Forgot Password ?",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              width: 220,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return acntpage();
                  },
                ));
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(
                  "Creat New OPPO Account",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                width: 280,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 30,
              child: Text(
                "",
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              width: 220,
            ),
          ],
        ),
      ),
    ));
  }
}
class loginResponse {
  int? connection;
  int? result;
  Userdata? userdata;

  loginResponse({this.connection, this.result, this.userdata});

  loginResponse.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? id;
  String? name;
  String? email;
  String? number;
  String? password;
  String? imagename;

  Userdata(
      {this.id,
        this.name,
        this.email,
        this.number,
        this.password,
        this.imagename});

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
    password = json['password'];
    imagename = json['imagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['number'] = this.number;
    data['password'] = this.password;
    data['imagename'] = this.imagename;
    return data;
  }
}
