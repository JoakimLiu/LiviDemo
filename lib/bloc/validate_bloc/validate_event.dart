part of 'validate_bloc.dart';

abstract class ValidateEvent extends Equatable {
  const ValidateEvent();

  @override
  List<Object> get props => [];
}
/*区域码发生变化*/
class ValidateChangeArea extends ValidateEvent {
  const ValidateChangeArea(this.entry);

  final AreaZoneEntry entry;

  @override
  List<Object> get props => [entry];
}

/*电话号码发生变化*/
class ValidatePhoneChange extends ValidateEvent {}

/*提交操作*/
class ValidateSubmitted extends ValidateEvent {}

/*校验结果 成功*/
class ValidateSubmittedSuccess extends ValidateEvent {}

/*校验结果 失败*/
class ValidateSubmittedFailure extends ValidateEvent {}
