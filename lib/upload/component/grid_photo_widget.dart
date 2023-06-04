import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/upload/Provider/review_upload_provider.dart';
import 'package:howlook/upload/Provider/select_photo_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class GridPhotoItemWidget extends ConsumerStatefulWidget {
  final AssetEntity e;
  const GridPhotoItemWidget({Key? key, required this.e}) : super(key: key);

  @override
  ConsumerState<GridPhotoItemWidget> createState() =>
      _GridPhotoItemWidgetState();
}

class _GridPhotoItemWidgetState extends ConsumerState<GridPhotoItemWidget> {
  void _selectImage(AssetEntity e, bool isReviewUpload) {
    ref.read(selectedImageProvider.notifier).selectImage(e, isReviewUpload);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final isReview = ref.watch(isReviewUpload);
        setState(() {
          _selectImage(widget.e, isReview);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: AssetEntityImage(
                widget.e,
                isOriginal: false,
                fit: BoxFit.cover,
              ),
            ),
            _dimContainer(widget.e),
            _selectNumberContainer(widget.e)
          ],
        ),
      ),
    );
  }

  Widget _dimContainer(AssetEntity e) {
    final selectedState = ref.watch(selectedImageProvider);

    final isSelected = selectedState.any((element) => element.image == e);
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black38 : Colors.transparent,
        ),
      ),
    );
  }

  Widget _selectNumberContainer(AssetEntity e) {
    final selectedState = ref.watch(selectedImageProvider);

    final num = selectedState.indexWhere((element) => element.image == e) + 1;
    return Positioned(
        right: 8,
        top: 1,
        child: num != 0
            ? Container(
                width: 23,
                height: 35,
                padding: const EdgeInsets.all(7.5),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$num',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            : const SizedBox());
  }
}
