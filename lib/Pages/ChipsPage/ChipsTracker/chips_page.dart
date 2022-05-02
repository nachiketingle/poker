import 'package:flutter/material.dart';
import 'package:poker/Pages/ChipsPage/ChipsTracker/betting_slider.dart';
import 'package:poker/Pages/ChipsPage/ChipsTracker/actions.dart';
import 'package:poker/Pages/ChipsPage/ChipsTracker/chips_page_controller.dart';
import 'package:poker/Pages/ChipsPage/ChipsTracker/player_list.dart';
import 'package:provider/provider.dart';

class ChipsPage extends StatefulWidget {
  @override
  _ChipsPageState createState() => _ChipsPageState();
}

class _ChipsPageState extends State<ChipsPage> {

  Future<bool> onWillPop() async {
    bool result = await showDialog<bool>(context: context, builder: (context) {
      return AlertDialog(
        title: Text("You are about to leave"),
        content: Text("Are you sure you want to leave? Progress will not be saved."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.settings.name=='/');
            },
            child: Text("Leave"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text("Cancel"),
          )
        ],
      );
    }) ?? false;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    //SetupDTO dto = ModalRoute.of(context)!.settings.arguments as SetupDTO;
    ChipsPageController _c = ModalRoute.of(context)!.settings.arguments as ChipsPageController;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chip Tracker", style: TextStyle(color: Colors.black),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,),
            onPressed: () async {
              if (await onWillPop())
                Navigator.of(context).popUntil((route) => route.settings.name == '/');
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: ChangeNotifierProvider<ChipsPageController>.value(
            // create: (_) => ChipsPageController(
            //   players: dto.players,
            //   startingChips: dto.chips,
            //   bigBlind: dto.bigBlind,
            //   smallBlind: dto.smallBlind,
            //   buyIn: dto.buyIn,
            // ),
            value: _c,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer(
                  builder: (_, ChipsPageController controller, ____) {
                    return Text(
                        "POT: " + controller.pot.toString(),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    );
                  },
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PlayerList(),
                      PlayerActions(),
                    ],
                  ),
                ),
                BettingSlider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
