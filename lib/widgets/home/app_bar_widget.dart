import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/court_provider.dart';
import 'package:clients_digcoach/providers/reservation_provider.dart';
import 'package:clients_digcoach/utils/responsive.dart';
import 'package:clients_digcoach/widgets/progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/coach_provider.dart';
import '../drop_down_widget.dart';

class AppBarWidget extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _AppBarWidgetState extends ConsumerState<AppBarWidget> {
  String currentLanguageValue = '0';

  @override
  void initState() {
    super.initState();

    ref.read(clubProvider).getClub();
  }

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
      toolbarHeight: 100,
      leading: isDesktop
          ? null
          : IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: AppColors.primaryColor),
            ),
      title: Row(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/Logo.png',
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(width: 16),
          if (isDesktop) ...[
            Expanded(
              flex: 2,
              child: DropDownWidget(
                hintText: 'Select Club',
                currentValue: ref.watch(clubProvider).selectedClubId,
                onChanged: _onClubChanged,
                values: ref.read(clubProvider).clubs.map((e) => e.id).toList(),
                items: ref
                    .read(clubProvider)
                    .clubs
                    .map((e) => e.generalInfo.name)
                    .toList(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropDownWidget(
                hintText: 'Select Language',
                currentValue: currentLanguageValue,
                onChanged: (value) =>
                    setState(() => currentLanguageValue = value!),
                items: const ['English', 'Spanish', 'Italian'],
                values: const ['0', '1', '2'],
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(child: ProgressBarWidget()),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.help),
              color: AppColors.primaryColor,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.brightness_4),
              color: AppColors.primaryColor,
            ),
            const Text(
              "Alberto",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.exit_to_app),
              color: AppColors.primaryColor,
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
    ref.read(courtProvider).getCourtNumber(value);
    ref.read(coachProvider).getCoachesByClubId(value);
    ref.read(coachProvider).getCoachId(value);
    ref.read(reservationProvider).getReservationsByCoachId(
        coachId: ref.watch(coachProvider).selectedCoachId!);
  }
}
