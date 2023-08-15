import 'package:flutter/material.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

/// Altera a borda do ActiveButton para esquerda ou para direita
enum ActiveButtonPosition { left, right }

extension ActiveButtonRadius on ActiveButtonPosition {
  BorderRadius get radius {
    switch (this) {
      case ActiveButtonPosition.left:
        return const BorderRadius.only(
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        );
      case ActiveButtonPosition.right:
        return const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        );
      default:
        return BorderRadius.circular(25);
    }
  }
}

class ActiveButton extends StatelessWidget {
  final void Function() onTap;
  final ActiveButtonPosition position;
  final String text;
  final IconData icon;
  const ActiveButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.position,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          shape: RoundedRectangleBorder(borderRadius: position.radius),
          shadows: ThemeHelper.shadow(context),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 5),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
