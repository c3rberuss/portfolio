import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:services/src/blocs/detail/bloc.dart';
import 'package:services/src/blocs/detail/detail_bloc.dart';
import 'package:services/src/blocs/detail/detail_state.dart';
import 'package:services/src/blocs/history/bloc.dart';
import 'package:services/src/models/application_status_model.dart';
import 'package:services/src/presentation/widgets/card.dart';
import 'package:services/src/presentation/widgets/dialog.dart';
import 'package:services/src/presentation/widgets/service_tile.dart';
import 'package:services/src/utils/screen_utils.dart';

class ApplicationDetailScreen extends StatelessWidget {
  final _moneyStyle = TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  final _labelStyle = TextStyle(
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _bloc = BlocProvider.of<DetailBloc>(context);

    final ProgressDialog _progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    )..style(
        message: 'Sending payment...',
        borderRadius: 8.0,
        backgroundColor: Colors.white,
        elevation: 12,
      );

    return Scaffold(
      appBar: AppBar(
        title: Text('Application detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
          child: BlocConsumer<DetailBloc, DetailState>(
            listener: (BuildContext context, DetailState state) async {
              if (state is SendingPaymentState) {
                _progressDialog.show();
              } else if (state is PaymentSendState) {
                _progressDialog.hide();
                _showMessage("Payment finished", context);
                BlocProvider.of<HistoryBloc>(context).add(FetchHistoryEvent());
                _bloc.add(FetchApplicationEvent(state.applicationId));
              } else if (state is PaymentErrorState) {
                _progressDialog.hide();
                _showMessage("Payment not sent", context, DialogType.Error);
              }
            },
            builder: (BuildContext context, DetailState state) {
              if (state is FetchingDataSuccessState) {
                return _buildBody(state, context);
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<DetailBloc, DetailState>(
        builder: (BuildContext context, DetailState state) {
          if (state is FetchingDataSuccessState) {
            if (state.application.status == ApplicationStatusModel.partialPaid) {
              return FlatButton.icon(
                onPressed: () {
                  final amount = (state.application.total - state.application.moneyPaid);

                  _bloc.add(PayServiceEvent(state.application.applicationId, amount, context));
                },
                icon: Icon(Icons.payment, color: Colors.white),
                label: Text("Finish payment", style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(62)),
                color: Colors.blue,
              );
            }
          }

          return Container(width: 0, height: 0);
        },
      ),
    );
  }

  Widget _buildBody(FetchingDataSuccessState state, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Payment detail", style: TextStyle(fontSize: 20)),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: getScreenHeight(context) * 0.15,
              width: getScreenWidth(context) * 0.32,
              child: CustomCard(
                content: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("\$${state.application.total}", style: _moneyStyle),
                      Text("Total", style: _labelStyle),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getScreenHeight(context) * 0.15,
              width: getScreenWidth(context) * 0.32,
              child: CustomCard(
                content: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("\$${state.application.moneyPaid}", style: _moneyStyle),
                      Text("Payed", style: _labelStyle),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getScreenHeight(context) * 0.15,
              width: getScreenWidth(context) * 0.32,
              child: CustomCard(
                content: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                          "\$${(state.application.total - state.application.moneyPaid).toStringAsFixed(2)}",
                          style: _moneyStyle),
                      Text(
                        "Finish payment",
                        style: _labelStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: getScreenHeight(context) * 0.05),
        Text("Services", style: TextStyle(fontSize: 20)),
        Divider(),
        CustomCard(
          content: Column(
            children: <Widget>[
              if (state is FetchingDataSuccessState) ...[
                ...state.application.services.map(
                  (service) => ServiceTile(
                    key: Key("${service.serviceId}"),
                    service: service,
                    pos: 0,
                    withBloc: false,
                  ),
                )
              ] else if (state is FetchingDataState) ...[
                Center(
                  child: CircularProgressIndicator(),
                )
              ] else ...[
                Center(
                  child: Text("Unknown"),
                )
              ]
            ],
          ),
        ),
        if (state.application.description.isNotEmpty) ...[
          SizedBox(height: getScreenHeight(context) * 0.05),
          Text("Extra info", style: TextStyle(fontSize: 20)),
          Divider(),
          SizedBox(
            width: getScreenWidth(context),
            height: getScreenHeight(context) * 0.1,
            child: CustomCard(
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(state.application.description),
              ),
            ),
          ),
        ],
        SizedBox(height: getScreenHeight(context) * 0.05),
        Text("Attachments", style: TextStyle(fontSize: 20)),
        Divider(),
        Container(
          height: getScreenHeight(context) * 0.15,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              final width = getScreenWidth(ctx) / 4;
              final height = getScreenHeight(ctx);

              return CustomCard(
                content: ClipRRect(
                  child: CachedNetworkImage(
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                    imageUrl: state.application.images[index].path,
                    placeholder: (ctx, value) {
                      print(value);
                      return Container(
                        width: width,
                        height: height,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorWidget: (ctx, value, nothing) {
                      return Container(
                        width: width,
                        height: height,
                        child: Center(
                          child: Icon(Icons.broken_image, color: Colors.red),
                        ),
                      );
                    },
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              );
            },
            itemCount: state.application.images.length,
          ),
        ),
        SizedBox(height: 16)
      ],
    );
  }

  Future<void> _showMessage(String message, BuildContext context,
      [DialogType type = DialogType.Success]) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return CustomDialog(
          title: "Payment",
          content: message,
          dialogType: type,
        );
      },
    );
  }
}
