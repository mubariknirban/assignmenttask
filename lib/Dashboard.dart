import 'package:easterntsfluttertask/Sale.dart';
import 'package:easterntsfluttertask/more.dart';
import 'package:easterntsfluttertask/testing.dart';
import 'package:flutter/material.dart';

import 'Category.dart';
import 'HomePage.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int selectedPage = 0;
  final _pageOptions = [Homepage(),  Category() , CURATE(), Salepage(), Morepage()];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("F A B ",style: TextStyle(color: Colors.green),),
                    Text("C U R A T E",style: TextStyle(color: Colors.black),),
                  ],
                ),
                Text("CREATE YOUR OWN FEBRIC",style:TextStyle(color: Colors.black,fontSize: 10),)
              ],
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.search_outlined,color: Colors.black,),
                    Icon(Icons.shopping_bag_outlined,color: Colors.black,)
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedPage,
            fixedColor: Colors.white,
            onTap: (index) => setState(() =>   selectedPage = index),
            backgroundColor: Colors.black12,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem( icon: Icon(Icons.home,color: Colors.green,), title: Text("Home",style: TextStyle(color: Colors.black),),),
              BottomNavigationBarItem(icon: Icon(Icons.toc,color: Colors.green,), title: Text("CATEGORY",style: TextStyle(color: Colors.black))),
              BottomNavigationBarItem(icon: Icon(Icons.category,color: Colors.green,), title: Text("CURATE",style: TextStyle(color: Colors.black))),
              BottomNavigationBarItem(icon: Icon(Icons.bolt,color: Colors.green,), title: Text("SALE",style: TextStyle(color: Colors.black))),
              BottomNavigationBarItem(icon: Icon(Icons.more_horiz,color: Colors.green,), title: Text("MORE",style: TextStyle(color: Colors.black))),
            ],

          ),
          body: Container(child: _pageOptions[selectedPage]),
      ),
    );
  }
}
