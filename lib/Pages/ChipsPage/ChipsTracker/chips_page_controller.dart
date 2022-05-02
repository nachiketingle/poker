import 'package:flutter/material.dart';
import 'package:poker/Models/player.dart';

class ChipsPageController with ChangeNotifier {
  late List<Player> _players;
  int _currPlayer = 0;
  int get playerCount => _players.length;
  Player get currPlayer => _players[_currPlayer];
  int pot = 0;
  int minBet;
  int betValue = 1;
  int maxBet = 0;
  int startingChips;
  int bigBlind;
  int smallBlind;
  int buyIn;

  Player player(int index) => _players[index];

  ChipsPageController({List<Player>? players, this.minBet: 1, this.startingChips: 1000, this.bigBlind: 50, this.smallBlind: 100, this.buyIn: 25}) {
    _players = players ?? _defaultList();
    if(_players.isEmpty)
      _players.addAll(_defaultList());
    _players[0].turn = true;
  }

  List<Player> _defaultList() {
    List<Player> _players = [];
    _players.add(Player(name: "Nacho", chips: startingChips));
    _players.add(Player(name: "Aaron", chips: startingChips));
    _players.add(Player(name: "Kevin", chips: startingChips));
    _players.add(Player(name: "Ryan", chips: startingChips));
    _players.add(Player(name: "Kasper", chips: startingChips));

    _players[0].turn = true;
    return _players;
  }

  void swap(int oldIndex, int newIndex) {
    //_players.insert(newIndex >= _players.length?_players.length:newIndex, _players.removeAt(oldIndex));
    Player player = _players[oldIndex];

    for(Player p in _players)
      p.turn = false;

    if(oldIndex > newIndex) {
      _players.removeAt(oldIndex);
      _players.insert(newIndex, player);
    }
    else {
      _players.insert(newIndex, player);
      _players.removeAt(oldIndex);
    }

    currPlayer.turn = true;

    // _players.forEach((element) {
    //   print(element.name);
    // });
  }

  void setCurrent(int index) {
    currPlayer.turn = false;
    _currPlayer = index;
    currPlayer.turn = true;
    notifyListeners();
  }

  void nextPlayer() {
    _players[_currPlayer++].turn = false;
    if(_currPlayer >= _players.length)
      _currPlayer = 0;
    _players[_currPlayer].turn = true;
    betValue = minBet;
    notifyListeners();
  }

  bool addToPot(int value) {
    Player player = _players[_currPlayer];
    if(player.chips < value || value <= 0)
      return false;

    betValue = minBet;
    player.chips -= value;
    player.bet += value;
    pot += value;

    if(maxBet < player.bet)
      maxBet = player.bet;
    print("Added $value");
    notifyListeners();
    return true;
  }

  bool callBet() {
    return addToPot(maxBet - currPlayer.bet);
  }

  bool addBigBlind() {
    return addToPot(bigBlind);
  }

  bool addSmallBlind() {
    return addToPot(smallBlind);
  }

  bool addBuyIn() {
    return addToPot(buyIn);
  }

  bool raise(int value) {
    return addToPot(maxBet - currPlayer.bet + value);
  }

  void newBetValue(double value) {

    betValue = value.round();
    notifyListeners();
  }

  void changeBetValue(int value) {
    if((currPlayer.chips == 0 && value > 0))
      return;
    if(betValue + value < minBet)
      betValue = minBet;
    else if(betValue + value > currPlayer.chips)
      betValue = currPlayer.chips;
    else
      betValue += value;

    notifyListeners();
  }

  void takePot() {
    currPlayer.chips += pot;
    pot = 0;
    maxBet = 0;
    for(Player p in _players)
      p.bet = 0;
    notifyListeners();
  }
}