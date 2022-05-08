import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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
                Navigator.of(context).pushNamed('/localSetup').then((value) => {
                  SystemChrome.setApplicationSwitcherDescription(
                      ApplicationSwitcherDescription(
                        label: 'Poker App',
                        primaryColor: Theme
                            .of(context)
                            .primaryColor
                            .value,
                      )
                  )

                });
              },
              child: Text("Local Game"),
            ),
          ],
        ),
      ),
    );
  }

}