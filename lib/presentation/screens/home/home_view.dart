import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/presentation/common_functions/common_functions.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/screens/screens.dart';
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
      final signedInUser = ref.read(signedInUserProvider);
      await ref
          .read(loadPostsProvider.notifier)
          .fetchAllSignedInuserPosts(username: signedInUser?.username ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final posts = ref.watch(loadPostsProvider);
    final signedInUser = ref.watch(signedInUserProvider);
    return SafeArea(
      child: Scaffold(
        floatingActionButton:
            signedInUser != null
                ? addPostFab(onPressed: () => _showAddPostSheet())
                : null,
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
                onImageTapped:
                    () => onImageTapped(context, post.urlImage ?? ''),
                post: post,
              );
            },
          ),
        ),
      ),
    );
  }

  void _showAddPostSheet() {
    showCustomBottomSheet(context, child: AddPostScreen());
  }
}
