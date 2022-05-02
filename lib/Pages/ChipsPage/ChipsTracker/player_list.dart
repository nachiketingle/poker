import 'package:flutter/material.dart';
import 'package:poker/Models/player.dart';
import 'package:poker/Pages/ChipsPage/ChipsTracker/chips_page_controller.dart';
import 'package:provider/provider.dart';

class PlayerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChipsPageController _controller = Provider.of<ChipsPageController>(context);
    return Expanded(
      flex: 1,
      child: ReorderableListView.builder(
        buildDefaultDragHandles: false,
        physics: NeverScrollableScrollPhysics(),
        header: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Player"),
              Text("In Pot"),
            ],
          ),
        ),
        onReorder: _controller.swap,
        itemCount: _controller.playerCount,
        itemBuilder: (context, index) {
          Player player = _controller.player(index);
          return ReorderableDragStartListener(
            key: Key(player.name),
            index: index,
            child: GestureDetector(
              key: Key(player.name),
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                color: player.turn ? Colors.green : Colors.red,
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(player.name, style: TextStyle(color: Colors.white),),
                          Text(player.chips.toString(), style: TextStyle(color: Colors.white),),
                        ],
                      ),
                      Text(player.bet.toString(), style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ),
              onTap: () => _controller.setCurrent(index),
            ),
          );
        },
      ),
    );
  }
}