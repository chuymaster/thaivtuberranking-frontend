import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaivtuberranking/admin/channel_management/channel_management_view_model.dart';
import 'package:thaivtuberranking/admin/channel_management/view/channel_management_data_table.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../common/component/confirm_dialog.dart';
import '../../common/component/error_dialog_view.dart';
import '../../common/component/retryable_error_view.dart';

class ChannelManagementPage extends StatefulWidget {
  const ChannelManagementPage({Key? key});

  @override
  State<ChannelManagementPage> createState() => _ChannelManagementPageState();
}

class _ChannelManagementPageState extends State<ChannelManagementPage> {
  final ChannelManagementViewModel _viewModel = ChannelManagementViewModel();

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded, {
      AnalyticsParameterName.screenName:
          AnalyticsPageName.adminChannelManagement
    });
    _viewModel.getChannelList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<ChannelManagementViewModel>(
          builder: ((context, viewModel, child) {
        if (viewModel.viewGetState is IdleState) {
          return Container();
        } else if (viewModel.viewGetState is LoadingState) {
          return const CenterCircularProgressIndicator();
        } else if (viewModel.viewGetState is ErrorState) {
          final errorMessage = (viewModel.viewGetState as ErrorState).msg;
          return RetryableErrorView(
              message: errorMessage, retryAction: viewModel.getChannelList);
        } else {
          List<Widget> stackChildren = [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  _searchBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        _menu,
                        ChannelManagementDataTable(
                          channelList: viewModel.channelList,
                          onLongPressRow: (index) {
                            launchUrlString(
                                viewModel.channelList[index].channelUrl);
                          },
                          onSelectedChanged: (isSelected, index) {
                            setState(() {
                              viewModel.channelList[index].isSelected =
                                  isSelected;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
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
                viewModel.getChannelList();
              },
            ));
          }
          return Stack(
            children: stackChildren,
          );
        }
      })),
    );
  }

  Widget get _searchBox {
    return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 150, maxWidth: 300),
        child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Filter",
                hintText: "Type channel title or ID"),
            onChanged: (value) => _viewModel.setFilterText(value)));
  }

  Widget get _menu {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ElevatedButton(
            child: const Text("Set as Original"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: _viewModel.hasSelection
                ? _viewModel.setSelectionAsOriginal
                : null,
          ),
          ElevatedButton(
            child: const Text("Set as Half"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            onPressed:
                _viewModel.hasSelection ? _viewModel.setSelectionAsHalf : null,
          ),
          ElevatedButton(
            child: const Text("Update"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: _viewModel.hasSelection ? _updateChannels : null,
          ),
          ElevatedButton(
            child: const Text("Delete"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: _viewModel.hasSelection ? _deleteChannels : null,
          ),
        ],
      ),
    );
  }

  void _updateChannels() {
    ConfirmDialog.show(
        "Confirm",
        "Would you like to update ${_viewModel.selectedChannelListCount} channels?",
        _viewModel.updateSelectedChannelList,
        context);
  }

  void _deleteChannels() {
    ConfirmDialog.show(
        "Confirm",
        "Would you like to delete ${_viewModel.selectedChannelListCount} channels?",
        _viewModel.deleteChannelList,
        context);
  }
}
