import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livi_demo/widget/area_code_operate_widget.dart';
import 'package:livi_demo/bloc/validate_bloc/validate_bloc.dart';
import 'package:livi_demo/widget/validate_result_widget.dart';

class ValidatePage extends StatelessWidget {
  const ValidatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Validate phone number",
          textAlign: TextAlign.center,
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          debugPrint("FocusScope tap");
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ValidatePageWidget(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: FloatingActionButton(
          child: const Icon(Icons.snowing),
          onPressed: () {},
        ),
      ),
    );
  }
}

class ValidatePageWidget extends StatefulWidget {
  const ValidatePageWidget({Key? key}) : super(key: key);

  @override
  State<ValidatePageWidget> createState() => _ValidatePageWidgetState();
}

class _ValidatePageWidgetState extends State<ValidatePageWidget> {
  late TextEditingController _phoneController;
  var phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    _phoneController = TextEditingController()
      ..addListener(() {
        debugPrint("_phoneController onchange");
      });
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  BlocProvider<ValidateBloc> buildContainer() {
    return BlocProvider(
      create: (BuildContext context) => ValidateBloc(),
      child: BlocConsumer<ValidateBloc, ValidateState>(
        builder: (context, state) => buildContent(context),
        listener: (context, state) {
          debugPrint("BlocConsumer state change: $state");
        },
        listenWhen: (previous, current) {
          debugPrint("BlocConsumer state change when : $previous , $current}");
          return true;
        },
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    SizedBox paddingGap = const SizedBox(
      height: 20,
    );
    Widget header = Center(
      child: ClipOval(
        child: Opacity(
          opacity: 0.75,
          child: Container(
            height: 125,
            width: 125,
            decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: Colors.black12, width: 0.5),
                borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );

    return Column(
      children: [
        paddingGap,
        header,
        paddingGap,
        const Center(
          child: Text("Please enter a phone number:",
              style: TextStyle(fontSize: 16)),
        ),
        paddingGap,
        ValidateResultWidget(),
        paddingGap,
        buildInputWidget(context),
        const SubmitWidget(),
      ],
    );
  }

  Widget buildInputWidget(BuildContext context) {
    SizedBox widthGap = const SizedBox(
      width: 20,
    );

    return Row(
      children: [
        widthGap,
        const AreaCodeOperateWidget(),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 38),
            child: TextField(
              autofocus: true,
              focusNode: phoneFocus,
              onChanged: (content) {
                debugPrint("PhoneItem onChanged $content");
                context.read<ValidateBloc>().updatePhoneNum(content);
              },
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
            ),
          ),
        ),
        widthGap,
      ],
    );
  }
}

class SubmitWidget extends StatefulWidget {
  const SubmitWidget({Key? key}) : super(key: key);

  @override
  State<SubmitWidget> createState() => _SubmitWidgetState();
}

class _SubmitWidgetState extends State<SubmitWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<ValidateBloc>().add(ValidateSubmitted());
      },
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
      child: const Text(
        "Confirm",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
