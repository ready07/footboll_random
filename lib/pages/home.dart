import 'dart:async';
// import 'dart:ffi';
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
  int position;
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
  Future<void> addplayer(String name, String position, String level, bool edit,
      bool readyAbsent) async {
    _controller.text = name;
    int indexReady =
        db.listOfReady.indexWhere((player) => player.name == _controller.text);
    int indexAbsent = db.listOfAbsent
        .indexWhere((player2) => player2.name == _controller.text);
    await showDialog(
        context: context,
        builder: (context) {
          return Dialogask(
            controller: _controller,
            positionStr: position,
            levelStr: level,
            edit: edit,
            onLevelSelected: (position1, level2) {
              int levelInt = 0;
              int positionInt = 0;
              if (level2 == 'Skilled') {
                levelInt = 3;
              } else if (level2 == 'Mid') {
                levelInt = 2;
              } else if (level2 == 'Beginner') {
                levelInt = 1;
              }
              if (position1 == 'Atacker') {
                positionInt = 3;
              } else if (position1 == 'Defender') {
                positionInt = 2;
              } else if (position1 == 'Goalkeeper') {
                positionInt = 1;
              }
              if (edit) {
                //if editing is true (not adding a new player)
                position1 = position;
                level2 = level;
                if (readyAbsent) {
                  //if editing a player from ListofReady

                  db.listOfReady[indexReady].name = _controller.text;
                  db.listOfReady[indexReady].position = positionInt;
                  db.listOfReady[indexReady].level = levelInt;
                } else {
                  //if editing a player from ListOfAbsent

                  db.listOfAbsent[indexAbsent].name = _controller.text;
                  db.listOfAbsent[indexAbsent].position = positionInt;
                  db.listOfAbsent[indexAbsent].level = levelInt;
                }
              } else {
                  db.listOfReady
                      .add(Player(_controller.text, levelInt, positionInt, 0));
                
                
                _controller.clear();
              }
            },
          );
        });

    setState(() {
      db.updateData();
      db.updateData2();
      db.updateData2();
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

  bool shouldSwap(List<Player> players, int i, int j) {
    Player x = players[i];
    Player y = players[j];
    if (x.level < y.level) return true;
    if (x.level > y.level) return false;
    if (x.position == y.position) return x.randomInt < y.randomInt;

    if (x.level % 2 == 1) {
      if (x.position < y.position) return true;
      if (x.position > y.position) return false;
    } else {
      return x.position > y.position;
    }

    return false;
  }

  void swapPlayers(List<Player> players, int i, int j) {
    Player x;
    x = players[i];
    players[i] = players[j];
    players[j] = x;
  }

//Distributing Players
  List distributePlayers(List<Player> players, int numberOfTeams) {
    List<List<Player>> teams = List.generate(numberOfTeams, (_) => []);

//    for adding RANDOM NUM TO THE LIST
    int randomNum = 0;
    for (Player player in players) {
      randomNum = Random().nextInt(1000);
      player.randomInt = randomNum;
    }
    int range = players.length;
    //SORT THE LIST
    for (int i = 0; i < range; i++) {
      //SORT LIST BEFORE DISTRIBUTION
      for (int j = i + 1; j < players.length; j++) {
        if (shouldSwap(players, i, j)) swapPlayers(players, i, j);
      }
    }

    int playerex = 0;

    void distribute(List<Player> players, List<List<Player>> teams) {
      for (Player player in players) {
        teams[playerex].add(player);
        playerex = (playerex + 1) % numberOfTeams;
      }
    }

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

    Future.delayed(const Duration(seconds: 2), () {
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
    List<Player> players = db.listOfReady;
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
          preferredSize: const Size.fromHeight(80.0),
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
            // List view where player data is displayed FROM LIST OF READY
            ListView.builder(
              itemCount: db.listOfReady.length,

              // ignore: body_might_complete_normally_nullable
              itemBuilder: (context, index) {
                String levelString = '';
                String positionString = '';
                if (db.listOfReady.isNotEmpty) {
                  //LEVELS FROM INT TO STRINGS
                  if (db.listOfReady[index].level == 3) {
                    levelString = 'Skilled';
                  } else if (db.listOfReady[index].level == 2) {
                    levelString = 'Mid';
                  } else if (db.listOfReady[index].level == 1) {
                    levelString = 'Beginner';
                  }

                  //POSITIONS FROM INT TO STRINGS
                  if (db.listOfReady[index].position == 3) {
                    positionString = 'Atacker';
                  } else if (db.listOfReady[index].position == 2) {
                    positionString = 'Defender';
                  } else if (db.listOfReady[index].position == 1) {
                    positionString = 'Goalkeeper';
                  }
                }

                if (db.listOfReady.isNotEmpty) {
                  bool ready = true;
                  return Newplayer(
                    playername: db.listOfReady[index].name,
                    playerlevel: levelString,
                    playerrole: positionString,
                    deletePlayer: () => removePlayerData2(index),
                    moveToReady: () => moveData2(index),
                    editPLayerData: () => addplayer(db.listOfReady[index].name,
                        positionString, levelString, true, true),
                    readyAbsent: ready,
                  );
                }
              },
            ),

            //LIST BUILDER WHERE THE DATA IS DISPLAYED FROM LIST OF ABSENT
            ListView.builder(
              itemCount: db.listOfAbsent.length,

              // ignore: body_might_complete_normally_nullable
              itemBuilder: (context, index) {
                String levelskilled = 'Skilled';
                String positionString2 = '';
                if (db.listOfAbsent.isNotEmpty) {
                  //LEVELS FROM INT TO STRINGS
                  if (db.listOfAbsent[index].level == 3) {
                    levelskilled = 'Skilled';
                  } else if (db.listOfAbsent[index].level == 2) {
                    levelskilled = 'Mid';
                  } else if (db.listOfAbsent[index].level == 1) {
                    levelskilled = 'Beginner';
                  }

                  // POSITIONS FROM INT TO STRINGS
                  if (db.listOfAbsent[index].position == 3) {
                    positionString2 = 'Atacker';
                  } else if (db.listOfAbsent[index].position == 2) {
                    positionString2 = 'Defender';
                  } else if (db.listOfAbsent[index].position == 1) {
                    positionString2 = 'Goalkeeper';
                  }
                }

                if (db.listOfAbsent.isNotEmpty) {
                  bool ready = false;
                  return Newplayer(
                    playername: db.listOfAbsent[index].name,
                    playerlevel: levelskilled,
                    playerrole: positionString2,
                    deletePlayer: () => removePlayerData(index),
                    moveToReady: () => moveData1(index),
                    editPLayerData: () => addplayer(db.listOfAbsent[index].name,
                        positionString2, levelskilled, true, false),
                    readyAbsent: ready,
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
                  onPressed: () => addplayer('', '', '', false, false),
                  elevation: 0,
                  label: const Icon(Icons.person_add))
            ],
          ),
        ),
      ),
    );
  }
}
