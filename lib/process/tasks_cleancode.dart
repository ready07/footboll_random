import 'package:flutter/material.dart';
import 'package:football_app/process/ontap_dialogbox.dart';

class Newplayer extends StatefulWidget {
  final String playername;
  final String playerlevel;
  final String playerrole;
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
      required this.editPLayerData});
  
  
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
            // editPlayer: widget.editPLayerData,
          );
        });
    // Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 1, 1, 0),
        child: GestureDetector(
          onTap: changeOptions,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 37, 45, 58),
              // Color(0xFF262626)
              // borderRadius: BorderRadius.circular(8),
            ),

            // Player data UI settings

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text('${widget.playername} | ',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500
                          )),
                  // ignore: unrelated_type_equality_checks
                  Text( 
                    '${widget.playerlevel}  ',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 248, 248),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),

                  // ICON FOR REMOVING PLAYERS

                  // GestureDetector(
                  //   onTap: widget.deletePlayer,
                  //   child: const Icon(
                  //     size: 28,
                  //     Icons.delete_forever_rounded,
                  //     color: Color.fromARGB(255, 159, 17, 7),
                  //   ),
                  // ),

                  // ICON for moving players

                  // GestureDetector(
                  //   onTap: moveToReady,
                  //   child: const Icon(size: 25, Icons.arrow_right_alt_outlined),
                  // ),
                ]),
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
          ),
        ));
  }
}
