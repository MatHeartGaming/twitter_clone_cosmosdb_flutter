import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final int pageIndex;
  final Widget homeView;
  final Widget searchView;
  final Widget communityView;
  final Widget notificationView;
  final Widget messagesView;

  static const name = 'HomeScreen';

  const HomeScreen({
    super.key,
    required this.pageIndex,
    required this.homeView,
    required this.searchView,
    required this.communityView,
    required this.notificationView,
    required this.messagesView,
  });

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> viewRoutes = [
      widget.homeView,
      widget.searchView,
      widget.communityView,
      widget.notificationView,
      widget.messagesView,
    ];
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawer: DrawerContent(
        user: User.empty(
          nome: 'Matteo',
          cognome: 'Buompastore',
          username: '@MatBuompy',
          dateCreated: DateTime.now(),
        ),
      ),
      body: IndexedStack(index: widget.pageIndex, children: viewRoutes),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: widget.pageIndex,
      ),
    );
  }
}
