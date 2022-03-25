import 'dart:convert';

import 'package:easterntsfluttertask/fullitemlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {


  List category1 = [];
  var banerimg;

  Future<void> Categoryapi()async{

    var url = Uri.https('fabcurate.easternts.in', '/category.json');
    var response = await http.get(url);

    print(response);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var categg = data["categories"];
      banerimg = data["banner_image"];

      setState(() {
        category1 = categg;
        banerimg;
      });

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Categoryapi();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: category1.length == 0 ? Center(
        child: CircularProgressIndicator(),
      ):Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: category1.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Fullitem(title: category1[index]["category_name"], id: index)));

                        },
                        child: Container(
                          margin: EdgeInsets.all(2),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 100,
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width * 0.65,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.black,
                                              width: 1
                                          )
                                      ),
                                      /*borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  topRight: Radius.circular(25)
                              )*/
                                    ),
                                    child: Text(category1[index]["category_name"]+ " >",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width * 0.35,
                                      child: Image.network(banerimg,fit: BoxFit.fill,),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),

      ),
    );
  }
}
