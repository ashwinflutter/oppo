import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oppo/clientpage.dart';
import 'package:oppo/splashscreen.dart';

class addpage extends StatefulWidget {
  const addpage({Key? key}) : super(key: key);

  @override
  State<addpage> createState() => _addpageState();
}

class _addpageState extends State<addpage> {

  String str="";

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
id=splash_screen.preferences!.getString("id")??"";
setState(() {

});
print("====$id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    // Capture a photo

                                    str = image!.path;
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.photo),
                                  label: Text("Gallary")),
                              RaisedButton.icon(
                                  onPressed: () async {
                                    final XFile? photo = await _picker.pickImage(
                                        source: ImageSource.camera);
                                    str = photo!.path;
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.camera_alt),
                                  label: Text("Camera"))
                            ],
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 72,
                      backgroundImage: FileImage(File(str)),
                    )),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: name,
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
                  controller: price,
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
                  controller: detail,
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
                      pname = name.text;
                      pprice = price.text;
                      pdetail = detail.text;
                    });

                      print("yesssss");

                      List<int> imagebydata = File(str).readAsBytesSync();
                      String imagedata = base64Encode(imagebydata);

                      Map map = {
                        "loginid":id,
                        "name": pname,
                        "price": pprice,
                        "detail": pdetail,
                        "imagedata": imagedata
                      };

                      var url = Uri.parse(
                          'https://ashwinbhaiamzon.000webhostapp.com/maxproduct.php');
                      var response = await http.post(url, body: map);
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');

                    var pl = jsonDecode(response.body);
                    productresponse pp=productresponse.fromJson(pl);

                    setState(() {
                      if(pp.connection==1){
                        if(pp.result==1)
                        {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return clientpage();
                          },));
                        }
                      }
                    });

                    setState(() {

                    });
                      },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 33, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ));
  }
  TextEditingController name=TextEditingController();
  TextEditingController detail=TextEditingController();
  TextEditingController price=TextEditingController();

  String pname="";
  String pdetail="";
  String pprice="";
  String pcode="";
  String? id;


}
class productresponse {
  int? connection;
  int? result;

  productresponse({this.connection, this.result});

  productresponse.fromJson(Map<String, dynamic> json) {
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