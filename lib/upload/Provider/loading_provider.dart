import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/upload/model/upload_formdata_model.dart';

final loadingIndicatorProvider = StateProvider<bool>((ref) => false);

final newPostInfoProvider =
    StateNotifierProvider<NewPostInfoStateNotifier, PostInfo>(
        (ref) => NewPostInfoStateNotifier());

class NewPostInfoStateNotifier extends StateNotifier<PostInfo> {
  NewPostInfoStateNotifier()
      : super(PostInfo(
          loadingIndicator: false,
          uploadModel: UploadModel(),
        ),);
}

class PostInfo {
  bool? loadingIndicator = false;
  late UploadModel uploadModel;

  PostInfo({
    required this.loadingIndicator,
    required this.uploadModel,
  });
}
