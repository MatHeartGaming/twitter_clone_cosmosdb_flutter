import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/presentation/common_functions/common_functions.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/screens/screens.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class CommunityView extends ConsumerStatefulWidget {
  static const name = 'CommunityView';

  const CommunityView({super.key});

  @override
  CommunityViewState createState() => CommunityViewState();
}

class CommunityViewState extends ConsumerState<CommunityView> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    Future.delayed(Duration.zero, () async {
      await ref.read(loadPostsProvider.notifier).fetchAllPosts();
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
            itemCount: posts.allPosts.length,
            itemBuilder: (context, index) {
              final post = posts.allPosts[index];
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
