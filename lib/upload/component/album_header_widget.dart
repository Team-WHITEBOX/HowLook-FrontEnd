import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howlook/upload/Provider/upload_provider.dart';

class AlbumHeader extends ConsumerStatefulWidget {
  const AlbumHeader({Key? key}) : super(key: key);

  @override
  ConsumerState<AlbumHeader> createState() => _AlbumHeaderState();
}

class _AlbumHeaderState extends ConsumerState<AlbumHeader> {

  Future<String> _name() async {
    String name = ref.read(GetImageProvider.notifier).currentAlbum!.name;
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final stateRead = ref.read(GetImageProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                isScrollControlled: stateRead.albums.length > 10 ? true : false,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top),
                builder: (BuildContext context) => SizedBox(
                  height: stateRead.albums.length * 50,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black54,
                          ),
                          width: 40,
                          height: 4,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                              stateRead.albums.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    stateRead.getPhotos(
                                      stateRead.albums[index],
                                      albumChange: true,
                                    );
                                  });

                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Text(stateRead.albums[index].name),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  FutureBuilder(
                    future: _name(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData == false) {
                        return const Text("모든 사진");
                      } else {
                        return Text(
                          stateRead.currentAlbum!.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        );
                      }
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
