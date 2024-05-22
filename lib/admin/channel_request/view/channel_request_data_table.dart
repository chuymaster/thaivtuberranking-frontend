import 'package:flutter/material.dart';

import '../../../../common/component/status_chip.dart';
import '../entity/channel_request.dart';

class ChannelRequestDataTable extends StatefulWidget {
  const ChannelRequestDataTable(
      {Key? key,
      required this.channelRequests,
      required this.onLongPressRow,
      required this.onSelectedChanged});

  final List<ChannelRequest> channelRequests;
  final Function(int index) onLongPressRow;
  final Function(bool isSelected, int index) onSelectedChanged;

  @override
  State<ChannelRequestDataTable> createState() =>
      _ChannelRequestDataTableState();
}

class _ChannelRequestDataTableState extends State<ChannelRequestDataTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columnSpacing: 24,
            columns: _dataColumns,
            rows: List<DataRow>.generate(
                widget.channelRequests.length,
                (index) => DataRow(
                    selected: widget.channelRequests[index].isSelected,
                    onLongPress: () {
                      widget.onLongPressRow(index);
                    },
                    onSelectChanged: (isSelected) {
                      widget.onSelectedChanged(isSelected!, index);
                    },
                    color: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                      return _getCellColor(index, states);
                    }),
                    cells: makeDataCells(widget.channelRequests[index])))));
  }

  List<DataColumn> get _dataColumns {
    return [
      const DataColumn(
        label: Text(
          'Channel',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      const DataColumn(
        label: Text(
          'Type',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      const DataColumn(
        label: Text(
          'Status',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
  }

  List<DataCell> makeDataCells(ChannelRequest channelRequest) {
    return [
      DataCell(_makeChannelInfoRow(
          channelRequest.title, channelRequest.thumbnailImageUrl)),
      DataCell(_makeTypeChip(channelRequest.type)),
      DataCell(_makeStatusTag(channelRequest.status)),
    ];
  }

  Widget _makeChannelInfoRow(String title, String thumbnailImageUrl) {
    return Row(
      children: [
        _makeThumbnailImage(thumbnailImageUrl),
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 150, maxWidth: 300),
          child: Text(title,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  Widget _makeThumbnailImage(String url) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          url,
          height: 32,
          width: 32,
          fit: BoxFit.fill,
          errorBuilder: (_, __, ___) {
            return const Icon(Icons.error_outline);
          },
        ));
  }

  Widget _makeTypeChip(ChannelType type) {
    switch (type) {
      case ChannelType.original:
        return const StatusChip(
            title: "Original", backgroundColor: Colors.deepPurple);
      case ChannelType.half:
        return const StatusChip(title: "Half", backgroundColor: Colors.pink);
    }
  }

  Widget _makeStatusTag(ChannelRequestStatus status) {
    switch (status) {
      case ChannelRequestStatus.unconfirmed:
        return const StatusChip(
            title: "Unconfirmed", backgroundColor: Colors.blue);
      case ChannelRequestStatus.accepted:
        return const StatusChip(
            title: "Accepted", backgroundColor: Colors.green);
      case ChannelRequestStatus.pending:
        return const StatusChip(
            title: "Pending", backgroundColor: Colors.orange);
      case ChannelRequestStatus.rejected:
        return const StatusChip(
            title: "Rejected", backgroundColor: Colors.black);
    }
  }

  Color? _getCellColor(int index, Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return Theme.of(context).colorScheme.primary.withOpacity(0.4);
    } else {
      if (index.isEven) {
        return Theme.of(context).colorScheme.primary.withOpacity(0.1);
      } else {
        return null;
      }
    }
  }
}
