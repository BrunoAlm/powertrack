import 'package:flutter/material.dart';
import 'package:uitcc/src/app/domain/entities/user_entity.dart';

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
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/pt/thumb/8/86/Avatar_Aang.png/250px-Avatar_Aang.png'),
              maxRadius: 28.0,
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
