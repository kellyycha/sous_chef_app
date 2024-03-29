import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MySquare extends StatelessWidget {
  final String title;
  final int? qty;
  final Image? img;
  final int? expiration;
  final DateTime? recipeDate;
  final VoidCallback onDelete;

  const MySquare({
    Key? key,
    required this.title,
    this.qty,
    this.img,
    this.expiration,
    this.recipeDate,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) => onDelete(),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
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
              width: 150,
              // TODO: if image, show, else default image
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  )),
              child: const Icon(
                Icons.add_photo_alternate_outlined,
                size: 50,
                color: Colors.grey,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: SizedBox(
                    width: 120,
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
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
                          padding: const EdgeInsets.only(top: 5, left: 20),
                          child: SizedBox(
                            width: 120,
                            child: Text(
                              "$expiration days",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 66, 107, 31),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
                Container(
                  child: recipeDate != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5, left: 20),
                          child: SizedBox(
                            width: 120,
                            child: Text(
                              "Saved ${DateFormat('M/d').format(recipeDate!)}",
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 66, 107, 31),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            const Spacer(),
            Container(
              child: qty != null && qty != -1
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20, right: 20),
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
            const SizedBox(width: 0),
          ],
        ),
      ),
    );
  }
}
