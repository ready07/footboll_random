import 'package:flutter/material.dart';
import 'package:football_app/pages/home.dart';
import 'package:football_app/process/hive_playersdata.dart';
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
  playersDataBase db;
  String name;
  Dialogask(
      {super.key,
      required this.controller,
      required this.onLevelSelected,
      required this.positionStr,
      required this.levelStr,
      required this.edit,
      required this.listReadyAbsent,
      required this.listOfReady,
      required this.listOfAbsent,
      required this.db,
      required this.name
      });

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
    if ((widget.edit == false) || (widget.edit && inputName != widget.name)) {
      for (Player player in widget.listOfReady) {
        if (player.name.trim() == inputName.trim()) {
          exist = true;
        }
      }
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

  void addOrEdit(
    name,
    position,
    level,
  ) {
    int indexReady = widget.db.listOfReady
        .indexWhere((player) => player.name == widget.name);
    int indexAbsent = widget.db.listOfAbsent
        .indexWhere((player2) => player2.name == widget.name);

    int levelInt = 0;
    int positionInt = 0;
    if (level == 'Skilled') {
      levelInt = 3;
    } else if (level == 'Mid') {
      levelInt = 2;
    } else if (level == 'Beginner') {
      levelInt = 1;
    }
    if (position == 'Atacker') {
      positionInt = 3;
    } else if (position == 'Defender') {
      positionInt = 2;
    } else if (position == 'Goalkeeper') {
      positionInt = 1;
    }
    if (widget.edit) {
      //if editing is true (not adding a new player)
      position = position;
      level = level;
      if (widget.listReadyAbsent) {
        //if editing a player from ListofReady

        widget.db.listOfReady[indexReady].name = widget.controller.text;
        widget.db.listOfReady[indexReady].position = positionInt;
        widget.db.listOfReady[indexReady].level = levelInt;
      } else {
        //if editing a player from ListOfAbsent
        widget.db.listOfAbsent[indexAbsent].name = widget.controller.text;
        widget.db.listOfAbsent[indexAbsent].position = positionInt;
        widget.db.listOfAbsent[indexAbsent].level = levelInt;
      }
    } else {
      widget.db.listOfReady
          .add(Player(widget.controller.text, levelInt, positionInt, 0));

      widget.controller.clear();
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
            errorAccured
                ? Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  )
                : const Text(''),
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
              addOrEdit(
                widget.controller.text,
                value1,
                value2,
              );

              Navigator.of(context).pop();
            } else {
              setState(() {
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
