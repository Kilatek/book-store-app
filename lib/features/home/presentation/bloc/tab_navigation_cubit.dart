import 'package:flutter_bloc/flutter_bloc.dart';

class TabNavigationCubit extends Cubit<int> {
  TabNavigationCubit() : super(0);

  void navigate(index) => emit(index);
}
