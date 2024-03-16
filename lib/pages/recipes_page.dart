import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

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
                color: const Color.fromARGB(255, 250, 250, 245),
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
            padding:EdgeInsets.only(top:135, left: 20, right: 20),
            color: Colors.transparent,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: <Widget>[
                  ButtonsTabBar(
                    backgroundColor: const Color.fromARGB(255, 67, 107, 31),
                    unselectedBackgroundColor: Colors.transparent,
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    radius: 20,
                    tabs:[
                          Tab(
                            child: Container(
                              width: 150,
                              height: 40,
                              alignment: Alignment.center,
                              child: Text('Saved')
                              ),
                            ),
                          Tab(
                            child: Container(
                              width: 150,
                              height: 40,
                              alignment: Alignment.center,
                              child: Text('AI Generate')
                              ),
                          ),
                        ],
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        Icon(Icons.book),
                        Icon(Icons.restaurant),
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