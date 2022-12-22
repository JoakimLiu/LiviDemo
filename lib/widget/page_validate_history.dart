import 'package:flutter/material.dart';

import '../model/data_models.dart';

class ValidateHistoryPage extends StatelessWidget {
  final List<ValidateResult> list;

  const ValidateHistoryPage(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validate History"),
        centerTitle: true,
      ),
      body: ListView.separated(itemBuilder: (context, index) {
        var info = list[index];
        var sucessed = info.success;
        return ListTile(
          horizontalTitleGap: 0,
          leading: Icon(
            sucessed ? Icons.brightness_auto_sharp : Icons.error,
            color: sucessed ? Colors.green : Colors.redAccent,
          ),
          title: Text("code: ${info.code}, phone: ${info.phone}"),
        );;
      },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: list.length),
    );
  }
}



