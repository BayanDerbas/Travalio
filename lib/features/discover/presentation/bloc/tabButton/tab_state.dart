
part of 'tab_bloc.dart';

abstract class TabState {}

class TabInitial extends TabState {
  final int index;

  TabInitial({required this.index});
}