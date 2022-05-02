import 'package:flutter/material.dart';
import 'package:poker/Models/player.dart';
import 'package:poker/Pages/ChipsPage/ChipsTracker/chips_page_controller.dart';
import 'package:provider/provider.dart';

class BettingSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChipsPageController _controller = Provider.of<ChipsPageController>(context);
    return Column(
      children: [
        Consumer<ChipsPageController>(
            builder: (_, controller, __)  {
              Player player = controller.currPlayer;
              return Slider(
                label: controller.betValue.round().toString(),
                divisions: player.chips > 0 ? player.chips : 1,
                value: controller.betValue > 0 ? _controller.betValue.toDouble() : 1,
                onChanged: player.chips > 0 ? (newVal) {
                  controller.newBetValue(newVal);
                } : null,
                min: controller.minBet.toDouble(),
                max: player.chips > 0 ? player.chips.toDouble() : 1,
              );
            }
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BettingButton(value: 25, positive: false),
            _BettingButton(value: 5, positive: false),
            _BettingButton(value: 1, positive: false),
            _BettingButton(value: 1, positive: true),
            _BettingButton(value: 5, positive: true),
            _BettingButton(value: 25, positive: true),
          ],
        ),
      ],
    );
  }
}

class _BettingButton extends StatelessWidget {

  _BettingButton({required this.value, required this.positive});

  final int value;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    ChipsPageController _controller = Provider.of<ChipsPageController>(context, listen: false);
    return ElevatedButton(
      onPressed: () {
        _controller.changeBetValue(positive ? value : -value);
      },
      child: Text((positive ? "+" : "-") + value.toString()),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(30, 35),
          shape: CircleBorder()
      ),
    );
  }
}
