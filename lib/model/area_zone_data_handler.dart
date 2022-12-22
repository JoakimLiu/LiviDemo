import 'package:livi_demo/model/data_models.dart';
import 'package:livi_demo/net/validate_net.dart';

class AreaZoneDataHandler {

  Future<List<AreaZoneEntry>> fetchAreaCodeList() async {
    var list = await ValidateNet.fetchPhoneList();
    return list;
  }

  Future<List<AreaZoneEntry>> search(String key, List<AreaZoneEntry> list) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (key.trim().isEmpty) {
      var list = await ValidateNet.fetchPhoneList();
      return list;
    }

    var newList = <AreaZoneEntry>[];
    for (var element in list) {
      if (element.code.contains(key) || element.countryAbbr.contains(key)) {
        newList.add(element);
      }
    }
    return newList;
  }

}
