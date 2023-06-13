import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../component/report_card.dart';
import '../model/manager_pagination_model.dart';
import '../provider/manager_feed_provider.dart';

class ManagerHomeScreen extends ConsumerStatefulWidget {
  const ManagerHomeScreen({super.key});

  @override
  ConsumerState<ManagerHomeScreen> createState() => _ManagerHomeScreenState();
}

class _ManagerHomeScreenState extends ConsumerState<ManagerHomeScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(managerFeedProvider.notifier).paginate(fetchMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(managerFeedProvider);

    if (data is ManagerPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (data is ManagerPaginationError) {
      return Center(child: Text(data.message));
    }

    final cp = data as ManagerPagination;
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.separated(
        controller: controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cp.content.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == cp.content.length) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Center(
                child: data is ManagerPaginationFetchingMore
                    ? const CircularProgressIndicator()
                    : const Text(''),
              ),
            );
          }
          final pItem = cp.content[index];
          if (pItem.post == null) {
            return Container();
          }
          return GestureDetector(
              onTap: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) => ReportCard(),
                //   ),
                // );
              },
              child: ReportCard.fromModel(model: pItem));
        },
        separatorBuilder: (_, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
