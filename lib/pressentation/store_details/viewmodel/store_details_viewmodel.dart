import 'dart:ffi';

import 'package:advanced_flutter_arabic/domain/model/models.dart';
import 'package:advanced_flutter_arabic/domain/usecase/store_details_usecase%20copy.dart';
import 'package:advanced_flutter_arabic/pressentation/base/base_view_model.dart';
import 'package:advanced_flutter_arabic/pressentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_flutter_arabic/pressentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;
  StoreDetailsViewModel(this.storeDetailsUseCase);
  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await storeDetailsUseCase.execute(Void)).fold(
        (failure) => inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message)),
        (storeDetails) async {
      inputState.add(ContentState());
      inputStoreDetails.add(storeDetails);
    });
  }

  @override
  void start() {
    _loadData();
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  @override
  // TODO: implement outputStoreDetails
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}
