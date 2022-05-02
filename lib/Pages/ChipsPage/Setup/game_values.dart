import 'package:flutter/material.dart';
import 'package:poker/Pages/ChipsPage/Setup/setup_controller.dart';
import 'package:provider/provider.dart';



class GameValues extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SetupController controller = Provider.of<SetupController>(context, listen: false);
    Map<String, TextEditingController> map = controller.gameValues();
    return Padding(
      padding: EdgeInsets.all(50),
      child: Column(
        children: [
          for(String text in map.keys) ...{
            _ValueAdjuster(text: text, controller: map[text]!,),
            SizedBox(height: 10,)
          }
        ],
      ),
    );
  }
}

class _ValueAdjuster extends StatelessWidget {
  TextEditingController controller;
  String text;
  _ValueAdjuster({required this.controller, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(text),

        SizedBox(
          width: 50,
          child: TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: controller,
          ),
        )
      ],
    );
  }
}

