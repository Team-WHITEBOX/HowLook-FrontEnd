import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatelessWidget {
  final String userName;

  const ChatUserCard({
    required this.userName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.0,
            backgroundImage: ExtendedImage.asset(
                "asset/img/Profile/BaseProfile.JPG")
                .image,
          ),
          const SizedBox(width: 10),
          Text(userName),
        ],
      ),
    );
  }
}
