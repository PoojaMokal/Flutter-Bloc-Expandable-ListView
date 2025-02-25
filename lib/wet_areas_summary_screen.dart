import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wet_areas_bloc.dart';
import 'wet_areas_state.dart';

class WetAreasSummaryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summary')),
      body: BlocBuilder<WetAreasBloc, WetAreasState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.all(16.0),
            children: state.selectedItems.keys.map((category) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...state.itemCounts[category]?.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                      child: Text('${entry.key}: ${entry.value}'),
                    );
                  }) ?? [],
                  Divider(),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
