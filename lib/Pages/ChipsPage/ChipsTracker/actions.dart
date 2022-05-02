import 'package:flutter/material.dart';
import 'package:poker/Models/player.dart';
import 'package:poker/Pages/ChipsPage/ChipsTracker/chips_page_controller.dart';
import 'package:provider/provider.dart';

class PlayerActions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ChipsPageController _controller = Provider.of<ChipsPageController>(context, listen: false);

    return  Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _BasicButton(
            onPressed: () {
              _controller.nextPlayer();
            },
            text: "Next Player",
          ),

          SizedBox(height: 10,),
          Consumer<ChipsPageController>(
            builder: (_, controller, __) {
              return _BasicButton(
                onPressed: () {
                  bool success = _controller.addToPot(_controller.betValue);
                  if(!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Insufficient Chips"))
                    );
                  }
                },
                text: "Add " + controller.betValue.toString(),
              );
            },
          ),


          SizedBox(height: 10,),
          Consumer<ChipsPageController>(
            builder: (_, controller, __) {
              return _BasicButton(
                onPressed: () {
                  bool success = _controller.raise(_controller.betValue);
                  if(!success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Insufficient Chips"))
                    );
                  }
                },
                text: "Raise " + controller.betValue.toString(),
              );
            },
          ),

          SizedBox(height: 10,),
          _BasicButton(
            onPressed:  () {
              bool success = _controller.addBigBlind();
              if(!success) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Unable to perform action"))
                );
              }
            },
            text: "Big Blind (${_controller.bigBlind.toString()})",
          ),

          SizedBox(height: 10,),
          _BasicButton(
            onPressed:  () {
              bool success = _controller.addSmallBlind();
              if(!success) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Unable to perform action"))
                );
              }
            },
            text: "Small Blind (${_controller.smallBlind.toString()})",
          ),

          SizedBox(height: 10,),
          _BasicButton(
            onPressed:  () {
              bool success = _controller.addBuyIn();
              if(!success) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Unable to perform action"))
                );
              }
            },
            text: "Buy In (${_controller.buyIn.toString()})",
          ),

          SizedBox(height: 10,),
          _BasicButton(
            onPressed: () {
              bool success = _controller.callBet();
              if(!success) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Unable to perform action"))
                );
              }
            },
            text: "Call",
          ),

          SizedBox(height: 10,),
          _BasicButton(
            onPressed: _controller.takePot,
            text: "Take Pot",
          ),

        ],
      ),
    );
  }
}

class _BasicButton extends StatelessWidget {

  _BasicButton({this.onPressed, this.text});

  final Function? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(150, 50)
      ),
      onPressed: () {
        onPressed?.call();
      },
      child: Text(text ?? ""),
    );
  }
}
