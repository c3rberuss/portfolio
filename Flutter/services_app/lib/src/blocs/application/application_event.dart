import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:services/src/models/application_detail.dart';
import 'package:services/src/models/card_model.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();
}

class AddServiceEvent extends ApplicationEvent {
  final ApplicationDetail service;

  AddServiceEvent(this.service);

  @override
  List<Object> get props => [service];
}

class ConfirmDeleteEvent extends ApplicationEvent {
  @override
  List<Object> get props => [];
}

class CancelDeleteEvent extends ApplicationEvent {
  @override
  List<Object> get props => [];
}

class SelectAllEvent extends ApplicationEvent {
  final bool value;

  SelectAllEvent(this.value);

  @override
  List<Object> get props => [value];
}

class UnselectedAllEvent extends ApplicationEvent {
  @override
  List<Object> get props => [];
}

class SelectServiceEvent extends ApplicationEvent {
  final bool value;
  final int index;

  SelectServiceEvent(this.value, this.index);

  @override
  List<Object> get props => [value, index];
}

class RemoveServicesEvent extends ApplicationEvent {
  @override
  List<Object> get props => [];
}

class RemoveImageEvent extends ApplicationEvent {
  final int index;

  RemoveImageEvent(this.index);

  @override
  List<Object> get props => [index];
}

class AddImageEvent extends ApplicationEvent {
  final File image;

  AddImageEvent(this.image);

  @override
  List<Object> get props => [image];
}

class ObtainLocation extends ApplicationEvent {
  @override
  List<Object> get props => [];
}

class ClearApplicationEvent extends ApplicationEvent {
  @override
  List<Object> get props => [];
}

class ShowOrHideBottomSheet extends ApplicationEvent {
  final bool forceClose;

  ShowOrHideBottomSheet({this.forceClose = false});

  @override
  List<Object> get props => [forceClose];
}

class ChangeDescriptionEvent extends ApplicationEvent {
  final String description;

  ChangeDescriptionEvent(this.description);

  @override
  List<Object> get props => [description];
}

class SendApplicationEvent extends ApplicationEvent {
  final CardModel card;

  SendApplicationEvent(this.card);

  @override
  List<Object> get props => [card];
}
