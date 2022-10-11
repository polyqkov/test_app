part of 'bloc.dart';

abstract class RegEvent {}

class RegFetchEvent extends RegEvent {
  RegModel regModel;

  RegFetchEvent({
    required this.regModel,
  });
}
