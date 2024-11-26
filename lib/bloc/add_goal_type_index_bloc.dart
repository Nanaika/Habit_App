import 'package:flutter_bloc/flutter_bloc.dart';

class AddGoalTypeIndexBloc extends Cubit<int> {
  AddGoalTypeIndexBloc() : super(0);


  void changeIndex(int index) {
    print('EMIT index --------  ${index}');
    emit(index);
  }

}