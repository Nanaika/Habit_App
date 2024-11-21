import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBarIndexBloc extends Cubit<int> {
  BottomBarIndexBloc() : super(0);


  void changePage(int index) {
    emit(index);
  }

}