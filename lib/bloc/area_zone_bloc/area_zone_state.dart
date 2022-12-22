part of 'area_zone_bloc.dart';

class AreaZoneState extends Equatable {
  const AreaZoneState._({
    this.list = const <AreaZoneEntry>[],
    this.search = false,
  });

  AreaZoneState copyWithList({
    List<AreaZoneEntry>? list,
    bool? search,
  }) {
    return AreaZoneState(list ?? this.list, search ?? false);
  }

  const AreaZoneState.defaultState() : this._();

  final List<AreaZoneEntry> list;
  final bool search;

  const AreaZoneState(this.list, this.search);

  @override
  List<Object> get props => [list, search];
}
