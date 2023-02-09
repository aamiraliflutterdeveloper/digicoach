import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/court_provider.dart';
import 'package:clients_digcoach/providers/reservation_provider.dart';
import 'package:clients_digcoach/widgets/progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/colors.dart';
import '../../core/responsive.dart';
import '../../providers/coach_provider.dart';
import '../drop_down_widget.dart';

class AppBarWidget extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(75);
}

class _AppBarWidgetState extends ConsumerState<AppBarWidget> {
  String currentLanguageValue = '0';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive();
    responsive.init(context);
    final isDesktop = responsive.isDesktop;
    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: false,
      toolbarHeight: 75,
      leading: isDesktop
          ? null
          : IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: kPrimaryColor),
            ),
      title: Row(
        children: [
          const Expanded(
              child:
                  Icon(Icons.sports_baseball, color: kPrimaryColor, size: 70)),
          const SizedBox(width: 16),
          if (isDesktop) ...[
            Expanded(
              flex: 2,
              child: DropDownWidget(
                hint: 'Select Club',
                currentValue: ref.watch(clubProvider).selectedClubId,
                onChanged: _onClubChanged,
                id: ref.read(clubProvider).clubs.map((e) => e.id).toList(),
                items: ref.read(clubProvider).clubs.map((e) => e.generalInfo.name).toList(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropDownWidget(
                hint: 'Select Language',
                currentValue: currentLanguageValue,
                onChanged: (value) =>
                    setState(() => currentLanguageValue = value!),
                items: const ['English', 'Spanish', 'Italian'],
                id: const ['0', '1', '2'],
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(child: ProgressBarWidget()),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.help),
              color: kPrimaryColor,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.brightness_4),
              color: kPrimaryColor,
            ),
            const Text(
              "Alberto",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.exit_to_app),
              color: kPrimaryColor,
            ),
          ],
        ],
      ),
    );
  }

  void _onClubChanged(String? value) {
    ref.read(clubProvider).selectedClubId = value!;
    ref.read(reservationProvider).getReservationsByClubId(value);
    ref.read(courtProvider).getCourtsByClubId(value, ref);
    ref.read(coachProvider).getCoachesByClubId(value);
  }
}
