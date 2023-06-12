import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/model/cursor_pagination_model.dart';
import '../../component/feed_card.dart';
import '../../provider/feed/category_provider/category_check_provider.dart';
import '../../provider/feed/category_provider/category_feed_provider.dart';
import '../../provider/feed/category_provider/category_provider.dart';
import '../../provider/feed/main_feed_provider.dart';
import '../feed_detail/feed_detail_screen.dart';
import 'category_selected_screen.dart';

class CategoryFeedScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CategoryFeedScreen> createState() => _CategoryFeedScreenState();
}

class _CategoryFeedScreenState extends ConsumerState<CategoryFeedScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void checkCategoryState() {
    final state = ref.read(isFiltering.notifier).state;
    if (state == true) {
      int count = ref.read(categoryProvider.notifier).checkCategoryInitState();
      ref.read(categoryCountProvider.notifier).update((state) => count);
    }
  }

  void scrollListener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      final state = ref.read(isFiltering.notifier).state;
      if (state == true) {
        ref.read(categoryFeedProvider.notifier).paginate(fetchMore: true);
      } else {
        ref.read(mainFeedProvider.notifier).paginate(fetchMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFilter = ref.watch(isFiltering);

    final data = isFilter
        ? ref.watch(categoryFeedProvider)
        : ref.watch(mainFeedProvider);

    final countState = ref.watch(categoryCountProvider);

    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data is CursorPaginationError) {
      return Center(child: Text(data.message));
    }

    final cp = data as CursorPagination;

    List<String> categoryList = ["남", "여", "미니멀", "캐주얼", "스트릿", "아메카지", "스포티"];

    Color checkColor(int index, int sort) {
      final categoryState = ref.watch(categoryProvider);
      Color color;

      if (sort == 0) {
        color = Colors.lightBlueAccent.withOpacity(0.3);
      } else if (sort == 1) {
        color = Colors.white;
      } else {
        color = Colors.blueAccent;
      }

      if ((index == 0 && categoryState.gender == "M") ||
          (index == 1 && categoryState.gender == "F") ||
          (index == 2 && categoryState.hashtagDTOMinimal) ||
          (index == 3 && categoryState.hashtagDTOCasual) ||
          (index == 4 && categoryState.hashtagDTOStreet) ||
          (index == 5 && categoryState.hashtagDTOAmekaji) ||
          (index == 6 && categoryState.hashtagDTOSporty)) {
        return color;
      } else {
        if (sort == 0) {
          return Colors.white;
        } else if (sort == 1) {
          return Colors.black26;
        } else {
          return Colors.black45;
        }
      }
    }

    checkStyle(int index) {
      if (index == 0) {
        final state = ref.watch(categoryProvider);
        // 스타일이 하나라도 선택되어있다면 안되게 막던가 성별을 바꿔야해
        if (ref.read(categoryProvider.notifier).checkCategoryCurrStyleState()) {
          // 현재 성별이 남자라면 클릭 안 되게 막아야함
          if (state.gender == "M") {
            return;
          } else if (state.gender == "F") {
            // 현재 성별이 여자라면 남자로 바꿔야함
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "M");
          }
        } else {
          // 현재 스타일이 하나도 선택되지 않았을 때
          // 현재 성별이 여자로 되어있다면 남자로 바꾸기
          if (state.gender == "F") {
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "M");
          }
          // 현재 성별이 남자로 되어있다면 성별 비우기
          // 일단 숫자 내리고 성별 비우고 필터링된 상태 아니라고 하기
          else if (state.gender == "M") {
            ref
                .read(categoryCountProvider.notifier)
                .update((state) => state - 1);
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "");
            ref.read(isFiltering.notifier).update((state) => false);
          }
          // 성별 아무것도 선택 안 되어있었다면 성별 바꾸고 숫자 올리고 필터링 상태라고 하기
          else {
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "M");
            ref
                .read(categoryCountProvider.notifier)
                .update((state) => state + 1);
            ref.read(isFiltering.notifier).update((state) => true);
          }
        }
      } else if (index == 1) {
        final state = ref.watch(categoryProvider);
        // 스타일이 하나라도 선택되어있다면 안되게 막던가 성별을 바꿔야해
        if (ref.read(categoryProvider.notifier).checkCategoryCurrStyleState()) {
          // 현재 성별이 여자라면 클릭 안 되게 막아야함
          if (state.gender == "F") {
            return;
          } else if (state.gender == "M") {
            // 현재 성별이 남자라면 여자로 바꿔야함
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "F");
          }
        } else {
          // 현재 스타일이 하나도 선택되지 않았을 때
          // 현재 성별이 남자로 되어있다면 여자로 바꾸기
          if (state.gender == "M") {
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "F");
          }
          // 현재 성별이 여자로 되어있다면 성별 비우기
          // 일단 숫자 내리고 성별 비우고 필터링된 상태 아니라고 하기
          else if (state.gender == "F") {
            ref
                .read(categoryCountProvider.notifier)
                .update((state) => state - 1);
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "");
            ref.read(isFiltering.notifier).update((state) => false);
          }
          // 성별 아무것도 선택 안 되어있었다면 성별 바꾸고 숫자 올리고 필터링 상태라고 하기
          else {
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "F");
            ref
                .read(categoryCountProvider.notifier)
                .update((state) => state + 1);
            ref.read(isFiltering.notifier).update((state) => true);
          }
        }
      } else if (index == 2) {
        final state = ref.watch(categoryProvider);
        if (state.gender == "") {
          return;
        }
        // 해당 스타일 값 반대로 바꿈
        ref
            .read(categoryProvider.notifier)
            .toggleStyleSelected(style: "Minimal");

        // 바뀐 상태를 통해 숫자 업데이트
        final state2 = ref.watch(categoryProvider);
        state2.hashtagDTOMinimal
            ? ref
                .read(categoryCountProvider.notifier)
                .update((state) => state + 1) // false 인 경우
            : ref
                .read(categoryCountProvider.notifier)
                .update((state) => state - 1); // true 인 경우

        // 현재 다른 값이 선택 안 되어있으면 isFiltering false로 선택
        if (ref.read(categoryProvider.notifier).checkCategoryCurrStyleState()) {
          ref.read(isFiltering.notifier).update((state) => true);
        } else {
          if (ref
              .read(categoryProvider.notifier)
              .checkCategoryCurrGenderState()) {
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "");
            ref.read(categoryCountProvider.notifier).update((state) => 0);
            ref.read(isFiltering.notifier).update((state) => false);
          } else {
            ref.read(isFiltering.notifier).update((state) => true);
          }
        }
      } else if (index == 3) {
        final state = ref.watch(categoryProvider);
        if (state.gender == "") {
          return;
        }
        ref
            .read(categoryProvider.notifier)
            .toggleStyleSelected(style: "Casual");
        final state2 = ref.watch(categoryProvider);
        state2.hashtagDTOCasual
            ? ref
                .read(categoryCountProvider.notifier)
                .update((state) => state + 1) // false 인 경우
            : ref
                .read(categoryCountProvider.notifier)
                .update((state) => state - 1); // true 인 경우

        // 현재 다른 값이 선택 안 되어있으면 isFiltering false로 선택
        if (ref.read(categoryProvider.notifier).checkCategoryCurrStyleState()) {
          ref.read(isFiltering.notifier).update((state) => true);
        } else {
          if (ref
              .read(categoryProvider.notifier)
              .checkCategoryCurrGenderState()) {
            ref
                .read(categoryProvider.notifier)
                .toggleGenderSelected(gender: "");
            ref.read(categoryCountProvider.notifier).update((state) => 0);
            ref.read(isFiltering.notifier).update((state) => false);
          } else {
            ref.read(isFiltering.notifier).update((state) => true);
          }
        }
      } else if (index == 4) {
        final state = ref.watch(categoryProvider);
        if (state.gender == "") {
          return;
        }
        ref
            .read(categoryProvider.notifier)
            .toggleStyleSelected(style: "Street");
        final state2 = ref.watch(categoryProvider);
        state2.hashtagDTOStreet
            ? ref
                .read(categoryCountProvider.notifier)
                .update((state) => state + 1) // false 인 경우
            : ref
                .read(categoryCountProvider.notifier)
                .update((state) => state - 1); // true 인 경우
        // 현재 다른 값이 선택 안 되어있으면 isFiltering false로 선택
        ref.read(categoryProvider.notifier).checkCategoryCurrStyleState()
            ? ref.read(isFiltering.notifier).update((state) => true)
            : ref.read(categoryProvider.notifier).checkCategoryCurrGenderState()
                ? ref.read(isFiltering.notifier).update((state) => false)
                : ref.read(isFiltering.notifier).update((state) => true);
      } else if (index == 5) {
        final state = ref.watch(categoryProvider);
        if (state.gender == "") {
          return;
        }
        ref
            .read(categoryProvider.notifier)
            .toggleStyleSelected(style: "AmericanCasual");
        final state2 = ref.watch(categoryProvider);
        state2.hashtagDTOAmekaji
            ? ref
                .read(categoryCountProvider.notifier)
                .update((state) => state + 1) // false 인 경우
            : ref
                .read(categoryCountProvider.notifier)
                .update((state) => state - 1); // true 인 경우
        // 현재 다른 값이 선택 안 되어있으면 isFiltering false로 선택
        ref.read(categoryProvider.notifier).checkCategoryCurrStyleState()
            ? ref.read(isFiltering.notifier).update((state) => true)
            : ref.read(categoryProvider.notifier).checkCategoryCurrGenderState()
                ? ref.read(isFiltering.notifier).update((state) => false)
                : ref.read(isFiltering.notifier).update((state) => true);
      } else if (index == 6) {
        final state = ref.watch(categoryProvider);
        if (state.gender == "") {
          return;
        }
        ref
            .read(categoryProvider.notifier)
            .toggleStyleSelected(style: "Sporty");
        final state2 = ref.watch(categoryProvider);
        state2.hashtagDTOSporty
            ? ref
                .read(categoryCountProvider.notifier)
                .update((state) => state + 1) // false 인 경우
            : ref
                .read(categoryCountProvider.notifier)
                .update((state) => state - 1); // true 인 경우
        // 현재 다른 값이 선택 안 되어있으면 isFiltering false로 선택
        ref.read(categoryProvider.notifier).checkCategoryCurrStyleState()
            ? ref.read(isFiltering.notifier).update((state) => true)
            : ref.read(categoryProvider.notifier).checkCategoryCurrGenderState()
                ? ref.read(isFiltering.notifier).update((state) => false)
                : ref.read(isFiltering.notifier).update((state) => true);
      } else {}
    }

    return RefreshIndicator(
      onRefresh: () async {
        isFilter
            ? ref
                .read(categoryFeedProvider.notifier)
                .paginate(forceRefetch: true)
            : ref.read(mainFeedProvider.notifier).paginate(forceRefetch: true);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: isFilter ? 60 : 40,
                  height: 40,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 5,
                        left: 8,
                        child: Container(
                          width: isFilter ? 50 : 32,
                          height: 30,
                          decoration: BoxDecoration(
                            color: isFilter
                                ? Colors.lightBlueAccent.withOpacity(0.3)
                                : null,
                            border: Border.all(
                              width: 0.5,
                              color: isFilter ? Colors.white : Colors.black26,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: isFilter
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    bottom: 3.5,
                                  ),
                                  child: Center(
                                    child: Text(
                                      countState.toString(),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
                      Positioned(
                        top: -4.5,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CategorySelectScreen(),
                              ),
                            );
                          },
                          icon: isFilter
                              ? const Icon(Icons.tune,
                                  size: 18, color: Colors.blueAccent)
                              : const Icon(Icons.tune, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                isFilter ? const SizedBox(width: 3) : const SizedBox(width: 5),
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  checkStyle(index);
                                },
                                child: Container(
                                  width:
                                      categoryList[index].length < 3 ? 30 : 55,
                                  decoration: BoxDecoration(
                                    color: checkColor(index, 0),
                                    border: Border.all(
                                      width: 0.5,
                                      color: checkColor(index, 1),
                                      style: BorderStyle.solid,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      categoryList[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900,
                                        color: checkColor(index, 2),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(width: 6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              controller: controller,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cp.data.content.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == cp.data.content.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Center(
                      child: data is CursorPaginationFetchingMore
                          ? const CircularProgressIndicator()
                          : const Text('마지막 데이터입니다. ㅠㅠ'),
                    ),
                  );
                }
                // 받아온 데이터 JSON 매핑하기
                // 모델 사용
                final pItem = cp.data.content[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FeedDetailScreen(
                          postId: pItem.postId,
                        ),
                      ),
                    );
                  },
                  child: FeedCard.fromModel(model: pItem),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
