// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:howlook/profile/model/my_profile_screen_model.dart';
// import 'package:howlook/profile/repository/profile_repository.dart';
// import 'package:howlook/common/model/cursor_pagination_model.dart';
//
// // final ProfileProvider =
// //     StateNotifierProvider<ProfileStateNotifier, List<MainProfileModel>>(
// //         (ref) => ProfileStateNotifier());
// //
// // class ProfileStateNotifier extends StateNotifier<List<MainProfileModel>> {
// //   ProfileStateNotifier()
// //       : super(MainProfileModel(
// //             memberId: '',
// //             memberNickName: '',
// //             memberHeight: 0,
// //             memberWeight: 0,
// //             profilePhoto: '',
// //             me: false,
// //             memberPostCount: 0,
// //             memberPosts: []) as List<MainProfileModel>);
// //
// //   void clear() {}
// //
// //   void outputProfileModel() {
// //     // MainProfileModel model = state[0];
// //     // print('Member ID: ${model.memberId}');
// //     // print('Member NickName: ${model.memberNickName}');
// //     // print('memberHeight: ${model.memberHeight}');
// //     // print('memberWeight: ${model.memberWeight}');
// //     // print('profilePhoto: ${model.profilePhoto}');
// //     // print('me: ${model.me}');
// //     // print('memberPostCount: ${model.memberPostCount}');
// //     // print('mainPhotoPath: ${model.memberPosts![0].mainPhotoPath}');
// //     // print('postId: ${model.memberPosts![0].postId}');
// //
// //     state = state.map((e) => MainProfileModel(
// //         memberId: e.memberId,
// //         memberNickName: e.memberNickName,
// //         memberHeight: e.memberHeight,
// //         memberWeight: e.memberWeight,
// //         profilePhoto: e.profilePhoto,
// //         me: e.me,
// //         memberPostCount: e.memberPostCount,
// //         memberPosts: e.memberPosts
// //     )).toList();
// //   }
// // }
//
// final ProfileProvider =
// StateNotifierProvider<ProfileStateNotifier, CursorPaginationBase>(
//       (ref) {
//     final repository = ref.watch((ProfileRepositoryProvider));
//     final notifier = ProfileStateNotifier(repository: repository);
//     return notifier;
//   },
// );
//
// class ProfileStateNotifier extends StateNotifier<CursorPaginationBase> {
//   // API 요청을 위해 repository 가져오기
//   final ProfileRepository repository;
//
//   // 외부에서 API 입력 받기위해 required에 넣기
//   ProfileStateNotifier({
//     required this.repository,
//   }) : super(CursorPaginationLoading()) {}
//
// }
