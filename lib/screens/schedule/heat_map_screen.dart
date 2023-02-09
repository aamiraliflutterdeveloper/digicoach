import 'package:clients_digcoach/providers/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/schedule/heat_map_widget.dart';

class HeatMapScreen extends ConsumerStatefulWidget {
  const HeatMapScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeatMapPageState();
}

class _HeatMapPageState extends ConsumerState<HeatMapScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(reservationProvider).isLoading
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : const Expanded(child: HeatMapWidget());
  }
}
