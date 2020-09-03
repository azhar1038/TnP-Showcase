import 'package:flutter/material.dart';

class ExpansionCard extends StatefulWidget {
  final Widget header;
  final Widget body;
  final Duration duration;
  final bool descriptionFadeIn;
  final bool isExpanded;

  ExpansionCard(
      {@required this.header,
      @required this.body,
      this.duration = const Duration(milliseconds: 500),
      this.descriptionFadeIn = true,
      this.isExpanded = false});

  @override
  _ExpansionCardState createState() => _ExpansionCardState();
}

class _ExpansionCardState extends State<ExpansionCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _height, _opacity;
  bool isExpanded;

  @override
  void initState() {
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _height = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );
    isExpanded = widget.isExpanded;
    if (isExpanded) _controller.value = _controller.upperBound;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          onTap: () {
            if (_controller.status == AnimationStatus.completed) {
              _controller.reverse();
              isExpanded = false;
            } else {
              _controller.forward();
              isExpanded = true;
            }
            setState(() {});
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(child: widget.header),
                        Icon(
                          isExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color: Theme.of(context).iconTheme.color,
                        )
                      ],
                    ),
                    SizeTransition(
                      axisAlignment: 1.0,
                      sizeFactor: _height,
                      child: Container(
                        child: Opacity(
                          opacity: _opacity.value,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Divider(thickness: 0.7),
                              widget.body,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
