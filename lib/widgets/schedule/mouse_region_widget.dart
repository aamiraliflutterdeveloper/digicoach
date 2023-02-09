import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/utils.dart';

class MouseRegionWidget extends StatefulWidget {
  const MouseRegionWidget({
    super.key,
    required this.child,
    required this.controller,
  });

  final Widget child;
  final CalendarController controller;

  @override
  State<MouseRegionWidget> createState() => _MouseRegionWidgetState();
}

class _MouseRegionWidgetState extends State<MouseRegionWidget> {
  final layerLink = LayerLink();
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) => MouseRegion(
        onHover: (event) {
          CalendarDetails? details = widget
              .controller.getCalendarDetailsAtOffset!(event.localPosition);

          if (details?.targetElement != CalendarElement.appointment) {
            hideOverlay();
          }
          if (details?.targetElement == CalendarElement.appointment) {
            final startTime = details?.appointments![0].startTime;
            final endTime = details?.appointments![0].endTime;
            final appointment = details?.appointments![0];
            Appointment? lastHoveredAppointment;

            if (lastHoveredAppointment != appointment) {
              if (appointment == null) {
                hideOverlay();
              } else {
                hideOverlay();
                showOverlay(event, startTime, endTime);
              }
            } else {
              hideOverlay();
            }
            hideOverlay();
            showOverlay(event, startTime, endTime);
            lastHoveredAppointment = appointment;
          }
        },
        child: CompositedTransformTarget(link: layerLink, child: widget.child),
      );

  void showOverlay(
      PointerHoverEvent event, DateTime startTime, DateTime endTime) {
    final renderBox = (context.findRenderObject() as RenderBox);
    final size = renderBox.size;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 200,
        height: 100,
        child: CompositedTransformFollower(
          showWhenUnlinked: false,
          offset: event.localPosition - const Offset(200, 100),
          link: layerLink,
          child: buildOverlay(
            '${Utils.toDate(startTime)} - ${Utils.toTime(startTime)}',
            '${Utils.toDate(endTime)} - ${Utils.toTime(endTime)}',
          ),
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry!);
  }

  void hideOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  Widget buildOverlay(String start, String end) => Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'APPOINTMENT',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Start: $start'),
            Text('End: $end'),
          ],
        ),
      );
}
