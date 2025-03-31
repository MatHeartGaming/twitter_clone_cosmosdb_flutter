import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:twitter_cosmos_db/domain/inputs_validations/inputs.dart';
import 'package:twitter_cosmos_db/presentation/providers/auth/auth_status_provider.dart';
import 'package:twitter_cosmos_db/presentation/providers/forms/states/signup_form_state.dart';
import 'package:twitter_cosmos_db/presentation/providers/users_repository/users_repository_provider.dart';

import 'states/form_status.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, SignupFormState>((ref) {
  final loginNotifier = LoginNotifier(ref);
  return loginNotifier;
});

class LoginNotifier extends StateNotifier<SignupFormState> {
  final Ref ref;

  LoginNotifier(this.ref) : super(const SignupFormState());

  Future<void> onSubmit({required VoidCallback onSubmit}) async {
    print('LoginNotifier onSubmit');
    List<FormzInput> fieldsToValidate = [
      state.email,
      state.password,
    ];

    state = state.copyWith(
      status: FormStatus.posting,
      email: Email.dirty(state.email.value),
      password: PasswordText.dirty(state.password.value),
      isValid: Formz.validate(fieldsToValidate),
    );

    if (!state.isValid) return;
    final userRepo = ref.read(usersRepositoryProvider);
    // final authNotifier = ref.read(authStatusProvider.notifier);
    final success = await userRepo.login(
      state.email.value,
      state.password.value,
    );

    if (success == null) {
      final authState = ref.read(authStatusProvider);
      ref.read(authStatusProvider.notifier).state =
          authState.copyWith(authStatus: AuthStatus.authenticated);
    } else {
      state = state.copyWith(
        status: FormStatus.invalid,
        // errorMessage: 'Login failed',
      );
    }
    onSubmit();
  }

  void passwordChanged(String value) {
    final password = PasswordText.dirty(value);
    List<FormzInput> fieldsToValidate = [
      state.email,
      password,
    ];
    state = state.copyWith(
      password: password,
      isValid: Formz.validate(fieldsToValidate),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    List<FormzInput> fieldsToValidate = [
      email,
      state.password,
    ];
    state = state.copyWith(
      email: email,
      isValid: Formz.validate(fieldsToValidate),
    );
  }

  void clearFormState() {
    state = state.copyWith(
      email: const Email.pure(),
      password: const PasswordText.pure(),
    );
  }
}
