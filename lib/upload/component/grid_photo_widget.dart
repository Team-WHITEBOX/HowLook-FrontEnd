import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/upload/Provider/select_photo_provider.dart';
import 'package:howlook/upload/Provider/upload_provider.dart';
import 'package:howlook/upload/model/select_image_model.dart';
import 'package:photo_manager/photo_manager.dart';

class GridPhotoItemWidget extends ConsumerStatefulWidget {
  final AssetEntity e;
  const GridPhotoItemWidget({Key? key, required this.e}) : super(key: key);

  @override
  ConsumerState<GridPhotoItemWidget> createState() =>
      _GridPhotoItemWidgetState();
}

class _GridPhotoItemWidgetState extends ConsumerState<GridPhotoItemWidget> {
  void _selectImage(AssetEntity e) {
    ref.read(SelectedImageProvider.notifier).selectImage(e);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectImage(widget.e);
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
    final isSelected = ref
        .read(SelectedImageProvider.notifier)
        .state
        .any((element) => element.image == e);
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black38 : Colors.transparent,
          // border: Border.all(
          //   color: isSelected ? Colors.lightBlue : Colors.transparent,
          //   width: 5,
          // ),
        ),
      ),
    );
  }

  Widget _selectNumberContainer(AssetEntity e) {
    final num = ref
            .read(SelectedImageProvider.notifier)
            .state
            .indexWhere((element) => element.image == e) +
        1;
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
