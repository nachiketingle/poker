import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poker/Models/player.dart';
import 'package:poker/Pages/ChipsPage/ChipsTracker/chips_page_controller.dart';

class SetupController with ChangeNotifier {
  Set<String> names = {};
  BuildContext context;
  TextEditingController nameController = TextEditingController();

  TextEditingController bigBlind = TextEditingController();
  TextEditingController smallBlind = TextEditingController();
  TextEditingController buyIn = TextEditingController();
  TextEditingController startingChips = TextEditingController();


  SetupController({required this.context}) {
    startingChips.text = "1000";
    bigBlind.text = "50";
    smallBlind.text = "25";
    buyIn.text = "10";
  }

  String getName(int index) {
    return names.toList()[index];
  }


  void submitName() {
    if(names.contains(nameController.text))
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Name already added"))
      );
    names.add(nameController.text);
    nameController.clear();
    notifyListeners();
  }

  void startGame(BuildContext context) {
    List<Player> players = names.map((e) => Player(name: e, chips: int.tryParse(startingChips.text) ?? 1000)).toList();
    ChipsPageController controller = ChipsPageController(
        players: players,
        startingChips: int.parse(startingChips.text),
        bigBlind: int.parse(bigBlind.text),
        smallBlind: int.parse(smallBlind.text),
        buyIn: int.parse(buyIn.text)
    );
    //SetupDTO dto = SetupDTO(players, int.parse(startingChips.text), int.parse(bigBlind.text), int.parse(smallBlind.text), int.parse(buyIn.text));
    Navigator.of(context).pushNamed('/localTracker', arguments: controller)
        .then((value) => {
      SystemChrome.setApplicationSwitcherDescription(
          ApplicationSwitcherDescription(
            label: 'Setup',
            primaryColor: Theme
                .of(context)
                .primaryColor
                .value,
          )
      )
    });
  }

  void onDismissName(int index) {
    names.remove(getName(index));
    notifyListeners();
  }

  Map<String, TextEditingController> gameValues() {
    Map<String, TextEditingController> map = Map();
    map["Starting Chips"] = startingChips;
    map["Big Blind"] = bigBlind;
    map["Small Blind"] = smallBlind;
    map["Buy In"] = buyIn;
    return map;
  }
}