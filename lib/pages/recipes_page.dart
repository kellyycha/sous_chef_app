import 'package:flutter/material.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:format/format.dart';
import 'package:sous_chef_app/pages/generate_tab.dart';
import 'package:sous_chef_app/pages/saved_tab.dart';


class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Stack(
        children: [
          const ColoredBox(color: Colors.white),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              height: 630,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 250, 250, 245),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), 
                  topRight: Radius.circular(30),
                ),
              ),
            )
          ),
          const SizedBox(
                height:135,
                // title
                child: Align(
                  alignment: Alignment.topLeft,
                    child:Padding(
                    padding:EdgeInsets.only(top:40,left:20),
                    child: Text(
                      'Recipes',
                      style: TextStyle(
                        color:Colors.black,
                        fontSize: 64.0,
                        fontFamily: 'Italiana',
                      ),
                    ),
                  ),
                ),
              ), 
          Container(
            padding: const EdgeInsets.only(top:135, bottom: 0, left: 20, right: 20),
            color: Colors.transparent,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  ButtonsTabBar(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                    backgroundColor: const Color.fromARGB(255, 67, 107, 31),
                    unselectedBackgroundColor: Colors.transparent,
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    radius: 20,
                    tabs:[
                          Tab(text: format('{:^15}', 'Saved')),
                          const Tab(text: "AI Generate"),
                        ],
                  ),
                  const SizedBox(height:5),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SavedTab(),
                        const GenerateTab()
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}