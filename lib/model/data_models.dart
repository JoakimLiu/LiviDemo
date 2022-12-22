
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class AreaZoneEntry extends Equatable {
  /*国家简称*/
  final String countryAbbr;
  /*编码*/
  final String code;

  const AreaZoneEntry(this.countryAbbr, this.code);

  @override
  List<Object> get props => [countryAbbr, code];

  static const empty = AreaZoneEntry('-', '-');

}

/*验证结果*/
class ValidateResult {
  String phone;
  String code;
  bool success;

  ValidateResult(this.phone, this.code, {this.success = false});

  @override
  int get hashCode {
    int phoneHash = phone.isEmpty ? 0 : phone.hashCode;
    int codeHash = code.isEmpty ? 0 : code.hashCode;
    return phoneHash ^ codeHash;
  }

  @override
  bool operator ==(Object other) {
    if (null == other || other is! ValidateResult) {
      return false;
    }
    final ValidateResult otherR = other;
    bool phoneCompare = (null != phone &&
        phone.length > 0 &&
        phone.compareTo(
            otherR.phone == null || otherR.phone.length == 0
                ? ''
                : otherR.phone) ==
            0);
    bool codeCompare = (null != code &&
        code.length > 0 &&
        code.compareTo(
            otherR.code == null || otherR.code.length == 0
                ? ''
                : otherR.code) ==
            0);
    return phoneCompare & codeCompare;
  }

  @override
  String toString() {
    return 'ValidateResult{phone: $phone, code: $code, success: $success}';
  }
}
