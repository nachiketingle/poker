import 'package:flutter/material.dart';
import 'package:poker/Pages/ChipsPage/Setup/setup_controller.dart';
import 'package:provider/provider.dart';

class NameList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Name list is here");
    SetupController controller = Provider.of<SetupController>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              decoration: InputDecoration(
                hintText: "New Name",
              ),
              controller: controller.nameController,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                controller.submitName();
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: controller.names.length,
              itemBuilder: (context, index) {
                return _NameTile(
                  name: controller.getName(index),
                  dismissed: () => controller.onDismissName(index),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

class _NameTile extends StatelessWidget {
  final String name;
  final Function dismissed;
  _NameTile({Key? key, required this.name, required this.dismissed}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: ListTile(
        title: Text(name),
      ),
      onDismissed: (_) => dismissed(),
    );
  }
}