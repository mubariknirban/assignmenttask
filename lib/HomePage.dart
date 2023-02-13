import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Category.dart';
import 'Sale.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  List category1 = [];
  List category2 = [];
  List category3 = [];
  List category4 = [];
  List category5 = [];
  List category6 = [];

  List sliderimg = [];

  List banner1 = [];

  var categg;

  bool visibility = false;
  bool visibility2 = false;


  Future<void> topapi()async{
    var url = Uri.https('fabcurate.easternts.in', '/top.json');
    var response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      categg = data["main_sticky_menu"];
      var bannerimg1 = data["offer_code_banner"];
      for(int i =0; i < categg.length; i++){
        var slideimage = categg[i]["slider_images"][i]["image"];
        sliderimg.add(slideimage);
      }
      setState(() {
        visibility = true;
        category1 = categg;
        banner1 = bannerimg1;
        sliderimg;
      });

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }


  }

  Future<void> medalapi()async{

    var url = Uri.https('fabcurate.easternts.in', '/middle.json');
    var response = await http.get(url);

    print(response);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var cag1 = data["category"];
      var cag2 = data["Unstitched"];
      var cag3 = data["boutique_collection"];

      setState(() {
        visibility2 = true;
        category2 = cag1;
        category3 = cag2;
        category4 = cag3;
      });

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }


  }

  Future<void> lastapi()async{

    var url = Uri.https('fabcurate.easternts.in', '/bottom.json');
    var response = await http.get(url);

    print(response);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var cag1 = data["range_of_pattern"];
      var cag2 = data["design_occasion"];

      setState(() {
        category5 = cag1;
        category6 = cag2;
      });

    } else {
      print('Request failed with status: ${response.statusCode}.');
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topapi();
    medalapi();
    lastapi();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: category1.length == 0 ? Center(
        child: CircularProgressIndicator(),
      ):Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                height: 100,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: category1.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return Card(
                        shadowColor: Colors.grey,
                        elevation: 5,
                        child: Container(
                          height: 50,
                          width: 100,
                          child: Column(
                            children: [
                              FadeInImage.assetNetwork(
                                  placeholder: 'assets/wait.png',
                                  image:category1[index]["image"]),
                              //Image.network(category1[index]["image"]),
                              SizedBox(
                                height: 5,
                              ),
                              Text(category1[index]["title"],style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
                            ],
                          )
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 5,
              ),
              Visibility(
                visible: visibility,
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: CarouselSlider.builder(
                    itemCount: banner1.length,
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      height: 150,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      reverse: false,
                      aspectRatio: 5.0,
                    ),
                    itemBuilder: (context, i, id){
                      //for onTap to redirect to another screen
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white,)
                        ),
                        //ClipRRect for image border radius
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            banner1[i]["banner_image"],
                            width: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                height: 150,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: sliderimg.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.only(left: 5,right: 5),
                        child:FadeInImage.assetNetwork(
                            placeholder: 'assets/wait.png',
                            image:sliderimg[index]), );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shop By Fabric Material",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                              color: Colors.green
                          )
                      ),
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 6,
                          itemBuilder: (context,index){
                            return Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [


                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(80),
                                    child: Image(
                                      image: AssetImage("assets/cotton.png"),

                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 20,
                                    child: Text("COTTON",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Unstitched",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    Visibility(
                      visible: visibility,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: CarouselSlider.builder(
                          itemCount: category3.length,
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: 150,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            reverse: false,
                            aspectRatio: 5.0,
                          ),
                          itemBuilder: (context, i, id){
                            //for onTap to redirect to another screen
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.white,)
                              ),
                              //ClipRRect for image border radius
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  category3[i]["image"],
                                  width: 500,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shop By Category",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    Container(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: category2.length,
                          itemBuilder: (context,index){
                            return Card(
                              color: Color(0xffffb3b3),
                              shadowColor: Colors.grey,
                              elevation: 5,
                              child: Column(
                                children: [
                                  Container(
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 80,
                                              width: 150,
                                              child: Image.network(category2[index]["image"],fit: BoxFit.fill,)),
                                              Text(category2[index]["name"],style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 1,),

                                        ],
                                      )
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Boutique collection",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    Visibility(
                      visible: visibility2,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        child: CarouselSlider.builder(
                          itemCount: category4.length,
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: 150,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            reverse: false,
                            aspectRatio: 5.0,
                          ),
                          itemBuilder: (context, i, id){
                            //for onTap to redirect to another screen
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.white,)
                              ),
                              //ClipRRect for image border radius
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  category4[i]["banner_image"],
                                  width: 500,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Range of Pattern",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    Container(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: category5.length,
                          itemBuilder: (context,index){
                            return Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [

                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: NetworkImage(category5[index]["image"] =="" ? "https://placeimg.com/300/300/fabric":category5[index]["image"]),
                                  )
                                ),
                                Positioned(
                                    bottom: 20,
                                    child: Container(
                                        width: 80,
                                        child: Text(category5[index]["name"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),overflow: TextOverflow.ellipsis,maxLines: 1,textAlign: TextAlign.center,)))
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Design As Per Occasion",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    Container(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: category6.length,
                          itemBuilder: (context,index){
                            return Card(
                              color: Colors.white,
                              shadowColor: Colors.grey,
                              elevation: 5,
                              child: Column(
                                children: [
                                  Container(
                                      child: Column(
                                        children: [
                                          Container(
                                              height: 90,
                                              width: 150,
                                              child: Image.network(category6[index]["image"],fit: BoxFit.fill,)),
                                          Text(category6[index]["name"],style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,softWrap: true,maxLines: 1,),

                                        ],
                                      )
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
