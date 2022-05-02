import 'package:poker/Models/player.dart';

class SetupDTO {
  List<Player> players;
  int chips;
  int bigBlind;
  int smallBlind;
  int buyIn;

  SetupDTO(this.players, this.chips, this.bigBlind, this.smallBlind, this.buyIn);
}