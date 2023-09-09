import 'dart:async';

import 'package:book_store/core/base/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'app_event.dart';
import 'app_state.dart';

@Injectable()
class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc() : super(AppState.initial()) {
    on<AppEventInitial>(onAppEventInitial);
  }

  Future<void> onAppEventInitial(
    AppEventInitial event,
    Emitter<AppState> emit,
  ) async {}
}
