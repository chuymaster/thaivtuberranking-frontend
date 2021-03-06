import 'package:flutter/material.dart';

class PageSelection extends StatelessWidget {
  final int currentPageNumber;
  final int maxPageNumber;

  final Function(int destinationPage) onPageChanged;
  final int _maxButtonCount = 5;

  const PageSelection(
      {Key key, this.currentPageNumber, this.maxPageNumber, this.onPageChanged})
      : super(key: key);

  Widget buildPageSelection() {
    int i;

    // Determine button numbers to show
    List<int> buttonNumbers = [];

    if (currentPageNumber == 1 || currentPageNumber == 2) {
      i = 1;
      do {
        buttonNumbers.add(i);
        i++;
      } while (i <= maxPageNumber && buttonNumbers.length < _maxButtonCount);
    } else if (currentPageNumber == maxPageNumber ||
        currentPageNumber == maxPageNumber - 1) {
      i = maxPageNumber;
      do {
        buttonNumbers.add(i);
        i--;
      } while (i >= 1 && buttonNumbers.length < _maxButtonCount);
    } else {
      buttonNumbers.add(currentPageNumber - 2);
      buttonNumbers.add(currentPageNumber - 1);
      buttonNumbers.add(currentPageNumber);
      buttonNumbers.add(currentPageNumber + 1);
      buttonNumbers.add(currentPageNumber + 2);
    }

    // Sort button number
    buttonNumbers.sort(((a, b) => a.compareTo(b)));

    // Create buttons
    List<Widget> buttons = [];

    buttonNumbers.forEach((i) {
      buttons.add(buildPageButton(i));
    });

    return Container(
      color: Colors.white,
      child: Row(
        children: buttons,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      padding: EdgeInsets.all(4),
    );
  }

  Widget buildPageButton(int pageNumber) {
    return SizedBox(
      width: 50,
      child: RaisedButton(
          child: Text('$pageNumber'),
          color: (pageNumber == currentPageNumber)
              ? Colors.blue
              : Colors.grey[600],
          textColor: Colors.white,
          shape: CircleBorder(),
          onPressed: () => {onPageChanged(pageNumber)}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildPageSelection();
  }
}
