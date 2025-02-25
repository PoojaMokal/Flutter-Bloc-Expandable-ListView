import 'package:equatable/equatable.dart';

abstract class WetAreasEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleSelectionEvent extends WetAreasEvent {
  final String itemName;
  ToggleSelectionEvent(this.itemName);
}

class IncrementCountEvent extends WetAreasEvent {
  final String itemName;
  final String subItem;
  IncrementCountEvent(this.itemName, this.subItem);
}

class DecrementCountEvent extends WetAreasEvent {
  final String itemName;
  final String subItem;
  DecrementCountEvent(this.itemName, this.subItem);
}
