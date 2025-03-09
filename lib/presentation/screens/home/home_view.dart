import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  static const name = 'HomeView';

  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: addPostFab(),
        appBar: PreferredSize(
          preferredSize: Size(size.width, 50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HomeAppBar(
              onProfileIconPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: 10,
          prototypeItem: PostWidget(post: Post.empty()),
          itemBuilder: (context, index) {
            return PostWidget(
              post: Post(userId: 'MatBuompy', body: 'This is an example Post $index'),
            );
          },
        ),
      ),
    );
  }

  Widget addPostFab() {
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.add),
      color: Colors.white,
      style: const ButtonStyle().copyWith(
        backgroundColor: WidgetStatePropertyAll(Colors.blue),
        minimumSize: WidgetStatePropertyAll(Size(50, 50)),
      ),
    );
  }
}
