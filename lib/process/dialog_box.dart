import 'package:flutter/material.dart';
import 'package:football_app/pages/home.dart';
// import 'package:football_app/pages/home.dart';

class Dialogask extends StatefulWidget {
  TextEditingController controller;
  final Function(String, String) onLevelSelected;
  String positionStr;
  String levelStr;
  bool edit;
  bool listReadyAbsent;
  final List<Player> listOfReady;
  final List<Player> listOfAbsent;
  Dialogask(
      {super.key,
      required this.controller,
      required this.onLevelSelected,
      required this.positionStr,
      required this.levelStr,
      required this.edit,
      required this.listReadyAbsent,
      required this.listOfReady,
      required this.listOfAbsent});

  @override
  State<Dialogask> createState() => _DialogaskState();
}

class _DialogaskState extends State<Dialogask> {
  final List<String> levels = ['Skilled', 'Mid', 'Beginner'];

  final List<String> positions = ['Atacker', 'Defender', 'Goalkeeper'];

  String? value1;
  String? value2;
  String saveType = 'Save';

  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      value1 = widget.positionStr;
      value2 = widget.levelStr;
    }
  }

  bool nameExist(String inputName) {
    bool exist = false;
    if (widget.listReadyAbsent == true) {
      for (Player player in widget.listOfReady) {
        if (player.name.trim() == inputName.trim()) {
          exist = true;
        }
      }
    } else {
      for (Player player in widget.listOfAbsent) {
        if (player.name == inputName) {
          exist = true;
        }
      }
    }
    if (exist == true) {
      return false;
    } else {
      return true;
    }
  }

  bool errorAccured = false;
  String errorMessage = '';

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
            ),
            errorAccured? Text(errorMessage,style:const TextStyle(color: Colors.red),) :const Text(''),
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
            if (value1 != null &&
                value2 != null &&
                widget.controller.text.isNotEmpty &&
                nameExist(widget.controller.text)) {
              widget.onLevelSelected(value1!, value2!);
              Navigator.of(context).pop();
            } else {setState(() {
              errorAccured = true;
              if (nameExist(widget.controller.text) == false) {
                errorMessage = 'This player already exists!';
              } else {
                errorMessage = 'Enter all the required data!';
              }
            });
            }
          },
          child: widget.edit == false
              ? const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                )
              : const Text(
                  'Edit',
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ],
    );
  }
}
