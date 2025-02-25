import 'package:flutter_bloc/flutter_bloc.dart';
import 'wet_areas_event.dart';
import 'wet_areas_state.dart';

class WetAreasBloc extends Bloc<WetAreasEvent, WetAreasState> {
  WetAreasBloc() : super(WetAreasState(selectedItems: {}, itemCounts: {})) {

    on<ToggleSelectionEvent>((event, emit) {
      final newSelections = Map<String, bool>.from(state.selectedItems);
      final newItemCounts = Map<String, Map<String, int>>.from(state.itemCounts);

      if (newSelections.containsKey(event.itemName)) {
        newSelections.remove(event.itemName);
        newItemCounts.remove(event.itemName);
      } else {
        newSelections[event.itemName] = true;
        newItemCounts[event.itemName] = _initializeSubItems(event.itemName);
      }

      emit(state.copyWith(selectedItems: newSelections, itemCounts: newItemCounts));
    });

    on<IncrementCountEvent>((event, emit) {
      final newCounts = Map<String, Map<String, int>>.from(state.itemCounts);

      if (newCounts[event.itemName] == null) {
        newCounts[event.itemName] = {}; // Ensure map exists
      }

      final subItemCounts = Map<String, int>.from(newCounts[event.itemName]!);
      subItemCounts[event.subItem] = (subItemCounts[event.subItem] ?? 0) + 1;

      newCounts[event.itemName] = subItemCounts;

      emit(state.copyWith(itemCounts: newCounts));
    });

    on<DecrementCountEvent>((event, emit) {
      final newCounts = Map<String, Map<String, int>>.from(state.itemCounts);

      if (newCounts[event.itemName] == null) return;

      final subItemCounts = Map<String, int>.from(newCounts[event.itemName]!);

      if ((subItemCounts[event.subItem] ?? 0) > 0) {
        subItemCounts[event.subItem] = subItemCounts[event.subItem]! - 1;
      }

      newCounts[event.itemName] = subItemCounts;

      emit(state.copyWith(itemCounts: newCounts));
    });
  }

  /// Initializes sub-items with a count of 0
  Map<String, int> _initializeSubItems(String itemName) {
    switch (itemName) {
      case 'Bathroom':
        return {'Sink': 0, 'Shower': 0, 'Toilet': 0, 'Bathtub': 0};
      case 'Kitchen':
        return {'Sink': 0, 'Stove': 0};
      case 'Balcony':
        return {'Drain': 0};
      case 'Garden':
        return {'Sprinkler': 0, 'Fountain': 0};
      case 'Laundry':
        return {'Washing Machine': 0, 'Dryer': 0};
      default:
        return {'Default Item': 0};
    }
  }
}
