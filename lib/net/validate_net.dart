import 'http_util.dart';
import 'package:livi_demo/model/data_models.dart';

class ValidateNet {
  static Future<List<AreaZoneEntry>> fetchPhoneList() async {
    // 每个模块网络请求最开始请求的时候需要处理下
    HttpUtil.init(baseUrl: "http://country.io");
    var response = await HttpUtil.get("/phone.json");
    Map<String, dynamic> r = Map<String, dynamic>.from(response);
    // debugPrint("phone.json data: ${r.toString()}");
    var list = <AreaZoneEntry>[];
    for (var element in r.entries) {
      list.add(AreaZoneEntry(element.key, element.value.toString()));
    }
    return list;
  }
}
