import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySquare extends StatelessWidget{
  final String title;
  final int? qty;
  final Image? img;
  final int? expiration;
  final DateTime? recipeDate;
  
  const MySquare({super.key, 
    required this.title, 
    this.qty, 
    this.img,
    this.expiration, 
    this.recipeDate
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 243, 237),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color.fromARGB(255, 230, 230, 230)),
        ),
        
        child: Row(
          children: [
            // image
            Container(
              height: 120,
              width: 160,
              // TODO: if image, show, else default image
              decoration: const BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), bottomLeft: Radius.circular(24),)
              )
            ),
            Column(
              children: [
                // TODO: fix text aligning
                Padding(
                  padding: const EdgeInsets.only(top:20, left: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        title,
                        // textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          ),
                        ),
                  ),
                ),

                Container(
                  child: expiration != null && expiration != -1
                  ? Padding(
                    padding: const EdgeInsets.only(top:5, left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "$expiration days",
                          // textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 66, 107, 31)
                            ),
                          ),
                      ),
                    ): 
                  Container(),
                ),

              ],
            ),
            const Spacer(),
            Container(
              child: qty != null && qty != -1
              ? Padding(
                padding: const EdgeInsets.only(top:20, right: 20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                      "x$qty",
                      style: const TextStyle(
                        fontSize: 20,
                        ),
                      ),
                ),
              ) 
              : Container(),
            ),
          ],
        )
          )
    );
  }
}