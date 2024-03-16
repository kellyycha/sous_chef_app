import 'package:flutter/material.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( body: Stack(
        children: [
          const ColoredBox(color: Colors.white),
          Positioned(
            // alignment: Alignment.bottomCenter,
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
          Column(
            children: [
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
              const SizedBox(height:5), 
              IntrinsicHeight(
                child: Row(
                  children: [
                    const SizedBox(width:20),
                    // saved tab
                    SizedBox(
                      width: 170,
                      height: 40,
                      child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color.fromARGB(255, 230, 230, 230),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              ),
                            backgroundColor: const Color.fromARGB(255, 67, 107, 31),
                            foregroundColor: Colors.white,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(1),
                          ),
                          // TODO: clicking this opens saved screen
                          onPressed: () {},
                          child: const Text("Saved"),
                          ),
                        ), 
                      ),
                    const Spacer(),
                    const VerticalDivider(
                      thickness: 1,
                      width: 1,
                      indent: 3,
                      endIndent: 3,
                    ),
                    const Spacer(),
                    // AI tab
                    SizedBox(
                      width: 170,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          // color: const Color.fromARGB(255, 230, 230, 230),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                ),
                              // backgroundColor: const Color.fromARGB(255, 67, 107, 31),
                              foregroundColor: Colors.black,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(1),
                            ),
                            // TODO: clicking this opens AI generate tab
                            onPressed: () {},
                            child: const Text("AI Generate"),
                          ),
                        ), 
                      ), 
                    const SizedBox(width:20),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ],
          ),

        ]
      )
      
    );
  }

}