import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livi_demo/widget/page_validate_history.dart';

import '../bloc/validate_bloc/validate_bloc.dart';

class ValidateResultWidget extends StatefulWidget {
  const ValidateResultWidget({Key? key}) : super(key: key);

  @override
  State<ValidateResultWidget> createState() => _ValidateResultWidgetState();
}

class _ValidateResultWidgetState extends State<ValidateResultWidget> {
  late ValidateBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<ValidateBloc>();
    late Widget widget;
    switch (bloc.state.status) {
      case AuthenticationStatus.unknown:
        widget = Container();
        break;
      case AuthenticationStatus.success:
        widget = buildSucessWidget();
        break;
      case AuthenticationStatus.failure:
        widget = buildFailureWidget();
        break;
    }

    return Container(
      child: widget,
    );
  }

  Container buildFailureWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: Colors.redAccent,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "${bloc.state.phone} Validate Failure",
              style: TextStyle(fontSize: 14, color: Colors.redAccent),
            )
          ],
        ),
        buildTextButton()
      ],),
    );
  }

  Container buildSucessWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.brightness_auto_sharp,
                color: Colors.green,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${bloc.state.phone} Validate Success",
                style: TextStyle(fontSize: 14, color: Colors.green),
              )
            ],
          ),
          buildTextButton()
        ],
      ),
    );
  }

  TextButton buildTextButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ValidateHistoryPage(bloc.confirmHistory)));
      },
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
      child: const Text(
        "Check Confirm History",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
