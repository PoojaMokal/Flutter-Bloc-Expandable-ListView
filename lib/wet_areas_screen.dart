import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wet_areas_bloc.dart';
import 'wet_areas_event.dart';
import 'wet_areas_state.dart';
import 'wet_areas_summary_screen.dart'; // Import the new screen

class WetAreasScreen extends StatelessWidget {
  final List<String> categories = [
    'Bathroom',
    'Kitchen',
    'Balcony',
    'Garden',
    'Laundry'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wet Areas')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<WetAreasBloc, WetAreasState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    bool isExpanded = state.selectedItems[category] ?? false;

                    return Column(
                      children: [
                        CheckboxListTile(
                          title: Text(category),
                          value: isExpanded,
                          onChanged: (_) {
                            context.read<WetAreasBloc>().add(ToggleSelectionEvent(category));
                          },
                        ),
                        if (isExpanded)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.itemCounts[category]?.length ?? 0,
                            itemBuilder: (context, subIndex) {
                              final subItem = state.itemCounts[category]?.keys.elementAt(subIndex) ?? '';
                              final count = state.itemCounts[category]?[subItem] ?? 0;

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(subItem),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            context.read<WetAreasBloc>().add(DecrementCountEvent(category, subItem));
                                          },
                                        ),
                                        Text('$count'),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            context.read<WetAreasBloc>().add(IncrementCountEvent(category, subItem));
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WetAreasSummaryScreen()),
                );
              },
              child: Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
