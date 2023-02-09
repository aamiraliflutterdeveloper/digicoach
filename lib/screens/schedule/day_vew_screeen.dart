import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/reservation_provider.dart';
import '../../widgets/schedule/day_view_widget.dart';

class DayViewScreen extends ConsumerStatefulWidget {
  const DayViewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DayViewScreenState();
}

class _DayViewScreenState extends ConsumerState<DayViewScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(reservationProvider).isLoading
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : const Expanded(child: DayViewWidget());
  }
}
