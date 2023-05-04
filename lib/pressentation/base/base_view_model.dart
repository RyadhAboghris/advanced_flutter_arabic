import 'dart:async';

import 'package:advanced_flutter_arabic/pressentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and function that will be used through any view model.
  final StreamController _inputSrteamController = BehaviorSubject<FlowState>();

  @override
  // TODO: implement inputState
  Sink get inputState => _inputSrteamController.sink;

  @override
  // TODO: implement outputState
  Stream<FlowState> get outputState =>
      _inputSrteamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputSrteamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); // start view model job

  void dispose(); // will be called when view model dies

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  // will be implemented later

  Stream<FlowState> get outputState;
}
