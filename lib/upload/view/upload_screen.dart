// import 'dart:typed_data';
// import 'package:drag_select_grid_view/drag_select_grid_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:howlook/common/layout/default_layout.dart';
// import 'package:howlook/upload/Provider/upload_provider.dart';
// import 'package:howlook/upload/component/album_header_widget.dart';
// import 'package:howlook/upload/component/selectable_item.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
//
// class ImageUploadScreen extends ConsumerStatefulWidget {
//   const ImageUploadScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<ImageUploadScreen> createState() => _ImageUploadScreenState();
// }
//
// class _ImageUploadScreenState extends ConsumerState<ImageUploadScreen> {
//   var albums = <AssetPathEntity>[];
//   var imageList = <AssetEntity>[];
//   var headerTitle = '';
//   AssetEntity? selectedImage;
//   // Gridview Controller
//   final controller = DragSelectGridViewController();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(scheduleRebuild);
//   }
//
//   @override
//   void dispose() {
//     controller.removeListener(scheduleRebuild);
//     super.dispose();
//   }
//
//   void scheduleRebuild() => setState(() {});
//
//   Widget _imagePreview(List<AssetEntity> state) {
//     var width = MediaQuery.of(context).size.width;
//     return Container(
//       width: width,
//       height: width,
//       color: Colors.black,
//       child: ClipRect(
//         child: PhotoViewGallery.builder(
//           scrollPhysics: const BouncingScrollPhysics(),
//           builder: (BuildContext context, int index) {
//             return PhotoViewGalleryPageOptions(
//               imageProvider: AssetEntityImageProvider(state[index]),
//               initialScale: PhotoViewComputedScale.contained * 0.8,
//               heroAttributes: PhotoViewHeroAttributes(tag: state[index].id),
//               maxScale: PhotoViewComputedScale.covered * 2.0,
//               minScale: PhotoViewComputedScale.contained * 1.0,
//               filterQuality: FilterQuality.high,
//             );
//           },
//           itemCount: state.length,
//           backgroundDecoration: BoxDecoration(color: Colors.black),
//
//           // 여기는 기본 옵션
//           // imageProvider: AssetEntityImageProvider(state),
//           // backgroundDecoration: BoxDecoration(color: Colors.black),
//           // maxScale: PhotoViewComputedScale.covered * 2.0,
//           // minScale: PhotoViewComputedScale.contained * 1.0,
//           // initialScale: PhotoViewComputedScale.contained,
//         ),
//       ),
//     );
//   }
//
//   Widget _imageSelectList() {
//     final stateRead = ref.read(SelectedImageProvider.notifier);
//     return DragSelectGridView(
//       gridController: controller,
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         childAspectRatio: 1,
//         mainAxisSpacing: 1,
//         crossAxisSpacing: 1,
//       ),
//       itemCount: stateRead.imageList.length,
//       itemBuilder: (BuildContext context, int index, bool selected) {
//         return SelectableItem(
//           index: index,
//           color: Colors.brown,
//           selected: selected,
//           photoWidget: _photoWidget(
//             stateRead.imageList[index],
//             200,
//             builder: (data) {
//               return GestureDetector(
//                 onTap: () {
//                   // stateRead.changeSelectedImage(stateRead.imageList[index]);
//                 },
//                 child: Opacity(
//                   opacity:
//                       stateRead.imageList[index] == stateRead.state ? 0.3 : 1,
//                   child: Image.memory(
//                     data,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _photoWidget(AssetEntity asset, int size,
//       {required Widget Function(Uint8List) builder}) {
//     return FutureBuilder(
//       future: asset.thumbnailDataWithSize(ThumbnailSize(size, size)),
//       builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
//         if (snapshot.hasData) {
//           return builder(snapshot.data!);
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(SelectedImageProvider);
//
//     return DefaultLayout(
//       title: "New Post",
//       leading: GestureDetector(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         child: const Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Icon(Icons.close),
//         ),
//       ),
//       backgroundColor: Colors.black,
//       appBarBackgroundColor: Colors.black,
//       appBarForegroundColor: Colors.white,
//       actions: [
//         GestureDetector(
//           onTap: () async {
//             ref.read(SelectedImageProvider.notifier).gotoImageEdited();
//           },
//           child: const Padding(
//             padding: EdgeInsets.all(15.0),
//             child: Icon(Icons.upload_file),
//           ),
//         ),
//       ],
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             _imagePreview(state),
//             AlbumHeader(),
//             _imageSelectList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
