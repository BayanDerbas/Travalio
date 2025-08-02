part of 'navigation_bloc.dart';

abstract class NavigationState {}

final class NavigationInitial extends NavigationState {
  final int currentIndex;

  NavigationInitial({this.currentIndex = 0});
}
