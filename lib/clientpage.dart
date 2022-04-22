import 'package:flutter/material.dart';
import 'package:oppo/addpage.dart';
import 'package:oppo/loginpage.dart';
import 'package:oppo/splashscreen.dart';
import 'package:oppo/viewpage.dart';

class clientpage extends StatefulWidget {
  const clientpage({Key? key}) : super(key: key);

  @override
  State<clientpage> createState() => _clientpageState();
}

class _clientpageState extends State<clientpage> {
  List<Widget> ll = [viewpage(), addpage()];
  int cnt = 0;

  String? id;
  String? name;
  String? email;
  String? number;
  String? password;
  String? imagename;
  String title="";
  String ptitle="PRODUCT";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  void initial() {
    id = splash_screen.preferences!.getString("id") ?? "";
    name = splash_screen.preferences!.getString("name") ?? "";
    email = splash_screen.preferences!.getString("email") ?? "";
    number = splash_screen.preferences!.getString("number") ?? "";
    password = splash_screen.preferences!.getString("password") ?? "";
    imagename = splash_screen.preferences!.getString("imagename") ?? "";
    setState(() {});
    print(id);
    print(name);
    print(email);
    print(number);
    print(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$ptitle"), backgroundColor: Color(0xFF8EE7F4)),
      body: ll[cnt],
      drawer: Drawer(
          backgroundColor: Colors.green.shade100,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text("$name"),
                  accountEmail: Text("$email"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://ashwinbhaiamzon.000webhostapp.com/$imagename"),
                  )),
              ListTile(
                onTap: () {
                  cnt = 0;
                  ptitle="VIEW PAGE";
                  Navigator.pop(context);
                  setState(() {});
                },
                leading: Icon(
                  Icons.search,
                  color: Colors.black26,
                  size: 36,
                ),
                title: Text("View Product"),
                subtitle: Text("View"),
                trailing: Icon(Icons.arrow_forward, size: 26),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  cnt = 1;
                  ptitle="ADD PRODUCT";
                  setState(() {

                  });
                },
                leading: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.purpleAccent,
                  size: 36,
                ),
                title: Text("Add Product"),
                subtitle: Text("Shop"),
                trailing: Icon(Icons.arrow_forward, size: 26),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.blue,
                  size: 36,
                ),
                title: Text("Your Product in Cart"),
                subtitle: Text("Payment"),
                trailing: Icon(Icons.arrow_forward, size: 26),
              ),
              SizedBox(
                height: 180,
              ),
              ListTile(
                onTap: () {
                  splash_screen.preferences!.setBool("loginstatus", false);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return loginpage();
                    },
                  ));
                },
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.brown,
                  size: 36,
                ),
                title: Text("LOGOUT"),
                subtitle: Text("Good Day"),
                trailing: Icon(Icons.logout, size: 26),
              )
            ],
          )),
    );
  }
}
