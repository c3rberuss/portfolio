import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:services/src/models/card_model.dart';
import 'package:services/src/repositories/applications_repository.dart';
import './bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final ApplicationsRepository _repository;

  DetailBloc(this._repository);

  @override
  DetailState get initialState => InitialDetailState();

  @override
  Stream<DetailState> mapEventToState(
    DetailEvent event,
  ) async* {
    if (event is FetchApplicationEvent) {
      yield FetchingDataState();

      try {
        final response = await _repository.fetchApplication(event.applicationId);

        yield FetchingDataSuccessState(response.data);
      } catch (error) {
        print(error);
      }
    } else if (event is PayServiceEvent) {
      yield* _mapFinishPayment(event.applicationId, event.amount, event.context);
    }
  }

  Stream<DetailState> _mapFinishPayment(
      int applicationId, double amount, BuildContext context) async* {
    final card = await Navigator.pushNamed(context, "card");
    if (card != null && card is CardModel) {
      yield SendingPaymentState();

      try {
        final stripeCard = StripeCard(
          number: card.number,
          name: card.name,
          cvc: card.cvc,
          expMonth: card.expMonth,
          expYear: card.expYear,
        );

        final paymentMethod = await StripeApi.instance.createPaymentMethodFromCard(stripeCard);

        try {
          final paymentIntent =
              await _repository.createPaymentIntent(amount, paymentMethod['id'], false);

          await StripeApi.instance.confirmPaymentIntent(paymentIntent.clientSecret);

          await _repository.finishPayment(applicationId, amount);

          yield PaymentSendState(applicationId);
        } on DioError catch (error) {
          print(error);

          if (error.response != null) {
            print(error.response.data);
            yield PaymentErrorState();
          }
        }
      } on DioError catch (error) {
        print(error);
        if (error.response != null) {
          print(error.response.data);
          yield PaymentErrorState();
        }
      }
    }
  }
}
