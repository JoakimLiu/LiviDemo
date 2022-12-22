
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livi_demo/model/data_models.dart';

import '../../model/area_zone_data_handler.dart';

part 'area_zone_event.dart';
part 'area_zone_state.dart';

class AreaZoneBloc extends Bloc<AreaZoneEvent, AreaZoneState> {
  AreaZoneBloc() : super(const AreaZoneState.defaultState()){
    on<AreaZoneFetchData>(_onAreaZoneFetchData);
    on<AreaZoneSearch>(_onAreaZoneSearch);
  }

  final _dataHandler = AreaZoneDataHandler();
  late List<AreaZoneEntry> _datas, _originalDatas;

   void _onAreaZoneFetchData(AreaZoneFetchData event, Emitter<AreaZoneState> emit) async {
     var list = await _dataHandler.fetchAreaCodeList();
     _datas = list;
     _originalDatas = list;
     // debugPrint("_originalDatas: ${_originalDatas.length}");
     emit(state.copyWithList(list: list, search: false));
   }

  void _onAreaZoneSearch(AreaZoneSearch event, Emitter<AreaZoneState> emit) async {
    var list = await _dataHandler.search(event.keyword, _originalDatas);
    // debugPrint("search key: ${event.keyword}, _originalDatas: ${_originalDatas.length}, result: ${list.length}");
    _datas.clear();
    _datas.addAll(list);
    emit(state.copyWithList(list: list, search: true));
  }

}
