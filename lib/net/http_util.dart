import 'package:dio/dio.dart';
import 'net_util.dart';

class HttpUtil {
  static LoadingInterceptor loadingInterceptor = LoadingInterceptor();

  static void init({
    String baseUrl = '',
    int? connectTimeout,
    int? sendTimeout,
    int? receiveTimeout,
    List<Interceptor>? interceptors,
  }) {
    NetUtil.instance.init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      interceptors: interceptors,
    );

    //处理通用的实体
    NetUtil.instance.addInterceptor(ResponseInterceptor());
    //处理全局loading
    NetUtil.instance.addInterceptor(loadingInterceptor);
  }

  ///Get请求
  static Future get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        bool isLoading = true,
      }) async {
    var response = await request(
      path,
      method: HttpMethod.get,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      isLoading: isLoading,
    );
    return response;
  }

  ///Post请求
  static Future post(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        bool isLoading = true,
      }) async {
    var response = await request(
      path,
      method: HttpMethod.post,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      isLoading: isLoading,
    );
    return response;
  }

  /// Request 操作
  /// Put、Delete请求之类都请使用Request请求
  ///
  /// 所有类型请求,都是调用此请求
  static Future request(
      String path, {
        HttpMethod method = HttpMethod.get,
        data,
        bool isLoading = true,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    loadingInterceptor.isLoading = isLoading;

    var response = await NetUtil.instance.request(
      path,
      method: method,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  ///设置请求头
  static void setHeaders(Map<String, dynamic> map) {
    NetUtil.instance.setHeaders(map);
  }

  ///设置取消token
  static void cancelRequests({CancelToken? token}) {
    NetUtil.instance.cancelRequests(token: token);
  }
}

///此处定义一个响应拦截器
class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /*
    处理最外层数据结构
    response.data = xxx;
     */

    handler.next(response);
  }
}

///此处定义一个弹窗加载拦截器
class LoadingInterceptor extends Interceptor {
  bool isLoading = true;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //打开加载弹窗
    if (isLoading) {
      // xxx;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    //关闭弹窗
    if (isLoading) {
      // xxx
    }
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    //关闭弹窗
    if (isLoading) {
      // xxx
    }
    handler.next(err);
  }
}
