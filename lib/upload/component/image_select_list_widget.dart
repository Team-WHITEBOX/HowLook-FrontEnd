import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/upload/Provider/upload_provider.dart';
import 'package:howlook/upload/component/grid_photo_widget.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageSelectList extends ConsumerWidget {
  const ImageSelectList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getState = ref.watch(GetImageProvider);

    return GridView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: getState.map((AssetEntity e) {
        return GridPhotoItemWidget(e: e);
      }).toList(),
    );
  }
}
