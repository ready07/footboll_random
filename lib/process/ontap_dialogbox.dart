import "package:flutter/material.dart";

class DialogAsk2 extends StatelessWidget {
  final VoidCallback removePlayer;
  final Function() moveData;
  final String titlePlayer;
  bool deleteOrChangeList;

  DialogAsk2(
      {super.key,
      required this.removePlayer,
      required this.moveData,
      required this.titlePlayer,
      required this.deleteOrChangeList});

  @override
  Widget build(BuildContext context) {
    String name = titlePlayer;
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 28, 37, 61),
      content: SizedBox(
        height: 110,
        width: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            deleteOrChangeList
                ? const Text(
                    'Are you sure to move ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                : const Text('Are you sure to delete',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
            Text(
              '$name ?',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 153, 233, 235)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 49, 55, 87)),
                    onPressed: Navigator.of(context).pop,
                    child: const Text(
                      'No',
                      style:
                          TextStyle(color: Color.fromARGB(255, 254, 254, 252)),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 49, 55, 87)),
                    onPressed: () {
                      deleteOrChangeList ? moveData() : removePlayer();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Color.fromARGB(255, 247, 237, 237)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
