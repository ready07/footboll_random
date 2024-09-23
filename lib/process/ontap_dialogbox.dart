import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class DialogAsk2 extends StatelessWidget {
  final VoidCallback removePlayer;
  final Function() moveData;
  final String titlePlayer;
  // final Function() editPlayer;

  const DialogAsk2(
      {super.key,
      required this.removePlayer,
      required this.moveData,
      required this.titlePlayer
      // required this.editPlayer
      });

  @override
  Widget build(BuildContext context) {
    String name = titlePlayer;
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 28, 37, 61),
      title: Text(
        "Name: $name",
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255)),
      ),
      content: SizedBox(
        // color: Color.fromARGB(255, 16, 42, 54),
        height: 150,
        width: 150,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                moveData();
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                height: 40,
                color: const Color.fromARGB(255, 28, 37, 61),
                child: const Row(
                  children: [
                    Icon(
                      Icons.swap_horizontal_circle_outlined,
                      color: Color.fromARGB(255, 140, 152, 222),
                    ),
                    Text(' Move to the other list',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 219, 225, 226),
            ),
            GestureDetector(
              onTap: () {
                removePlayer();
                Navigator.of(context).pop();
              },
              child: Container(
                height: 40,
                color: const Color.fromARGB(255, 28, 37, 61),
                child: const Row(
                  children: [
                    Icon(
                      Icons.delete_forever_rounded,
                      color: Color.fromARGB(255, 225, 6, 6),
                      size: 30,
                    ),
                    Text(
                      'Delete Player',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 49, 55, 87),
                  ),
                  child: const Text(
                    ' Cancel ',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 251, 251),
                      fontSize: 20,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// void onTapReady(){
  
// }