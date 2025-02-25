import 'package:equatable/equatable.dart';

class WetAreasState extends Equatable {
  final Map<String, bool> selectedItems;
  final Map<String, Map<String, int>> itemCounts;

  const WetAreasState({required this.selectedItems, required this.itemCounts});

  WetAreasState copyWith({
    Map<String, bool>? selectedItems,
    Map<String, Map<String, int>>? itemCounts,
  }) {
    return WetAreasState(
      selectedItems: selectedItems ?? this.selectedItems,
      itemCounts: itemCounts ?? this.itemCounts,
    );
  }

  @override
  List<Object> get props => [selectedItems, itemCounts];
}
