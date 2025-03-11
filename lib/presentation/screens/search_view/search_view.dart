import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/widgets/shared/search_user_row.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchBarState = ref.watch(searchSreenSearchBarProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CustomTextFormField(
                controller: searchBarState.searchTextController,
                label: 'home_screen_search_bar_placeholder'.tr(),
                icon: FontAwesomeIcons.magnifyingGlass,
                trailingIcon: IconButton(
                  onPressed: () {
                    final productListSearchNotifier = ref.read(
                      searchSreenSearchBarProvider.notifier,
                    );
                    productListSearchNotifier.clearSearchText();
                    productListSearchNotifier.searchProductsBy();
                  },
                  icon: const Icon(FontAwesomeIcons.xmark),
                ),
                onChanged: (newValue) {
                  final productListSearchNotifier = ref.read(
                    searchSreenSearchBarProvider.notifier,
                  );
                  productListSearchNotifier.onSearchTextChange(newValue);
                  productListSearchNotifier.searchProductsBy();
                },
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemCount: searchBarState.searchedUsers.length,
                  prototypeItem: SizedBox(
                    height: 70,
                    child: SearchUserRow(
                      user: User.empty(dateCreated: DateTime.now()),
                    ),
                  ),
                  itemBuilder: (context, index) {
                    final user = searchBarState.searchedUsers[index];
                    return FadeIn(
                      duration: Duration(milliseconds: 300),
                      child: SearchUserRow(user: user),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
