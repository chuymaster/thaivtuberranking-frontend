import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../../../common/component/center_circular_progress_indicator.dart';
import '../../../common/component/confirm_dialog.dart';
import '../../../common/component/error_dialog_view.dart';
import '../../../common/component/retryable_error_view.dart';
import '../../../services/result.dart';
import '../../main.dart';
import '../../services/analytics.dart';
import 'channel_request_view_model.dart';
import 'entity/channel_request.dart';
import 'view/channel_request_data_table.dart';

class ChannelRequestPage extends StatefulWidget {
  const ChannelRequestPage({Key? key});
  @override
  State<ChannelRequestPage> createState() => _ChannelRequestPageState();
}

class _ChannelRequestPageState extends State<ChannelRequestPage> {
  final ChannelRequestViewModel _viewModel = ChannelRequestViewModel();

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded,
        {AnalyticsParameterName.screenName: AnalyticsPageName.channelRequest});
    _viewModel.getChannelRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(44.0),
            child: AppBar(
              title: const Text("Channel Request"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Logout',
                  onPressed: () {
                    ConfirmDialog.show(
                        "Confirm Logout",
                        "Would you like to logout?",
                        _viewModel.logout,
                        context);
                  },
                ),
              ],
            )),
        body: _body);
  }

  Widget get _body {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<ChannelRequestViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.viewGetState is IdleState) {
            return Container();
          } else if (viewModel.viewGetState is LoadingState) {
            return const CenterCircularProgressIndicator();
          } else if (viewModel.viewGetState is ErrorState) {
            final errorMessage = (viewModel.viewGetState as ErrorState).msg;
            return RetryableErrorView(
                message: errorMessage,
                retryAction: viewModel.getChannelRequests);
          } else {
            final List<ChannelRequest> channelRequests =
                (viewModel.viewGetState as SuccessState).value;
            List<Widget> stackChildren = [
              Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      _menu,
                      ChannelRequestDataTable(
                        channelRequests: channelRequests,
                        onLongPressRow: (index) {
                          launch(channelRequests[index].channelUrl);
                        },
                        onSelectedChanged: (isSelected, index) {
                          setState(() {
                            channelRequests[index].isSelected = isSelected;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ];
            if (viewModel.viewPostState is LoadingState) {
              stackChildren.add(const CenterCircularProgressIndicator(
                isOverlay: true,
              ));
            } else if (viewModel.viewPostState is ErrorState) {
              final errorMessage = (viewModel.viewPostState as ErrorState).msg;
              stackChildren.add(ErrorDialogView(
                title: "Error",
                message: errorMessage,
                closeAction: () {
                  viewModel.resetViewStates();
                  viewModel.getChannelRequests();
                },
              ));
            }
            return Stack(
              children: stackChildren,
            );
          }
        },
      ),
    );
  }

  Widget get _menu {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Wrap(
        spacing: 8,
        children: [
          ElevatedButton(
            child: const Text("Accept"),
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: _viewModel.hasSelection ? _approveChannelRequests : null,
          ),
          ElevatedButton(
            child: const Text(
              "Pend",
            ),
            style: ElevatedButton.styleFrom(primary: Colors.orange),
            onPressed: _viewModel.hasSelection ? _pendChannelRequests : null,
          ),
          ElevatedButton(
            child: const Text("Reject"),
            style: ElevatedButton.styleFrom(primary: Colors.black),
            onPressed: _viewModel.hasSelection ? _rejectChannelRequests : null,
          ),
          ElevatedButton(
            child: const Text("Delete"),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: _viewModel.hasSelection ? _deleteChannelRequests : null,
          ),
          ElevatedButton(
            child: const Text("Set as Original"),
            style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            onPressed: _viewModel.hasSelection
                ? _viewModel.setSelectionAsOriginal
                : null,
          ),
          ElevatedButton(
            child: const Text("Set as Half"),
            style: ElevatedButton.styleFrom(primary: Colors.pink),
            onPressed:
                _viewModel.hasSelection ? _viewModel.setSelectionAsHalf : null,
          ),
        ],
      ),
    );
  }

  void _approveChannelRequests() {
    ConfirmDialog.show(
        "Confirm",
        "Would you like to approve ${_viewModel.selectedChannelRequestsCount} channel requests?",
        _viewModel.approveChannelRequests,
        context);
  }

  void _pendChannelRequests() {
    ConfirmDialog.show(
        "Confirm",
        "Would you like to make ${_viewModel.selectedChannelRequestsCount} channel requests on hold?",
        _viewModel.pendChannelRequests,
        context);
  }

  void _rejectChannelRequests() {
    ConfirmDialog.show(
        "Confirm",
        "Would you like to reject ${_viewModel.selectedChannelRequestsCount} channel requests?",
        _viewModel.rejectChannelRequests,
        context);
  }

  void _deleteChannelRequests() {
    ConfirmDialog.show(
        "Confirm",
        "Would you like to delete ${_viewModel.selectedChannelRequestsCount} channel requests?",
        _viewModel.deleteChannelRequests,
        context);
  }
}