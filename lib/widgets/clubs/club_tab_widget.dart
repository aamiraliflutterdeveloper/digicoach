import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/colors.dart';
import '../../providers/club_provider.dart';

class ClubTabWidget extends ConsumerWidget {
  const ClubTabWidget({
    super.key,
    required this.index,
    required this.titles,
  });

  final int index;
  final List<String> titles;

  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
      onTap: () => ref.read(clubProvider).currentIndex = index,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ref.watch(clubProvider).currentIndex == index
              ? kSecondaryColor
              : kPrimaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Text(
          titles[index],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
}
