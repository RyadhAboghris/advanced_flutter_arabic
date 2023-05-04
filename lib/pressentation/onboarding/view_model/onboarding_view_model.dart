// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:advanced_flutter_arabic/pressentation/base/base_view_model.dart';

import '../../../domain/model/models.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
// stream controllers outputs
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  // OnBoarding BaseViewModelInputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
// view model start your job
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
    
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // OnBoarding BaseViewModelOutputs
  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // ponboarding  private fuctions
  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1.tr(),
            AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2.tr(),
            AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3.tr(),
            AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4.tr(),
            AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onBoardingLogo4),
      ];
}

// inputs mean that "orders" that our view model will receive from view
abstract class OnBoardingViewModelInputs {
  int goNext(); // when user clicks on right arrow or swipe left
  int goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);
  // stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
// stream controller output
  Stream<SliderViewObject> get outputSliderViewObject;
}
