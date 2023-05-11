import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/upload/Provider/upload_provider.dart';
import 'package:howlook/upload/component/image_select_list_widget.dart';

class ScrollPhoto extends ConsumerStatefulWidget {
  const ScrollPhoto({Key? key}) : super(key: key);

  @override
  ConsumerState<ScrollPhoto> createState() => _ScrollPhotoState();
}

class _ScrollPhotoState extends ConsumerState<ScrollPhoto> {
  // 사진 더 가져오는 함수
  Future<void> morePhotos() async {
    final stateRead = ref.read(getImageProvider.notifier);
    stateRead.getPhotos(stateRead.currentAlbum!);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        final scrollPixels =
            scroll.metrics.pixels / scroll.metrics.maxScrollExtent;

        if (scrollPixels > 0.7) morePhotos();

        return false;
      },
      child: const SafeArea(
        child: ImageSelectList(),
      ),
    );
  }
}
