import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_cosmos_db/config/constants/app_constants.dart';
import 'package:twitter_cosmos_db/presentation/navigation/navigation_functions.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class LoginScreen extends ConsumerWidget {
  static String name = 'LoginScreen';
  static const String homePath = '/home'; // Define the homePath constant

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = ref.watch(showPasswordProvider);
    final authStatusNotifier = ref.watch(authStatusProvider);
    final loginFormState = ref.watch(loginFormProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("login_screen_login_title").tr(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton.filledTonal(
                  tooltip: ("login_screen_login_title").tr(),
                  onPressed: () =>
                      authStatusNotifier.authStatus == AuthStatus.checking
                          ? null
                          : _loginUsingPassword(context, ref),
                  icon: const Icon(Icons.check_circle_outline_outlined)),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    CustomTextFormField(
                      initialValue: "",
                      autoFillHints: const [AutofillHints.email],
                      label: "login_screen_email_text".tr(),
                      formatter: FormInputFormatters.email,
                      errorMessage: loginFormState.isPosting
                          ? loginFormState.email.errorMessage
                          : null,
                      icon: Icons.email_outlined,
                      onChanged: (newValue) {
                        final loginFormState =
                            ref.read(loginFormProvider.notifier);
                        loginFormState.emailChanged(newValue);
                      },
                      onSubmitForm: () =>
                          _submitFormAction(context, authStatusNotifier, ref),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      initialValue: "",
                      autoFillHints: const [AutofillHints.newPassword],
                      label: "login_screen_password_text".tr(),
                      trailingIcon: IconButton(
                          onPressed: () {
                            ref.read(showPasswordProvider.notifier).state =
                                !showPassword;
                          },
                          icon: _showHidePasswordIcon(showPassword)),
                      errorMessage: loginFormState.isPosting
                          ? loginFormState.password.errorMessage
                          : null,
                      icon: Icons.lock,
                      obscureText: !showPassword,
                      onChanged: (newValue) {
                        final loginFormState =
                            ref.read(loginFormProvider.notifier);
                        loginFormState.passwordChanged(newValue);
                      },
                      onSubmitForm: () =>
                          _submitFormAction(context, authStatusNotifier, ref),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("login_screen_dont_have_account_text").tr(),
                        const SizedBox(
                          width: 2,
                        ),
                        TextButton(
                            onPressed: () {
                              ref.read(showLoginSignupProvider.notifier).update(
                                    (state) => !state,
                                  );
                            },
                            child: const Text(
                                    "login_screen_signup_title_with_args")
                                .tr(args: ["!"])),
                      ],
                    ),
                    //_authMethodsRow(context, ref),
                    const SizedBox(
                      height: 20,
                    ),
                    FilledButton.tonal(
                        onPressed: () =>
                            _submitFormAction(context, authStatusNotifier, ref),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("login_screen_login_title").tr(),
                            const SizedBox(
                              width: 6,
                            ),
                            ZoomIn(
                                child: const Icon(
                                    Icons.check_circle_outline_outlined))
                          ],
                        )),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _showHidePasswordIcon(bool showPassword) {
    return Stack(
      children: [
        Icon(showPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
      ],
    );
  }

  Future<void> _loginUsingPassword(BuildContext context, WidgetRef ref) async {
    final signupFormState = ref.read(loginFormProvider);
    final userRepo = ref.read(usersRepositoryProvider);
    final success = await userRepo.login(
      signupFormState.email.value,
      signupFormState.password.value,
    );
    if (success == null) {
      logger.e('Login Failed');
    } else {
      logger.i("login success auth state");
      final user = await userRepo.getUserByEmail(signupFormState.email.value);
      if (!context.mounted) return;
      ref.read(signedInUserProvider.notifier).update((state) => user);
      gotoHomeScreenNavigation(ref.context);
    }
  }

  Future<void>? _submitFormAction(
      BuildContext context, AuthState authStatusNotifier, WidgetRef ref) {
    return authStatusNotifier.authStatus == AuthStatus.checking
        ? null
        : _loginUsingPassword(context, ref);
  }
}
