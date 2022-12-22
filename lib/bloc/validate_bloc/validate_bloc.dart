import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livi_demo/model/data_models.dart';

import '../../model/data_models.dart';

part 'validate_event.dart';
part 'validate_state.dart';

class ValidateBloc extends Bloc<ValidateEvent, ValidateState> {
  ValidateBloc() : super(const ValidateState.unknown()){
    on<ValidateChangeArea>(_onValidateChangeArea);
    on<ValidatePhoneChange>(_onValidatePhoneChange);
    on<ValidateSubmitted>(_onValidateSubmitted);
    on<ValidateSubmittedSuccess>(_onValidateSubmittedSuccess);
    on<ValidateSubmittedFailure>(_onValidateSubmittedFailure);
  }

  var _phone = "";
  AreaZoneEntry _choosedAreaCodeZone = AreaZoneEntry.empty;
  Set<ValidateResult> _submitHistory = <ValidateResult>{};

  String get areaCodeZone {
    if (_choosedAreaCodeZone != AreaZoneEntry.empty) return _choosedAreaCodeZone.code;
    return "852";
  }

  List<ValidateResult> get confirmHistory => _submitHistory.toList();

  void updatePhoneNum(String phoneNum) {
    _phone = phoneNum;
    if (state.status != AuthenticationStatus.unknown) {
      add(ValidatePhoneChange());
    }
  }

  void _onValidateChangeArea(ValidateChangeArea event,
      Emitter<ValidateState> emit) {
    if (_choosedAreaCodeZone != AreaZoneEntry.empty && _choosedAreaCodeZone.code == event.entry.code) return;
    _choosedAreaCodeZone = event.entry;
    emit(ValidateState.codeChange(event.entry));
  }

  void _onValidatePhoneChange(ValidatePhoneChange event,
      Emitter<ValidateState> emit) {
    emit(ValidateState.unknown());
  }

  void _onValidateSubmitted(
      ValidateSubmitted event,
      Emitter<ValidateState> emit
      ) async {
    if (_phone.isEmpty) return;
    debugPrint("_submitHistory phone list: ${_submitHistory.toList().toString()}");
    /*这里只做简单检验，正常应该根据不同的区域码做不通的处理*/
    if (_phone.length >= 6) {
      _submitHistory.add(ValidateResult(_phone, areaCodeZone, success: true));
      add(ValidateSubmittedSuccess());
    } else {
      _submitHistory.add(ValidateResult(_phone, areaCodeZone));
      add(ValidateSubmittedFailure());
    }
  }

  void _onValidateSubmittedSuccess(ValidateSubmittedSuccess event,
      Emitter<ValidateState> emit) {
    emit(ValidateState.success(_phone, _choosedAreaCodeZone));
  }

  void _onValidateSubmittedFailure(ValidateSubmittedFailure event,
      Emitter<ValidateState> emit) {
    emit(ValidateState.failure(_phone, _choosedAreaCodeZone));
  }
}


