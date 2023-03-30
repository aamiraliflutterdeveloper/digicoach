import 'package:clients_digcoach/data/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final String title;
  const LoadingWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.darkerGreen,
              borderRadius: BorderRadius.circular(10)
          ),
          width: 200.0,
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: LoadingAnimationWidget.discreteCircle(
                    size: 55, color: Colors.white,
                    secondRingColor: AppColors.darkerGreen,
                    thirdRingColor: Colors.white
                ),
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}






