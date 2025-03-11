import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_cosmos_db/domain/models/models.dart';
import 'package:twitter_cosmos_db/presentation/providers/providers.dart';
import 'package:twitter_cosmos_db/presentation/widgets/widgets.dart';

class SignupScreen extends ConsumerWidget {
  static String name = 'SignupScreen';

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = ref.watch(showPasswordProvider);
    final showRepeatPassword = ref.watch(showRepeatPasswordProvider);
    final authStatusNotifier = ref.watch(authStatusProvider);
    final signupFormState = ref.watch(signupFormProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("login_screen_signup_title").tr(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton.filledTonal(
                tooltip: ("login_screen_signup_title").tr(),
                onPressed: () => _submitFormAction(authStatusNotifier, ref),
                icon: const Icon(Icons.check_circle_outline_outlined),
              ),
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
                  const SizedBox(height: 50),
                  CustomTextFormField(
                    initialValue: "",
                    autoFillHints: const [AutofillHints.name],
                    label: "login_screen_name_text".tr(),
                    formatter: FormInputFormatters.text,
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.name.errorMessage
                            : null,
                    icon: Icons.person,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.nameChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    autoFillHints: const [AutofillHints.familyName],
                    label: "login_screen_surname_text".tr(),
                    formatter: FormInputFormatters.text,
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.surname.errorMessage
                            : null,
                    icon: Icons.person,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.surnameChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    autoFillHints: const [AutofillHints.email],
                    label: "login_screen_email_text".tr(),
                    formatter: FormInputFormatters.email,
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.email.errorMessage
                            : null,
                    icon: Icons.email_outlined,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.emailChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    autoFillHints: const [AutofillHints.newPassword],
                    label: "login_screen_password_text".tr(),
                    trailingIcon: IconButton(
                      onPressed: () {
                        ref.read(showPasswordProvider.notifier).state =
                            !showPassword;
                      },
                      icon: showHidePasswordIcon(showPassword),
                    ),
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.password.errorMessage
                            : null,
                    icon: Icons.lock,
                    obscureText: !showPassword,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.passwordChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    initialValue: "",
                    label: "login_screen_repeat_password_text".tr(),
                    trailingIcon: IconButton(
                      onPressed: () {
                        ref.read(showRepeatPasswordProvider.notifier).state =
                            !showRepeatPassword;
                      },
                      icon: showHidePasswordIcon(showRepeatPassword),
                    ),
                    errorMessage:
                        signupFormState.isPosting
                            ? signupFormState.repeatPassword.errorMessage
                            : null,
                    icon: Icons.lock,
                    obscureText: !showRepeatPassword,
                    onChanged: (newValue) {
                      final signupFormState = ref.read(
                        signupFormProvider.notifier,
                      );
                      signupFormState.repeatPasswordChanged(newValue);
                    },
                    onSubmitForm:
                        () => _submitFormAction(authStatusNotifier, ref),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("login_screen_have_account_text").tr(),
                      const SizedBox(width: 2),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(showLoginSignupProvider.notifier)
                              .update((state) => !state);
                        },
                        child: const Text(
                          "login_screen_login_title_with_args",
                        ).tr(args: ["!"]),
                      ),
                    ],
                  ),
                  //_authMethodsRow(ref),
                  const SizedBox(height: 20),
                  FilledButton.tonal(
                    onPressed: () => _submitFormAction(authStatusNotifier, ref),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("login_screen_signup_title").tr(),
                        const SizedBox(width: 6),
                        ZoomIn(
                          child: const Icon(
                            Icons.check_circle_outline_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void>? _submitFormAction(AuthState authStatusNotifier, WidgetRef ref) {
    return authStatusNotifier.authStatus == AuthStatus.checking
        ? null
        : _signupUsingPassword(ref);
  }

  Future<void> _signupUsingPassword(WidgetRef ref) async {
    /*final appConfigs = ref.read(appConfigsProvider).configs;
    final signupFormNotifier = ref.read(signupFormProvider.notifier);
    final signupFormState = ref.read(signupFormProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final authStatusNotifier = ref.read(authStatusProvider.notifier);
    final colors = Theme.of(ref.context).colorScheme;
    signupFormNotifier.onSubmit(
      allowNonVatUserSignup: appConfigs.allowSignupForNonVatUsers,
      onPasswordMismatch: () {
        showCustomSnackbar(
            ref.context, 'login_screen_password_mismatch_snackbar_text'.tr(),
            backgroundColor: Colors.yellow[300], textColor: Colors.black);
      },
      onSubmit: () async {
        await authStatusNotifier.signupUsingPassword(
            signupFormState.email.value, signupFormState.password.value,
            onEmailAlreadyExists: () {
          showCustomSnackbar(
              ref.context,
              'login_screen_email_already_exists_snackbar'
                  .tr(args: [signupFormState.email.value]),
              backgroundColor: colors.error);
        }).then(
          (userCredential) async {
            final user = User(
              nome: signupFormState.name.value,
              cognome: signupFormState.surname.value,
              email: signupFormState.email.value,
              pIva: signupFormState.vatNumber.value,
              companyName: signupFormState.companyName.value,
              phoneNumber: signupFormState.phoneNumber.isValid
                  ? signupFormState.phoneNumber.value
                  : null,
            );
            final uid = userCredential?.user?.uid;
            if (uid == null) return;
            await userRepository.createUser(user, uid).then(
              (value) async {
                _updateSignedInUserProvider(ref, user);
                //if (!ref.context.mounted) return;
                //ref.context.pop();
                final authPasswordProvider =
                    ref.read(authPasswordRepositoryProvider);
                final isEmailVerified =
                    await authPasswordProvider.isUserEmailVerified();
                if (!isEmailVerified && ref.context.mounted) {
                  ref.context.go(verifyEmailPath, extra: {'newUser': value});
                }
              },
            );

            logger.i('Singup with Password! $user');
          },
        );
      },
    );*/
  }

  void _updateSignedInUserProvider(WidgetRef ref, User user) {
    ref.read(signedInUserProvider.notifier).update((state) => user);
  }
}
