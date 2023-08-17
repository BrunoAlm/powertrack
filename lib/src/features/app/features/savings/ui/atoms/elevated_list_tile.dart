import 'package:flutter/material.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class ElevatedListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const ElevatedListTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          shadows: ThemeHelper.shadow(context),
          color: Theme.of(context).colorScheme.inverseSurface.withOpacity(.2),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
            ],
          ),
          subtitle: Text(
            subtitle,
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
