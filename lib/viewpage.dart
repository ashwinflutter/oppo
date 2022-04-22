import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oppo/clientpage.dart';
import 'package:oppo/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:oppo/updatepage.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  String str = "";
  String name = "";
  String price = "";
  String detail = "";
  String? id;

  Viewresponse? vp;

  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = splash_screen.preferences!.getString("id") ?? "";
    getViewProduct();
  }

  Future<void> getViewProduct() async {
    Map map = {
      "loginid": id,
    };
    var url =
    Uri.parse('https://ashwinbhaiamzon.000webhostapp.com/ViewProduct.php');
    var response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var rr = jsonDecode(response.body);
    vp = Viewresponse.fromJson(rr);

    setState(() {});
    if (vp!.connection == 1)
    {
      if (vp!.result == 1)
      {
        status = true;
        setState(() {});
      } else
      {
        status = false;
        setState(() {});
      }
    }
    setState(() {});
    print("id===$id");
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery
        .of(context)
        .size
        .height;
    double twidth = MediaQuery
        .of(context)
        .size
        .width;
    return status
        ? Scaffold(
        body: GridView.builder(
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1)
          ,
          itemCount: vp!.productdata!.length,
          itemBuilder: (context, index) {
            return Container( decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/gree.png"), fit: BoxFit.fill)),
              // color: Colors.green.shade300,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  ClipOval(
                    child: Image(
                      image: NetworkImage(
                          "https://ashwinbhaiamzon.000webhostapp.com/${vp!
                              .productdata![index].proimage}"),
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: twidth,
                    child: Text(
                      "${vp!.productdata![index].name}",
                      style: TextStyle(fontSize: 25, color: Colors.deepPurple),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: twidth,
                    child: Text(
                      "${vp!.productdata![index].price}",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: twidth,
                    child: Text(
                      "${vp!.productdata![index].detail}",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(onTap: () async {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return updatepage(vp!.productdata![index]);
                        },));

                      },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(width: 3),
                              color: Colors.redAccent.shade200,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5))),
                          child: Text(
                            "UPDATE",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(onTap: () async {
                        String? idd = vp!.productdata![index].id;

                        print(idd);

                        Map map = {
                          "id": idd,
                        };

                        var url =
                        Uri.parse(
                            'https://ashwinbhaiamzon.000webhostapp.com/delete.php');
                        var response = await http.post(url, body: map);
                        print('Response status: ${response.statusCode}');
                        print('Response body: ${response.body}');
                        setState(() {

                        });
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return clientpage();
                          },));
                      },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(width: 3),
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5))),
                          child: Text(
                            "DELETE",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        )
    )
        : Scaffold(
      body: Container(
        child: Lottie.asset("raw/qqq.json"),
      )
      ,
    );
  }
}

class Viewresponse {
  int? connection;
  int? result;
  List<Productdata>? productdata;

  Viewresponse({this.connection, this.result, this.productdata});

  Viewresponse.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
    if (json['productdata'] != null) {
      productdata = <Productdata>[];
      json['productdata'].forEach((v) {
        productdata!.add(new Productdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    if (this.productdata != null) {
      data['productdata'] = this.productdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdata {
  String? id;
  String? loginid;
  String? name;
  String? price;
  String? detail;
  String? proimage;

  Productdata({this.id,
    this.loginid,
    this.name,
    this.price,
    this.detail,
    this.proimage});

  Productdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginid = json['loginid'];
    name = json['name'];
    price = json['price'];
    detail = json['detail'];
    proimage = json['proimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loginid'] = this.loginid;
    data['name'] = this.name;
    data['price'] = this.price;
    data['detail'] = this.detail;
    data['proimage'] = this.proimage;
    return data;
  }
}
