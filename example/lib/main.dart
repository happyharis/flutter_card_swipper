import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_card_swipper/widgets/flutter_page_indicator/flutter_page_indicator.dart';
import 'src/example_custom.dart';
import 'src/config.dart';
import 'src/example_swiper_in_scroll_view.dart';

import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Swiper'),
      //home: buildHome(),
      routes: {
        '/example00': (BuildContext context) => CustomSwipes(),
        '/example01': (BuildContext context) => ExampleHorizontal(),
        '/example02': (BuildContext context) => ExampleVertical(),
        '/example03': (BuildContext context) => ExampleFraction(),
        '/example04': (BuildContext context) => ExampleCustomPagination(),
        '/example05': (BuildContext context) => ExamplePhone(),
        '/example06': (BuildContext context) => ScaffoldWidget(
            child: ExampleSwiperInScrollView(), title: 'ScrollView'),
        '/example07': (BuildContext context) => ScaffoldWidget(
              child: ExampleCustom(),
              title: 'Custom All',
            )
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> render(BuildContext context, List children) {
    return ListTile.divideTiles(
        context: context,
        tiles: children.map((dynamic data) {
          return buildListTile(context, data[0], data[1], data[2]);
        })).toList();
  }

  Widget buildListTile(
      BuildContext context, String title, String subtitle, String url) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(url);
      },
      isThreeLine: true,
      dense: false,
      leading: null,
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.arrow_right,
        color: Colors.blueAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // DateTime moonLanding = DateTime.parse('1969-07-20');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: render(context, [
          ['Custom Vertical', 'Custome Vertical Scrolls', '/example00'],
          ['Horizontal', 'Scroll Horizontal', '/example01'],
          ['Vertical', 'Scroll Vertical', '/example02'],
          ['Fraction', 'Fraction style', '/example03'],
          ['Custom Pagination', 'Custom Pagination', '/example04'],
          ['Phone', 'Phone view', '/example05'],
          ['ScrollView ', 'In a ScrollView', '/example06'],
          ['Custom', 'Custom all properties', '/example07']
        ]),
      ),
    );
  }
}

const List<String> titles = [
  'Flutter Swiper is awosome',
  'Really nice',
  'Yeap'
];

class ExampleHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ExampleHorizontal'),
        ),
        body: Swiper(
          index: 0,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: images.length,
          scrollDirection: Axis.horizontal,
          pagination: SwiperPagination(alignment: Alignment.centerRight),
          control: SwiperControl(),
          indicatorLayout: PageIndicatorLayout.COLOR,
        ));
  }
}

class ExampleVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ExampleVertical'),
        ),
        body: Swiper(
          index: 0,
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(
              images[index],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: images.length,
          scrollDirection: Axis.vertical,
          pagination: SwiperPagination(alignment: Alignment.centerRight),
          control: SwiperControl(),
        ));
  }
}

class ExampleFraction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ExampleFraction'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: images.length,
              pagination: SwiperPagination(builder: SwiperPagination.fraction),
              control: SwiperControl(),
            )),
            Expanded(
                child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: images.length,
              scrollDirection: Axis.vertical,
              pagination: SwiperPagination(
                  alignment: Alignment.centerRight,
                  builder: SwiperPagination.fraction),
            ))
          ],
        ));
  }
}

class ExampleCustomPagination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Custom Pagination'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Swiper(
                index: 0,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: images.length,
                pagination: SwiperPagination(
                    margin: EdgeInsets.all(0.0),
                    builder: SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return ConstrainedBox(
                        child: Container(
                            color: Colors.white,
                            child: Text(
                              '${titles[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}',
                              style: TextStyle(fontSize: 20.0),
                            )),
                        constraints: BoxConstraints.expand(height: 50.0),
                      );
                    })),
                control: SwiperControl(),
              ),
            ),
            Expanded(
              child: Swiper(
                index: 0,
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: images.length,
                pagination: SwiperPagination(
                    margin: EdgeInsets.all(0.0),
                    builder: SwiperCustomPagination(builder:
                        (BuildContext context, SwiperPluginConfig config) {
                      return ConstrainedBox(
                        child: Row(
                          children: <Widget>[
                            Text(
                              '${titles[config.activeIndex]} ${config.activeIndex + 1}/${config.itemCount}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: DotSwiperPaginationBuilder(
                                        color: Colors.black12,
                                        activeColor: Colors.black,
                                        size: 10.0,
                                        activeSize: 20.0)
                                    .build(context, config),
                              ),
                            )
                          ],
                        ),
                        constraints: BoxConstraints.expand(height: 50.0),
                      );
                    })),
                control: SwiperControl(color: Colors.redAccent),
              ),
            )
          ],
        ));
  }
}

class ExamplePhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone'),
      ),
      body: Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Image.asset(
              'images/bg.jpeg',
              fit: BoxFit.fill,
            ),
          ),
          Swiper.children(
            autoplay: false,
            pagination: SwiperPagination(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                builder: DotSwiperPaginationBuilder(
                    color: Colors.white30,
                    activeColor: Colors.white,
                    size: 20.0,
                    activeSize: 20.0)),
            index: 0,
            children: <Widget>[
              Image.asset(
                'images/1.png',
                fit: BoxFit.contain,
              ),
              Image.asset(
                'images/2.png',
                fit: BoxFit.contain,
              ),
              Image.asset('images/3.png', fit: BoxFit.contain)
            ],
          )
        ],
      ),
    );
  }
}

class CustomSwipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          // VerticalSwiper(),
          SizedBox(
            height: (414 / 812) * height,
            child: Swiper(
              reverse: true,
              itemCount: 2,
              itemWidth: width,
              itemHeight: 300.0,
              scrollDirection: Axis.vertical,
              layout: SwiperLayout.STACK,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey,
                  child: Center(
                    child: Text('$index'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ScaffoldWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final List<Widget> actions;

  ScaffoldWidget({this.child, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: child,
    );
  }
}
