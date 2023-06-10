import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/feed/view/reply/reply_screen.dart';

import '../../../common/const/data.dart';
import '../../../common/layout/default_layout.dart';
import '../../model/reply_params/post_reply_params.dart';
import '../../provider/feed/main_feed_provider.dart';
import '../../provider/reply/reply_provider.dart';
import '../../repository/reply_repository.dart';

class ReplyHomeScreen extends ConsumerStatefulWidget {
  final int postId;
  final String profilePhoto;

  const ReplyHomeScreen({
    required this.postId,
    required this.profilePhoto,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ReplyHomeScreen> createState() => _ReplyHomeScreenState();
}

class _ReplyHomeScreenState extends ConsumerState<ReplyHomeScreen> {
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();

  clearTextField() {
    _formKey.currentState?.reset();
  }

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String content = ref.watch(replyContentProvider);

    bool isValid() {
      return content.isNotEmpty ? true : false;
    }

    postReply() async {
      PostReplyParams postReplyParams = PostReplyParams(
        content: content,
        postId: widget.postId,
      );

      final code = await ref
          .read(replyRepositoryProvider)
          .postReply(postReplyParams: postReplyParams);

      if (code.response.statusCode == 200) {
        clearTextField();
        ref.read(replyContentProvider.notifier).update((state) => "");
        ref
            .read(replyProvider(widget.postId).notifier)
            .paginate(postId: widget.postId, forceRefetch: true);
      }
    }

    return DefaultLayout(
      title: '댓글',
      leading: IconButton(
        onPressed: () {
          ref.read(mainFeedProvider.notifier).getDetail(postId: widget.postId);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 18.0,
                    backgroundImage: widget.profilePhoto != NULL_IMG_URI
                        ? ExtendedImage.network(
                            widget.profilePhoto,
                            fit: BoxFit.cover,
                            cache: true,
                          ).image
                        : ExtendedImage.asset(
                                "asset/img/Profile/BaseProfile.JPG")
                            .image,
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: TextFormField(
                      key: _formKey,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      minLines: 1,
                      onChanged: (text) {
                        ref
                            .read(replyContentProvider.notifier)
                            .update((state) => text);
                      },
                      style: const TextStyle(decorationThickness: 0),
                      decoration: InputDecoration(
                        hintText: "댓글을 입력해주세요",
                        filled: true,
                        fillColor: const Color(0xffEDF0F3),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffEDF0F3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: IconButton(
                      onPressed: () {
                        isValid() ? postReply() : null;
                      },
                      icon: Icon(
                        Icons.send,
                        color: isValid() ? Colors.black : Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(color: Colors.black12),
          Expanded(child: ReplyScreen(postId: widget.postId)),
        ],
      ),
    );
  }
}
