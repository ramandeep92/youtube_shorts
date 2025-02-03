import 'package:flutter/material.dart';
import 'package:reels_viewer/reels_viewer.dart';
import 'package:reels_viewer/src/components/user_profile_image.dart';
import 'package:reels_viewer/src/utils/convert_numbers_to_short.dart';

import 'comment_bottomsheet.dart';

class ScreenOptions extends StatelessWidget {
  final Reel item;
  final bool showVerifiedTick;
  final Function(String)? onShare;
  final Function(String)? onLike;
  final Function(String)? onComment;
  final Function()? onClickMoreBtn;
  final Function()? onFollow;

  const ScreenOptions({
    Key? key,
    required this.item,
    this.showVerifiedTick = true,
    this.onClickMoreBtn,
    this.onComment,
    this.onFollow,
    this.onLike,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 110),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (item.thumbnailUrl != null)
                          UserProfileImage(profileUrl: item.thumbnailUrl ?? ''),
                        if (item.thumbnailUrl == null)
                          const CircleAvatar(
                            child: Icon(Icons.person, size: 18),
                            radius: 16,
                          ),
                        const SizedBox(width: 6),
                        Text(item.title,
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 10),
                        if (showVerifiedTick)
                          const Icon(
                            Icons.verified,
                            size: 15,
                            color: Colors.white,
                          ),
                        if (showVerifiedTick) const SizedBox(width: 6),
                        if (onFollow != null)
                          TextButton(
                            onPressed: onFollow,
                            child: const Text(
                              'Follow',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 6),
                    if (item.description != null)
                      Text(item.description ?? '',
                          style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 10),
                    if (item.title != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.music_note,
                            size: 15,
                            color: Colors.white,
                          ),
                          Text(
                            'Original Audio - ${item.title}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
