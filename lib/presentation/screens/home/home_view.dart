import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/presentation/common_functions/common_functions.dart';
import 'package:twitter_cosmos_db/presentation/providers/posts_repository/load_posts_provider.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  static const name = 'HomeView';

  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    Future.delayed(Duration.zero, () async {
      await ref
          .read(loadPostsProvider.notifier)
          .fetchAllSignedInuserPosts(username: 'FernandoH');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final posts = ref.watch(loadPostsProvider);
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
        body: RefreshIndicator(
          onRefresh: () => _loadData(),
          child: ListView.builder(
            itemCount: posts.allSignedInUserPosts.length,
            //prototypeItem: PostWidget(post: Post.empty()),
            itemBuilder: (context, index) {
              final post = posts.allSignedInUserPosts[index];
              return PostWidget(
                onLikeTapped: () => onLikeTappedAction(post, ref),
                post: post,
              );
            },
          ),
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
