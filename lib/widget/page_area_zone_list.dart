import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/area_zone_bloc/area_zone_bloc.dart';
import '../model/data_models.dart';

class PageAreaZoneList extends StatelessWidget {
  const PageAreaZoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Area Zone List",
        ),
      ),
      body: const _PageAreaZoneList(),
    );
  }
}

class _PageAreaZoneList extends StatefulWidget {
  const _PageAreaZoneList({Key? key}) : super(key: key);

  @override
  State<_PageAreaZoneList> createState() => _PageAreaZoneListState();
}

class _PageAreaZoneListState extends State<_PageAreaZoneList> {
  var _searchKey = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AreaZoneBloc()..add(AreaZoneFetchData()),
      child: BlocBuilder<AreaZoneBloc, AreaZoneState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                buildSearchBar(context),
                state.list.isEmpty
                    ? (state.search ? buildEmpty() : buildLoading())
                    : buildListView(state.list)
              ],
            ),
          );
        },
        buildWhen: (previous, next) {
          debugPrint(
              "AreaZoneBloc state change previous: ${previous.list.length}, next: ${next.list.length}");
          return true;
        },
      ),
    );
  }

  Widget buildListView(List<AreaZoneEntry> list) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var data = list[index];
          var phone = data.code;
          var country = data.countryAbbr;
          return buildListItem(context, phone, country, index, list);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: list.length);
  }

  Widget buildEmpty() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 38),
      child: const Text("No result"),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    var outLineBorder = const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0x00FF0000)),
        borderRadius: BorderRadius.all(Radius.circular(10)));
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 38),
            child: TextField(
              onChanged: (value) {
                _searchKey = value.toUpperCase();
                context.read<AreaZoneBloc>().add(AreaZoneSearch(value));
              },
              decoration: InputDecoration(
                  hintText: "search ...",
                  filled: true,
                  fillColor: const Color(0x30cccccc),
                  contentPadding: const EdgeInsets.only(left: 30),
                  enabledBorder: outLineBorder,
                  focusedBorder: outLineBorder,
                  border: outLineBorder),
            ),
          ))
        ],
      ),
    );
  }

  buildListItem(BuildContext context, String phone, String country, int index,
      List<AreaZoneEntry> list) {
    return ListTile(
      title: Row(
        children: [
          const Icon(Icons.code),
          const SizedBox(
            width: 5,
          ),
          Text(
            phone,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            country,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
      onTap: () {
        if (index < list.length) {
          Navigator.of(context).pop(list[index]);
        }
      },
    );
  }
}
