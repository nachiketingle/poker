import 'package:flutter/material.dart';


class Menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/localSetup');
              },
              child: Text("Local Game"),
            ),
          ],
        ),
      ),
    );
  }

}