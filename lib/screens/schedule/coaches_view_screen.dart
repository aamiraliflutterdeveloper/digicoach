import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/coach_provider.dart';
import '../../providers/reservation_provider.dart';
import '../../widgets/schedule/coaches_view_widget.dart';

class CoachesViewScreen extends ConsumerStatefulWidget {
  const CoachesViewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CouchesViewScreenState();
}

class _CouchesViewScreenState extends ConsumerState<CoachesViewScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(coachProvider).isLoading &&
            ref.watch(reservationProvider).isLoading
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : const Expanded(child: CoachesViewWidget());
  }
}
