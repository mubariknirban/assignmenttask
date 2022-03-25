import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class Fullitem extends StatefulWidget {
  final String title;
  final int id;
  const Fullitem({Key? key, required this.title, required this.id}) : super(key: key);

  @override
  State<Fullitem> createState() => _FullitemState();
}

class _FullitemState extends State<Fullitem> {

  List itemlist = [];

  Future<void> Categorydetailsapi()async{

    var url = Uri.https('fabcurate.easternts.in', '/category.json');
    var response = await http.get(url);

    print(response);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var categg = data["categories"][widget.id]["child"];

      setState(() {
        itemlist = categg;
      });

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Categorydetailsapi();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green),
          title: Text(widget.title,style: TextStyle(color: Colors.green),),
        ),
        body: itemlist.length == 0 ? Center(
          child: CircularProgressIndicator(),
        ):SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: itemlist.length,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.all(2),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25)
                              )
                                    ),
                                    child: Text(itemlist[index]["category_name"],style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                  ),
                                ),

                              ],
                            ),

                          ],
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
