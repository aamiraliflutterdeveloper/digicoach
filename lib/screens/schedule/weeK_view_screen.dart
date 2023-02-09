import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/reservation_provider.dart';
import 'package:clients_digcoach/widgets/drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/court_provider.dart';
import '../../widgets/schedule/week_view_widget.dart';

class WeekViewScreen extends ConsumerStatefulWidget {
  const WeekViewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekViewScreenState();
}

class _WeekViewScreenState extends ConsumerState<WeekViewScreen> {
  @override
  Widget build(BuildContext context) {
    final courts = ref.read(courtProvider).courtsByClubId;
    return ref.watch(reservationProvider).isLoading
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: DropDownWidget(
                    hint: 'Select Court',
                    // currentValue: ref.watch(courtProvider).selectedCourtId,
                    currentValue: ref.watch(courtProvider).selectedCourtNumber,
                    onChanged: _onChangedCourt,
                    id: courts.map((e) => e.courtNumber.toString()).toList(),
                    items: courts.map((e) => e.name).toList(),
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(child: WeekViewWidget()),
              ],
            ),
          );
  }

  void _onChangedCourt(String? value) {
    // ref.read(courtProvider).selectedCourtId = value!;
    ref.read(courtProvider).selectedCourtNumber = value!;
    // ref.read(reservationProvider).getReservationsByCourtId(value);
    ref.read(reservationProvider).getReservationsByCourtNumber(int.parse(value));
  }
}
