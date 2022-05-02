class Player {
  bool turn;
  bool dealer;
  bool bigBlind;
  bool smallBlind;
  int chips;
  int bet = 0;
  String name;

  Player({required this.name, this.chips: 1000, this.turn: false,
    this.dealer: false, this.bigBlind: false, this.smallBlind: false});

}