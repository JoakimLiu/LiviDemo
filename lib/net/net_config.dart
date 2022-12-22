/// 网络配置
class NetConfig {
  NetConfig._();

  /// 是否启用代理 代理服务IP 代理服务端口
  static bool proxyEnable = false;
  static String proxyIp = '';
  static String proxyPort = '';

  /// 超时时间 60s
  static const int connectTimeout = 60000;

  /// 发送超时时间 30s
  static const int sendTimeout = 30000;

  /// 接收超时时间 30s
  static const int receiveTimeout = 30000;

  /// 请求内容类型 form，UTF-8
  static const String contentTypeForm = 'multipart/form-data;charset=utf-8';
  static const String headerContentType = "content-type";

}
