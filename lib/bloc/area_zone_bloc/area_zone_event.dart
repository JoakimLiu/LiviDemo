part of 'area_zone_bloc.dart';

abstract class AreaZoneEvent extends Equatable {
  const AreaZoneEvent();

  @override
  List<Object> get props => [];
}

// 获取数据
class AreaZoneFetchData extends AreaZoneEvent {}

// 搜索
class AreaZoneSearch extends AreaZoneEvent {
  const AreaZoneSearch(this.keyword);

  final String keyword;

  @override
  List<Object> get props => [keyword];
}

