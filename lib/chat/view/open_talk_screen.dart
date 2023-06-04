import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/chat/component/new_talk_card.dart';
import 'package:howlook/chat/provider/talk_provider.dart';

class OpenTalkScreen extends ConsumerStatefulWidget {
  const OpenTalkScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OpenTalkScreen> createState() => _OpenTalkScreenState();
}

class _OpenTalkScreenState extends ConsumerState<OpenTalkScreen> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(newTalkProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(newTalkProvider.notifier).getTalkList();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: titleText("대화 중인 오픈톡")),
          const Divider(color: Colors.black45),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: titleText("참여 가능한 오픈톡"),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => FeedDetailScreen(
                    //       postId: pItem.postId,
                    //     ),
                    //   ),
                    // );
                  },
                  child: NewTalkCard.fromModel(model: data[index]),
                );
              },
              separatorBuilder: (_, index) {
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget titleText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: 'NanumSquareNeo',
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
