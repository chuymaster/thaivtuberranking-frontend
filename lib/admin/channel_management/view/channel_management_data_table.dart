import 'package:flutter/material.dart';

import '../../../../common/component/status_chip.dart';
import '../entity/channel.dart';

class ChannelManagementDataTable extends StatefulWidget {
  const ChannelManagementDataTable(
      {Key? key,
      required this.channelList,
      required this.onLongPressRow,
      required this.onSelectedChanged});

  final List<Channel> channelList;
  final Function(int index) onLongPressRow;
  final Function(bool isSelected, int index) onSelectedChanged;

  @override
  State<ChannelManagementDataTable> createState() =>
      _ChannelManagementDataTableState();
}

class _ChannelManagementDataTableState
    extends State<ChannelManagementDataTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            columnSpacing: 24,
            columns: _dataColumns,
            rows: List<DataRow>.generate(
                widget.channelList.length,
                (index) => DataRow(
                    selected: widget.channelList[index].isSelected,
                    onLongPress: () {
                      widget.onLongPressRow(index);
                    },
                    onSelectChanged: (isSelected) {
                      widget.onSelectedChanged(isSelected!, index);
                    },
                    color: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      return _getCellColor(index, states);
                    }),
                    cells: makeDataCells(widget.channelList[index])))));
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
    ];
  }

  List<DataCell> makeDataCells(Channel channel) {
    return [
      DataCell(_makeChannelInfoRow(
          channel.title, channel.channelId, channel.thumbnailImageUrl)),
      DataCell(_makeTypeChip(channel.type)),
    ];
  }

  Widget _makeChannelInfoRow(
      String title, String channelId, String thumbnailImageUrl) {
    return Row(
      children: [
        _makeThumbnailImage(thumbnailImageUrl),
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        Container(
            width: 200,
            child: Text(title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold))),
        const Padding(
          padding: EdgeInsets.all(8),
        ),
        Container(
            width: 200,
            child: Text(
              channelId,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ))
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

  Color? _getCellColor(int index, Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
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
