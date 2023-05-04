import 'dart:async';
import 'dart:io';

import 'package:advanced_flutter_arabic/domain/usecase/register_usecase.dart';
import 'package:advanced_flutter_arabic/pressentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/pressentation/common/freezed_data_classes.dart';
import 'package:advanced_flutter_arabic/pressentation/forget_password/functions.dart';
import 'package:advanced_flutter_arabic/pressentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  StreamController userNameStreamController =
      StreamController<String>.broadcast();
  StreamController mobileNumberStreamController =
      StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();
  StreamController profileStreamController = StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserRegisterInSuccessfullySteamController =
      StreamController<bool>();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject('', '', '', '', '', '');
  RegisterViewModel(this._registerUseCase);

  // inputs

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobileNumber => mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => passwordStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => areAllInputsValidStreamController.sink;

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupErrorState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
      registerObject.userName,
      registerObject.countryMobileCode,
      registerObject.mobileNumber,
      registerObject.email,
      registerObject.password,
      registerObject.profilePicture,
    )))
        .fold(
            (failure) => {
                  //left -> failure
                  inputState.add(ErrorState(
                      StateRendererType.popupErrorState, failure.message))
                }, (data) {
      // right -> data (success)
      // content
      inputState.add(ContentState());
      // navigato to main screen
      isUserRegisterInSuccessfullySteamController.add(true);
    });
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
// update register view object
      registerObject = registerObject.copyWith(userName: userName);
    } else {
// reset username value in register view object
      registerObject = registerObject.copyWith(userName: '');
    }
    validate();
  }

  @override
  setCountryCode(String countryMode) {
    if (countryMode.isNotEmpty) {
// update register view object
      registerObject = registerObject.copyWith(countryMobileCode: countryMode);
    } else {
// reset code value in register view object
      registerObject = registerObject.copyWith(countryMobileCode: '');
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
// update register view object
      registerObject = registerObject.copyWith(email: email);
    } else {
// reset email value in register view object
      registerObject = registerObject.copyWith(email: '');
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);
    if (_isMobileNumberValid(mobileNumber)) {
// update register view object
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
// reset mobileNumber value in register view object
      registerObject = registerObject.copyWith(mobileNumber: '');
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
// update register view object
      registerObject = registerObject.copyWith(password: password);
    } else {
// reset password value in register view object
      registerObject = registerObject.copyWith(password: '');
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
// update register view object
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
// reset password value in register view object
      registerObject = registerObject.copyWith(profilePicture: '');
    }
    validate();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    userNameStreamController.close();
    mobileNumberStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profileStreamController.close();
    areAllInputsValidStreamController.close();
    super.dispose();
    isUserRegisterInSuccessfullySteamController.close();
  }
  // outputs

  @override
  Stream<bool> get outputUserNameValid => userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));
  @override
  Stream<String?> get outputErrorUserName => outputUserNameValid
      .map((isUserName) => isUserName ? null : AppStrings.userNameInvalid.tr());

  @override
  Stream<bool> get outputEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmail => outputEmailValid
      .map((isUserName) => isUserName ? null : AppStrings.invalidEamil.tr());

  @override
  Stream<bool> get outputMobileNumberValid =>
      mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumber =>
      outputMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : AppStrings.mobileNumberInvalid.tr());

  @override
  Stream<bool> get outputPasswordValid => passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPassword => outputPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.passwordInvalid.tr());

  @override
  Stream<File> get outputProfilePicture =>
      profileStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  // privet functions

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 10;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    inputAreAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get inputAreAllInputsValid;

  register();

  setUserName(String userName);
  setMobileNumber(String mobileNumber);
  setCountryCode(String countryMode);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File profilePicture);
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputUserNameValid;
  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputMobileNumberValid;
  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputEmailValid;
  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputPasswordValid;
  Stream<String?> get outputErrorPassword;

  Stream<File> get outputProfilePicture;

  Stream<bool> get outputAreAllInputsValid;
}
