import 'package:flutter/material.dart';

class TeamNum extends StatefulWidget {
  final void Function(int) onTeamsSelected;

  const TeamNum({required this.onTeamsSelected, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TeamNumState createState() => _TeamNumState();
}

class _TeamNumState extends State<TeamNum> {
  int selectedTeams = 2;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Teams :)",style: TextStyle(color: Colors.white),),
      backgroundColor: const Color.fromARGB(255, 28, 37, 61),
      content: Row(
        children: [
          const Text(
            'Number of Teams: ',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          DropdownButton<int>(
            dropdownColor: const Color.fromARGB(255, 49, 53, 86),
            iconEnabledColor: Colors.white,
            value: selectedTeams,
            onChanged: (int? newValue) {
              setState(() {
                selectedTeams = newValue!;
              });
            },
            items: List.generate(3, (index) => index + 2)
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(value.toString(), style: const TextStyle(color: Colors.white),),
              );
            }).toList(),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 55, 87)),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 49, 55, 87)),
          onPressed: () {
            Navigator.of(context).pop();
            widget.onTeamsSelected(selectedTeams);
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

//       title: Text("Teams :)"),
//       content: Row(
//         children: [
//           Text('Number of Teams: ',style: TextStyle(
//             fontSize: 18
//           ),),
//           DropdownButton<int>(
//             value: selectedTeams,
//             onChanged: (int? newValue) {
//               setState(() {
//                 selectedTeams = newValue!;
//               });
//             },
//             items: List.generate(4, (index) => index + 2)
//                 .map<DropdownMenuItem<int>>((int value) {
//               return DropdownMenuItem<int>(
//                 value: value,
//                 child: Text(value.toString()),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         TextButton(
//           child: const Text("Cancel"),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         ElevatedButton(
//           child: const Text("OK"),
//           onPressed: () {
//              Navigator.pushNamed(context, '/loading');
//             // Navigator.of(context).pop();
//             // _showLoadingScreen(context, selectedTeams);
//           },
//         ),
//       ],
//     );
//   }
// }