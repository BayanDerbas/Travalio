import 'package:bloc/bloc.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial(index: 0)) {
    on<TabChanged>((event, emit) {
      emit(TabInitial(index: event.index));
    });
  }
}
