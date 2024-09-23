import 'package:flutter/material.dart';
// import 'package:football_app/process/dialog_teams.dart';

class TeamsPage extends StatelessWidget {
  final int numberOfTeams;
  final List teams;

  const TeamsPage(
      {super.key, required this.numberOfTeams, required this.teams});

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 33, 40, 51),
          title: const Text(
            "Generated Teams",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          )),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, teamIndex) {
          return Card(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '  Team ${teamIndex + 1}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap:
                      true, // Ensures the ListView takes only the space it needs
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevents inner scrolling
                  itemCount: teams[teamIndex].length,
                  itemBuilder: (context, playerIndex) {
                    var player = teams[teamIndex][playerIndex];
                    var level = player[1];
                    var position = player[2];

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 3, 0, 1),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 66, 64, 64),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                player[0],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              Text(
                                'Level:$level, Positon: $position',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 55, 53, 53),
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Teams',style: TextStyle(color: Colors.white),),
//          leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
//           onPressed: () => Navigator.of(context).pop(),
//         ),

//         backgroundColor: const Color.fromARGB(255, 37, 45, 58),
//       ),
//       body: ListView.builder(
//         itemCount: numberOfTeams,
//         itemBuilder: (context, index) {
//           // Create a Card for each team
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 4, // Adds shadow for a material design feel
//             child: ExpansionTile(
//               title: Text('Team ${index + 1}',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//               leading: const Icon(Icons.group), // An icon that represents teams
//               children: _buildPlayerList(teams[index]), // List of players for this team
//             ),
//           );
//         },
//       ),
//     );
//   }

//   // This method builds the list of players for a given team
//   List<Widget> _buildPlayerList(List team) {
//     return team.map((player) {
//       return ListTile(
//         title: Text(player[0]), // Player name
//         subtitle: Text('${player[1]} - ${player[2]}'), // Player level and position
//         leading: const Icon(Icons.person), // An icon to represent a player
//       );
//     }).toList();
//   }
// }

// import 'package:flutter/material.dart';

// class TeamsPage extends StatelessWidget {
//   final int numberOfTeams;
//   final List<List<List<String>>> teams; // Assuming player is a list of [name, level, position]

//   TeamsPage({required this.numberOfTeams, required this.teams});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Generated Teams")),
//       body: ListView.builder(
//         itemCount: numberOfTeams,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: EdgeInsets.all(10),
//             child: ExpansionTile(
//               title: Text('Team ${index + 1}'),
//               children: teams[index].map<Widget>((player) {
//                 return ListTile(
//                   title: Text(player[0]),
//                   subtitle: Text('Level: ${player[1]}, Position: ${player[2]}'),
//                 );
//               }).toList(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
