import 'package:flutter/material.dart';
import 'package:poker/Pages/ChipsPage/Setup/game_values.dart';
import 'package:poker/Pages/ChipsPage/Setup/name_list.dart';
import 'package:poker/Pages/ChipsPage/Setup/setup_controller.dart';
import 'package:provider/provider.dart';

class SetupPage extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SetupController(context: context),
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("Setup", style: TextStyle(color: Colors.black),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black,),
              onPressed: Navigator.of(context).pop,
            ),

          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              FocusScope.of(context).unfocus();
            },
            children: [
              NameList(),
              GameValues(),
            ],
          ),
          floatingActionButton: Consumer<SetupController>(
              builder: (context, controller, child) {
                return FloatingActionButton(
                  onPressed: () => controller.startGame(context),
                  child: child,
                );
              },
              child: Text("Start")
          ),
        );
      },
    );
  }
}



