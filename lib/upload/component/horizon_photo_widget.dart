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
    final selectedState = ref.watch(SelectedImageProvider);
    final selectedStateRead = ref.read(SelectedImageProvider.notifier);

    return SizedBox(
      height: 120,
      child: ListView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: selectedState
            .map(
              (e) => Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: 100,
                    height: 100,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStateRead.selectImageForEdited(e.image);
                      });
                    },
                    child: Align(
                      alignment: Alignment.center,
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
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
