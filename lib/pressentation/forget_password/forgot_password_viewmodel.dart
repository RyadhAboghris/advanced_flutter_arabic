import 'dart:async';

import 'package:advanced_flutter_arabic/domain/usecase/base_usecase.dart';
import 'package:advanced_flutter_arabic/pressentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/pressentation/common/state_renderer/state_renderer.dart';

import '../../domain/usecase/forgot_password_usecase.dart';
import '../common/state_renderer/state_renderer_impl.dart';
import 'functions.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _isAllInputValidStreamController =
      StreamController<String>.broadcast();

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = '';

// input
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgotPasswordUseCase.execute(email)).fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (supportMessage) {
      inputState.add(SuccessState(supportMessage));
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputValid =>
      _emailStreamController.stream.map((email) => email);

  @override
  Stream<bool> get outputIsEmailValid =>
      _isAllInputValidStreamController.stream.map((valid) => valid);
}

abstract class ForgotPasswordViewModelInput {
  forgotPassword();

  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
