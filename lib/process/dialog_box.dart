import 'package:flutter/material.dart';
// import 'package:football_app/pages/home.dart';

class Dialogask extends StatefulWidget {
  final controller;
  final Function(String, String) onLevelSelected;
  String positionStr;
  String levelStr;
  bool edit;
  Dialogask(
      {super.key,
      required this.controller,
      required this.onLevelSelected,
      required this.positionStr,
      required this.levelStr,
      required this.edit});

  @override
  State<Dialogask> createState() => _DialogaskState();
}

class _DialogaskState extends State<Dialogask> {
  final List<String> levels = ['Skilled', 'Mid', 'Beginner'];

  final List<String> positions = ['Atacker', 'Defender', 'Goalkeeper'];

  String? value1;
  String? value2;

  @override
  void initState() {
    
    super.initState();
    if (widget.edit == true) {
      value1 = widget.positionStr;
      value2 = widget.levelStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 28, 37, 61),
      content: SizedBox(
        height: 125,
        width: 150,
        child: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              controller: widget.controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter player's name",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 177, 179, 181))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Dropdown widget
                DropdownButton<String>(
                  dropdownColor: const Color.fromARGB(255, 61, 70, 99),
                  value: value1,
                  hint: const Text(
                    'Position',
                    style: TextStyle(color: Colors.white),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      value1 = newValue!;
                    });
                  },
                  items: positions.map((String position) {
                    return DropdownMenuItem<String>(
                      value: position,
                      child: Text(
                        position,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),

                DropdownButton<String>(
                    dropdownColor: const Color.fromARGB(255, 61, 70, 99),
                    value: value2,
                    hint: const Text(
                      'Level',
                      style: TextStyle(color: Colors.white),
                    ),
                    onChanged: (String? newValue2) {
                      setState(() {
                        value2 = newValue2!;
                      });
                    },
                    items: levels.map((String level) {
                      return DropdownMenuItem<String>(
                        value: level,
                        child: Text(
                          level,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList()),
              ],
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 55, 87)),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 55, 87)),
          onPressed: () {
            if (value1 != null && value2 != null && widget.controller != null) {
              widget.onLevelSelected(
                  value1!, value2!);
               // Pass the selected value back
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
