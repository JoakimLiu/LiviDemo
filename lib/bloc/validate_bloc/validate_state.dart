part of 'validate_bloc.dart';

enum AuthenticationStatus { unknown, success, failure }

class ValidateState extends Equatable {
  final AuthenticationStatus status;
  final String phone;
  final AreaZoneEntry entry;

  const ValidateState._({
    this.status = AuthenticationStatus.unknown,
    this.phone = "",
    this.entry = AreaZoneEntry.empty
  });

  const ValidateState.unknown() : this._();

  const ValidateState.success(String phone, AreaZoneEntry entry)
      : this._(status: AuthenticationStatus.success, phone: phone, entry: entry);

  const ValidateState.failure(String phone, AreaZoneEntry entry)
      : this._(status: AuthenticationStatus.failure, phone: phone, entry: entry);

  const ValidateState.codeChange(AreaZoneEntry entry)
      : this._(entry: entry);

  @override
  List<Object> get props => [status, entry, phone];
}

