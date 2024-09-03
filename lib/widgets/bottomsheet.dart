import 'package:flutter/material.dart';

class CustomBottomsheet extends StatelessWidget {
  final bool isweather;
  const CustomBottomsheet({required this.isweather, super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.39,
      minChildSize: 0.1,
      maxChildSize: 0.4,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isweather ? Colors.amber : const Color(0xFFbdc3c7),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(41),
              topRight: Radius.circular(41),
            ),
          ),
        );
      },
    );
  }
}
