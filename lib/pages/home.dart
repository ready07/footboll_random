import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:football_app/pages/teams_page.dart';
import 'package:football_app/process/dialog_box.dart';
import 'package:football_app/process/dialog_teams.dart';
import 'package:football_app/process/hive_playersdata.dart';
import 'package:football_app/process/tasks_cleancode.dart';
part 'home.g.dart';

@HiveType(typeId: 0)
class Player {
  @HiveField(0)
  String name;
  @HiveField(1)
  int level;
  @HiveField(2)
  String position;
  @HiveField(3)
  int randomInt;

  Player(this.name, this.level, this.position, this.randomInt);
}

class Allplayers extends StatefulWidget {
  // Function() addplayer;
  const Allplayers({
    super.key,
    // required this.addplayer
  });

  @override
  State<Allplayers> createState() => _AllplayersState();
}

class _AllplayersState extends State<Allplayers> {
  final _openBox = Hive.box("dataBox");

  @override
  void initState() {
    super.initState();
    if (_openBox.get('lr') != null) {
      db.loadData2();
    }
    if (_openBox.get('lp') != null) {
      db.loadData();
    }
  }

  final _controller = TextEditingController();

  playersDataBase db = playersDataBase();

  // Dialog for ADDING players
  void addplayer() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogask(
            controller: _controller,
            onLevelSelected: (position1, level2) {
              int levelInt = 0;
              if (level2 == 'Skilled') {
                levelInt = 3;
              } else if (level2 == 'Mid') {
                levelInt = 2;
              } else {
                levelInt = 1;
              }
              setState(() {
                Player p = Player(_controller.text, levelInt, position1, 0);
                // List<dynamic> playerAdd = [_controller.text, level2, position1];
                db.listOfReady
                    .add(Player(_controller.text, levelInt, position1, 0));
                db.updateData2();
              });
              _controller.clear();
            },
          );
        });
  }

  // DELETE PLAYERS FROM listOfAbsent
  void removePlayerData(int index) {
    setState(() {
      db.listOfAbsent.removeAt(index);
    });
    db.updateData();
  }

  // DELETE PLAYERS FROM LISTOFREADY
  void removePlayerData2(int index) {
    setState(() {
      db.listOfReady.removeAt(index);
    });
    db.updateData2();
  }

  //   List<Player> playersTOAdd = [
  //   Player(_controller.text, level2, position1)
  // ];

  // from ABSENT TO READY
  void moveData1(int index) {
    setState(() {
      db.listOfReady.add(
        db.listOfAbsent[index],
      );
      db.listOfAbsent.removeAt(index);
    });
    db.updateData2();
    db.updateData();
  }

  // from ready to absent
  void moveData2(int index) {
    setState(() {
      db.listOfAbsent.add(
        db.listOfReady[index],
      );
      db.listOfReady.removeAt(index);
    });
    db.updateData();
    db.updateData2();
  }

//Distributing Players
  List distributePlayers(List<Player> players, int numberOfTeams) {
    List teams = List.generate(numberOfTeams, (_) => []);

//    for adding RANDOM NUM TO THE LIST
    int randomNum = 0;
    for (Player player in players) {
      randomNum = Random().nextInt(1000);
      player.randomInt = randomNum;
    }
    int range = players.length;
    //SORT THE LIST
    for (int i = 0; i < range; i++) {
      int j = i + 1;
      for (j; j <= players.length;) {
        int playerJ = players[j].randomInt;
        int playerI = players[i].randomInt;
        if (playerI > playerJ) {
          Player previousPlayer = players[i];
          players[i] = players[j];
          players[j] = previousPlayer;
        }
      }
    }

    for (int y = 0; y < players.length; y++) {
      int x = y + 1;
      for (x; x <= players.length;) {
        if (players[y].level > players[x].level) {
          Player previous = players[y];
          players[y] = players[x];
          players[x] = previous;
        }
      }
    }
    // players.shuffle();
    // Categorize players by skill level
    // List<Player> skilled = [];
    // List<Player> mid = [];
    // List<Player> beginner = [];

    // RANDOM NUMS ADDED TO PLAYERS

    // for (int i = 0; i <= players.length;) {
    //   int j = i + 1;
    //   for (j; j <= players.length;) {
    //     dynamic playerJ = players[j][3];
    //     dynamic playerI = players[i][3];
    //     if (playerI > playerJ) {
    //       List previousPlayer = players[i];
    //       players[i] = players[j];
    //       players[j] = previousPlayer;
    //     }
    //   }
    // }

    // for i in range(len(all)):
    // j = i + 1
    // for j in range(j,len(all)):
    //     if int(all[i][1]) > int(all[j][1]):
    //         previousPerson = all[i]
    //         all[i] = all[j]
    //         all[j] = previousPerson
    //FOR GOALKEEPERS
    // for (dynamic player in players) {
    //   randomNum = Random().nextInt(100);
    //   if (player[1] == 'Skilled' && player[2] == 'Atacker') {
    //     player.add(randomNum);
    //     skilled.add(player);
    //   } else if (player[1] == 'Mid' && player[2] == 'Goalkeeper') {
    //     player.add(randomNum);
    //     mid.add(player);
    //   } else if (player[1] == 'Beginner' && player[2] == 'Goalkeeper') {
    //     player.add(randomNum);
    //     beginner.add(player);
    //   }
    // }
    //FOR ATACKERS
    // for (var player in players) {
    //   randomNum = Random().nextInt(100);
    //   if (player[1] == 'Skilled' && player[2] == 'Goalkeeper') {
    //     player.add(randomNum);
    //     skilled.add(player);
    //   } else if (player[1] == 'Mid' && player[2] == 'Atacker') {
    //     player.add(randomNum);
    //     mid.add(player);
    //   } else if (player[1] == 'Beginner' && player[2] == 'Atacker') {
    //     player.add(randomNum);
    //     beginner.add(player);
    //   }
    // }
    //FOR DefenderS
    // int DefenderTracker1 = 0;
    // int DefenderTracker2 = 0;
    // int DefenderTracker3 = 0;
    // for (var player in players) {
    //   randomNum = Random().nextInt(100);
    //   if (player[1] == 'Skilled' && player[2] == 'Defender') {
    //     player.add(randomNum);
    //     skilled.add(player);
    //     DefenderTracker1++;
    //   } else if (player[1] == 'Mid' && player[2] == 'Defender') {
    //     player.add(randomNum);
    //     mid.add(player);
    //     DefenderTracker2++;
    //   } else if (player[1] == 'Beginner' && player[2] == 'Defender') {
    //     player.add(randomNum);
    //     beginner.add(player);
    //     DefenderTracker3++;
    //   }
    // }
    int playerex = 0;
    // bool goalKeeperFoundTeam1 = false;
    // bool gKeeperFoundTeam2 = false;
    // bool gKeeperFoundTeam3 = false;
    // int minusLogic1 = 1;
    // int Defender = 0;

    //for sorting Players in Skilled
    // for (int i = 0; i <= skilled.length;) {
    //   int j = i + 1;
    //   for (j; j <= skilled.length;) {
    //     if (skilled[j][3] > skilled[j][3]) {
    //       List previousPlayer = skilled[i];
    //       skilled[i] = skilled[j];
    //       skilled[j] = previousPlayer;
    //     }
    //   }
    // }

    // Function to distribute players
    void distribute(List players, List teams) {
      for (Player player in players) {
        teams[playerex].add(player);
        playerex = (playerex + 1) % numberOfTeams;
      }

      // for (var player in players) {
      //   //LOGIC FOR ECH LEVELS ,FOR Defender DATA
      //   if (player == players[0] && player[1] == 'Skilled') {
      //     Defender = DefenderTracker1;
      //     minusLogic1 = 1;
      //   } else if (player == players[0] && player[1] == 'Mid') {
      //     Defender = DefenderTracker2;
      //     minusLogic1 = 1;
      //   } else if (player == players[0] && player[1] == 'Beginner') {
      //     Defender = DefenderTracker3;
      //     minusLogic1 = 1;
      //   }

      //   // NO GOALKEEPER IN THE TEAM
      //   if (playerex == 0 &&
      //       player[2] == 'Goalkeeper' &&
      //       goalKeeperFoundTeam1 == false) {
      //     goalKeeperFoundTeam1 = true;
      //     teams[playerex].add(player);
      //   } else if (playerex == 1 &&
      //       player[2] == 'Goalkeeper' &&
      //       gKeeperFoundTeam2 == false) {
      //     gKeeperFoundTeam2 = true;
      //     teams[playerex].add(player);
      //   } else if (playerex == 2 &&
      //       player[2] == 'Goalkeeper' &&
      //       gKeeperFoundTeam3 == false) {
      //     gKeeperFoundTeam3 = true;
      //     teams[playerex].add(player);
      //   }
      //   // //IF GOAL KEEPER ALREADY EXISTS
      //   else if (player[2] == 'Goalkeeper' &&
      //       player != players[players.length - minusLogic1] &&
      //       Defender != 0 &&
      //       (goalKeeperFoundTeam1 == true && playerex == 0 ||
      //           gKeeperFoundTeam2 == true && playerex == 1 ||
      //           gKeeperFoundTeam3 == true && playerex == 2)) {
      //     dynamic previousPlayer = player;
      //     player = players[players.length - minusLogic1];
      //     players[players.length - minusLogic1] = previousPlayer;
      //     teams[playerex].add(player);
      //     minusLogic1++;
      //     Defender--;
      //   }
      //   //HAVE NO CHOICE BUT TO ADD THE PLAYER
      //   else {
      //     teams[playerex].add(player);
      //   }
      //   playerex = (playerex + 1) % numberOfTeams;

      //   // indexPlayer++;
      // }
    }

    // Distribute skilled, mid, and beginner players
    // distribute(skilled, teams);
    // distribute(mid, teams);
    // distribute(beginner, teams);

    distribute(players, teams);
    return teams;
  }

//DIALOG FOR CHANGING PLAYER'S DATA

  void changeOptions() {
    showDialog(
      context: context,
      builder: (context) {
        return TeamNum(onTeamsSelected: (int selectedTeams) {
          _showLoadingScreen(
              selectedTeams); // Show the loading screen with the selected number of teams
        });
      },
    );
  }

// Using Completer to manage async completion
  void _showLoadingScreen(int selectedTeams) {
    Completer<void> completer = Completer<void>();

    _showCustomLoadingDialog(completer); // Show the loading dialog

    Future.delayed(const Duration(seconds: 5), () {
      if (!completer.isCompleted) {
        completer.complete(); // Complete the future when loading is done
      }

      _navigateToTeamsPage(selectedTeams); // Navigate to the Teams page
    });
  }

// Show a custom loading dialog
  void _showCustomLoadingDialog(Completer<void> completer) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            if (!completer.isCompleted) {
              completer.complete(); // Dismiss the dialog when back is pressed
              Navigator.of(context).pop(); // Close the dialog explicitly
            }
            return true; // Allow navigation back
          },
          child: const Center(
            child: AlertDialog(
              backgroundColor: Color.fromARGB(0, 0, 0, 0),
              content: SpinKitCircle(
                color: Color.fromARGB(255, 255, 255, 255),
                size: 60.0,
              ),
            ),
          ),
        );
      },
    ).then((_) {
      if (!completer.isCompleted) {
        completer
            .complete(); // Ensure completion if dialog is closed by the user
      }
    });
  }

  void _navigateToTeamsPage(int selectedTeams) {
    List<Player> players =
        db.listOfReady; // Assuming player format [name, level, position]
    List teams = distributePlayers(players, selectedTeams);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamsPage(
          numberOfTeams: selectedTeams,
          teams: teams,
        ),
      ),
    ).then((_) {
      // Ensure the loading dialog is dismissed when returning to the home page
      Navigator.of(context).pop(); // Pop the loading dialog when returning
    });
  }

  @override
  Widget build(BuildContext context) {
    int pnum = db.listOfReady.length;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 20, 27),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: const Color.fromARGB(190, 33, 40, 51),
            title: const Text(
              'All Players',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Ready players',
                ),
                Tab(
                  text: 'Absent players',
                )
              ],
              indicatorColor: Color.fromARGB(255, 100, 191, 253),
              labelColor: Color.fromARGB(255, 100, 191, 253),
              unselectedLabelColor: Color.fromARGB(255, 255, 246, 246),
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
          ),
        ),
        body: TabBarView(
          children: [
            // List view where player data is displayed
            ListView.builder(
              itemCount: db.listOfReady.length,

              // ignore: body_might_complete_normally_nullable
              itemBuilder: (context, index) {
                String levelString = '';
                if (db.listOfReady.isNotEmpty) {
                  if (db.listOfReady[index].level == 3) {
                    levelString = 'Skilled';
                  } else if (db.listOfReady[index].level == 2) {
                    levelString = 'Mid';
                  } else if (db.listOfReady[index].level == 1) {
                    levelString = 'Beginner';
                  }
                }
                if (db.listOfReady.isNotEmpty) {
                  return Newplayer(
                    playername: db.listOfReady[index].name,
                    playerlevel: levelString,
                    playerrole: db.listOfReady[index].position,
                    deletePlayer: () => removePlayerData2(index),
                    moveToReady: () => moveData2(index),
                    editPLayerData: () => addplayer(),
                  );
                }
              },
            ),

            ListView.builder(
              itemCount: db.listOfAbsent.length,

              // ignore: body_might_complete_normally_nullable
              itemBuilder: (context, index) {
                String levelskilled = 'Skilled';
                if (db.listOfAbsent.isNotEmpty) {
                  if (db.listOfAbsent[index].level == 3) {
                    levelskilled = 'Skilled';
                  } else if (db.listOfAbsent[index].level == 2) {
                    levelskilled = 'Mid';
                  } else if (db.listOfAbsent[index].level == 1) {
                    levelskilled = 'Beginner';
                  }
                }
                if (db.listOfAbsent.isNotEmpty) {
                  return Newplayer(
                    playername: db.listOfAbsent[index].name,
                    playerlevel: levelskilled,
                    playerrole: db.listOfAbsent[index].position,
                    deletePlayer: () => removePlayerData(index),
                    moveToReady: () => moveData1(index),
                    editPLayerData: () => addplayer(),
                  );
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color:
              const Color.fromARGB(255, 33, 40, 51), // Customize the color here
          // shape: CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 40, 51),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      '$pnum',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const Text(
                      '  Players in total  ',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              FloatingActionButton.extended(
                  onPressed: () {
                    changeOptions();
                  },
                  elevation: 0,
                  label: const Row(
                    children: [
                      Text("Generate Teams "),
                      Icon(Icons.rocket_launch_rounded)
                    ],
                  )),
              // const SizedBox(width: 56),
              FloatingActionButton.extended(
                  onPressed: addplayer,
                  elevation: 0,
                  label: const Icon(Icons.person_add))
            ],
          ),
        ),
      ),
    );
  }
}






// void _navigateToTeamsPage(int selectedTeams) {
//   List players = db.listOfReady; // Assuming player format [name, level, position]
//   List<List<List<String>>> teams = distributePlayers(players, selectedTeams);

//   Navigator.pushReplacement(
//     context,
//     MaterialPageRoute(
//       builder: (context) => TeamsPage(
//         numberOfTeams: selectedTeams,
//         teams: teams,
//       ),
//     ),
//   );
// }