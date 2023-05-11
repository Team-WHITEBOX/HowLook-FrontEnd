import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/upload/Provider/select_photo_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class HorizonPhoto extends ConsumerStatefulWidget {
  HorizonPhoto({Key? key}) : super(key: key);

  @override
  ConsumerState<HorizonPhoto> createState() => _HorizonPhotoState();
}

class _HorizonPhotoState extends ConsumerState<HorizonPhoto> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final selectedState = ref.watch(selectedImageProvider);
    final selectedStateRead = ref.read(selectedImageProvider.notifier);

    return SizedBox(
      height: 125,
      width: MediaQuery.of(context).size.width - 30,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.horizontal,
        children: selectedState
            .map(
              (e) => Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: 90,
                    height: 90,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStateRead.selectImageForEdited(e.image);
                      });
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: AssetEntityImage(
                                e.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        _dimContainer(e.image),
                      ],
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _dimContainer(AssetEntity e) {
    final selectedState = ref.watch(selectedImageProvider);
    final isSelected =
        selectedState.any((element) => element.image == e && element.isEdited);

    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black54 : Colors.transparent,
        ),
      ),
    );
  }
}
