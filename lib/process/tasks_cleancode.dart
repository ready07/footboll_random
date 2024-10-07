import 'package:flutter/material.dart';
import 'package:football_app/process/ontap_dialogbox.dart';

class Newplayer extends StatefulWidget {
  final String playername;
  final String playerlevel;
  final String playerrole;
  final bool readyAbsent;
  Function() deletePlayer;
  Function() moveToReady;
  Function() editPLayerData;
  Newplayer(
      {super.key,
      required this.playername,
      required this.playerlevel,
      required this.playerrole,
      required this.deletePlayer,
      required this.moveToReady,
      required this.editPLayerData,
      required this.readyAbsent});

  @override
  State<Newplayer> createState() => _NewplayerState();
}

class _NewplayerState extends State<Newplayer> {
  void changeOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogAsk2(
            removePlayer: widget.deletePlayer,
            moveData: widget.moveToReady,
            titlePlayer: widget.playername,
            deleteOrChangeList: deleteOrMove,
          );
        });
  }

  bool deleteOrMove = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 1, 1, 0),
        child: GestureDetector(
          onTap: () {
            widget.editPLayerData();
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 37, 45, 58),
            ),

            // Player data UI settings

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('${widget.playername} | ',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                '${widget.playerlevel}  ',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 248, 248),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text(
                            'Position: ${widget.playerrole}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 219, 216, 216),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                deleteOrMove = false;
                                changeOptions();
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Color.fromARGB(255, 188, 39, 39),
                                size: 30,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                deleteOrMove = true;
                                changeOptions();
                              },
                              icon: Icon(
                                widget.readyAbsent
                                    ? Icons.arrow_forward_rounded
                                    : Icons.arrow_back,
                                size: 30,
                                color: const Color.fromARGB(255, 229, 216, 216),
                              )),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                    ]),
              ],
            ),
          ),
        ));
  }
}
