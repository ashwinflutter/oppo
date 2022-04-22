import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oppo/clientpage.dart';
import 'package:oppo/viewpage.dart';

class updatepage extends StatefulWidget {

  Productdata productdata;
  updatepage(Productdata this.productdata);


  @override
  State<updatepage> createState() => _updatepageState();
}

class _updatepageState extends State<updatepage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tprice = TextEditingController();
  TextEditingController tdetail = TextEditingController();

  String str = "";
  String id ="";
  String imagename = "";

@override
  void initState() {
    // TODO: implement initState
    super.initState();

imagename=widget.productdata.proimage!;
id=widget.productdata.id!;setState(() {

});
getdata();
  }
  void getdata() {
    tname.text = widget.productdata.name!;
    tprice.text = widget.productdata.price!;
    tdetail.text = widget.productdata.detail!;

  }

  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 80, 20, 220),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/gree.png"), fit: BoxFit.fill)),
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Column(
                            children: [
                              RaisedButton.icon(
                                  onPressed: () async {
                                    final XFile? image = await _picker.pickImage(
                                        source: ImageSource.gallery);
                                    str = image!.path;
                                    setState(() {});
                                  },

                                  icon: Icon(Icons.photo),
                                  label: Text("Gallary")),
                            ],
                          );
                        },
                      );
                    },
                    child: str != ""
                        ? CircleAvatar(
                      backgroundImage: FileImage(File(str)),
                    )
                        : CircleAvatar(
                      radius: 72,
                      backgroundImage: NetworkImage(
                          "https://ashwinbhaiamzon.000webhostapp.com/${widget.productdata.proimage}"),
                    )),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: tname,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.weekend_outlined,
                        size: 30,
                        color: Colors.green,
                      ),
                      labelText: "Product Name",
                      fillColor: Colors.white,
                      filled: true,

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                SizedBox(
                  height: 10,
                ),

                TextField(
                  controller: tprice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.account_balance_wallet,
                        size: 30,
                        color: Colors.green,
                      ),
                      labelText: "Price",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: tdetail,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.assignment,
                        size: 30,
                        color: Colors.green,
                      ),
                      labelText: "Product Detial",
                      fillColor: Colors.white,
                      filled: true,

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                SizedBox(
                  height: 44,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {


                      List<int> imagebydata = File(str).readAsBytesSync();
                      String imagedataa = base64Encode(imagebydata);

                      String namee = tname.text;
                      String price = tprice.text;
                      String detail = tdetail.text;
                       setState(() {

                       });
                      map = {
                        "id": id,
                        "namee": namee,
                        "price": price,
                        "detail": detail,
                        "imagedataa": imagedataa,
                        "imagename": imagename
                      };
                    });

                    print("yesssss");

                    setState(() {});

                    var url = Uri.parse(
                        'https://ashwinbhaiamzon.000webhostapp.com/update.php');
                    var response = await http.post(url, body: map);
                    print('Response status: ${response.statusCode}');
                    print('Response body: ${response.body}');

                    var rr = jsonDecode(response.body);

                    UpdateResponse mm = UpdateResponse.fromJson(rr);

                    if(mm.connection==1)
                    {
                      if(mm.result==1)
                      {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return clientpage();
                          },
                        ));
                      }
                    }

                  },
                  child: Text(
                    "UPDATE DATA",
                    style: TextStyle(fontSize: 33, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }
  Map map  = {

  };
}
class UpdateResponse {
  int? connection;
  int? result;

  UpdateResponse({this.connection, this.result});

  UpdateResponse.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['result'] = this.result;
    return data;
  }
}
