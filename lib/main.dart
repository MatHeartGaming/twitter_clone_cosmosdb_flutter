import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_cosmos_db/config/locale/supported_localisations.dart';
import 'package:twitter_cosmos_db/config/plugins/plugins.dart';
import 'package:twitter_cosmos_db/config/router/app_router.dart';

import 'presentation/providers/providers.dart';

Future<void> main() async {
  await _initialConfigs();
  runApp(
    EasyLocalization(
      supportedLocales: supportedLocalisations,
      path: 'assets/translations',
      fallbackLocale: fallbackLocale,
      child: const ProviderScope(child: MainApp()),
    ),
  );
}

Future<void> _initialConfigs() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusSingleton.getInstance().initialize();
  await SharedPrefsPlugin.init();
  await EasyLocalization.ensureInitialized();
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _updateSignedInUserProvider();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(appStateProvider.notifier).state = state;
    if (state == AppLifecycleState.resumed) {}
    super.didChangeAppLifecycleState(state);
  }

  void _updateSignedInUserProvider() {
    /*final signedInUser = ref.read(signedInUserProvider);
    final signeInUserEmail =
        ref.read(authPasswordRepositoryProvider).signedInUserEmail;
    final userRepo = ref.read(userRepositoryProvider);
    if (signeInUserEmail.isNotEmpty && signedInUser == null) {
      userRepo.getUserByEmail(email: signeInUserEmail).then(
        (user) {
          if (user != null) {
            ref.read(signedInUserProvider.notifier).update(
              (state) {
                return user;
              },
            );
          }
        },
      );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeNotifierProvider);
    final appLanguage = ref.watch(localeProvider);
    final appRouterProvider = ref.watch(goRouterProvider);

    ref.listen(connectivityStreamProvider, (
      isConnectedPrevious,
      isConnectedNext,
    ) {
      ref.read(connectivityProvider.notifier).update((state) {
        state = isConnectedNext.value ?? true;
        return state;
      });
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale:
          appLanguage!.localeCode.isEmpty
              ? context.locale
              : Locale(appLanguage.localeCode),
      theme: appTheme.getTheme(isDarkMode: appTheme.isDarkMode),
      routerConfig: appRouterProvider,
    );
  }
}
