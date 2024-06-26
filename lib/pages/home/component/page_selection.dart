import 'package:flutter/material.dart';

class PageSelection extends StatelessWidget {
  final BuildContext context;
  final int currentPageNumber;
  final int maxPageNumber;

  final Function(int destinationPage) onPageChanged;
  final int _maxButtonCount = 5;

  const PageSelection(
      {super.key,
      required this.context,
      required this.currentPageNumber,
      required this.maxPageNumber,
      required this.onPageChanged});

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
      padding: EdgeInsets.all(16),
    );
  }

  Widget buildPageButton(int pageNumber) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        textStyle: TextStyle(
            color: (pageNumber == currentPageNumber)
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface),
        backgroundColor: (pageNumber == currentPageNumber)
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surface,
        shape: CircleBorder());
    return ElevatedButton(
        child: Text('$pageNumber'),
        style: buttonStyle,
        onPressed: () => {onPageChanged(pageNumber)});
  }

  @override
  Widget build(BuildContext context) {
    return buildPageSelection();
  }
}
