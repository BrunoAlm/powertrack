import 'package:flutter/material.dart';
import 'package:uitcc/src/app/domain/entities/user_entity.dart';
import 'package:uitcc/src/core/services/helpers/helper.dart';

class UserInfoAppBar extends StatelessWidget {
  final UserEntity user;
  const UserInfoAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: ShapeDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg"),
                  fit: BoxFit.fitWidth,
                ),
                shape: const OvalBorder(),
                shadows: ThemeHelper.shadow(context),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
