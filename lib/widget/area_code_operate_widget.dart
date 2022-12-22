import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livi_demo/bloc/validate_bloc/validate_bloc.dart';
import 'package:livi_demo/widget/page_area_zone_list.dart';

import '../model/data_models.dart';

class AreaCodeOperateWidget extends StatefulWidget {
  const AreaCodeOperateWidget({Key? key}) : super(key: key);

  @override
  State<AreaCodeOperateWidget> createState() => _AreaCodeOperateWidgetState();
}

class _AreaCodeOperateWidgetState extends State<AreaCodeOperateWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const PageAreaZoneList();
          })).then((value) {
            if (value == null) return;
            final AreaZoneEntry entry = value;
            setState(() {
              context.read<ValidateBloc>().add(ValidateChangeArea(entry));
            });
          });
        },
        icon: const Icon(Icons.add),
        label: Text(
          context.read<ValidateBloc>().areaCodeZone,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
