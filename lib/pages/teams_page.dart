import 'package:flutter/material.dart';
import 'package:football_app/pages/home.dart';

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
                    Player player = teams[teamIndex][playerIndex];
                    String level = '';
                    String positionStr = '';
                    if (player.level == 3) {
                      level = 'Skilled';
                    } else if (player.level == 2) {
                      level = 'Mid';
                    } else {
                      level = 'Beginner';
                    }
                    if (player.position == 3) {
                      positionStr = 'Atacker';
                    } else if (player.position == 2) {
                      positionStr = 'Defender';
                    } else {
                      positionStr = 'Goalkeeper';
                    }

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
                                player.name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              Text(
                                'Level:$level, Position: $positionStr',
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
