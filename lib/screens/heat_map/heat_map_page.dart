import 'package:clients_digcoach/services/club_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/heat_map_widget.dart';

class HeatMapPage extends ConsumerStatefulWidget {
  const HeatMapPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeatMapPageState();
}

class _HeatMapPageState extends ConsumerState<HeatMapPage> {
  @override
  void initState() {
    super.initState();
    _fetchClubsReservations();
  }

  void _fetchClubsReservations() async {
    await ref.read(clubServiceProvider.notifier).getClubs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(clubServiceProvider.notifier).getClubs(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const HeatMapWidget();
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
