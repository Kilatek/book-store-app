import 'dart:async';

import 'package:book_store/core/base/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_event.dart';
import 'home_state.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeEventInital>(onHomeEventInital);
  }

  Future<void> onHomeEventInital(
    HomeEventInital event,
    Emitter<HomeState> emit,
  ) async {}
}
