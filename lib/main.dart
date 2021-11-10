import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    RoundedSelectImage image =
        const RoundedSelectImage(Colors.green, Color(0x00000000));
    for (var i = 0; i < 8; i++) {
      _childImageList.add(image);
      _childImageList.add(const SizedBox(
        width: 24,
      ));
    }

    for (var i = 0; i < 10; i++) {
      _cardList.add(const Card(dollar: 7.80, cal: 120));
    }
  }

  final List<Widget> _childImageList = [
    const SizedBox(
      width: 24,
    )
  ];

  final List<Widget> _cardList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          () {},
          () {},
          'centerUpperText',
          'centerLowerText',
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          const FlutterLogo()),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _childImageList,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Flexible(
            child: ListView.builder(
                itemCount: _cardList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _cardList[index];
                }),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar(
      this.leadingButtonOnTapped,
      this.trailingButtonOnTapped,
      this.centerUpperText,
      this.centerLowerText,
      this.leadingButtonImage,
      this.trailingButtonImage,
      {Key? key})
      : super(key: key);

  final VoidCallback? leadingButtonOnTapped;
  final VoidCallback? trailingButtonOnTapped;
  final String centerUpperText;
  final String centerLowerText;
  final Widget leadingButtonImage;
  final Widget trailingButtonImage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: leadingButtonOnTapped,
        icon: leadingButtonImage,
      ),
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            centerUpperText,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            centerLowerText,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
      actions: [
        IconButton(
            onPressed: trailingButtonOnTapped, icon: trailingButtonImage),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class RoundedSelectImage extends StatefulWidget {
  const RoundedSelectImage(this.selectedColor, this.notSelectedColor,
      {Key? key})
      : super(key: key);

  final Color selectedColor;
  final Color notSelectedColor;

  @override
  _RoundedSelectImageState createState() => _RoundedSelectImageState();
}

class _RoundedSelectImageState extends State<RoundedSelectImage> {
  bool _isSelected = false;

  void _onTapped() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isSelected
                    ? widget.selectedColor
                    : widget.notSelectedColor,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                )),
            width: 48,
            height: 48,
          ),
          ColorFiltered(
              colorFilter: ColorFilter.mode(
                  _isSelected ? Colors.white : widget.selectedColor,
                  BlendMode.srcIn),
              child: const FlutterLogo(
                size: 36,
              ))
        ],
      ),
      onTap: _onTapped,
    );
  }
}

class FlutterCardImage extends StatelessWidget {
  const FlutterCardImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 160,
          color: Colors.green,
        ),
        const ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          child: FlutterLogo(
            size: 88,
          ),
        )
      ],
    );
  }
}

class Card extends StatelessWidget {
  const Card({Key? key, required this.dollar, required this.cal})
      : super(key: key);

  final _text =
      'aaaaaaaaaaaaa bbbbbbbbbbbbb\nxxxxxxxxxxxxx yyyyyyyyyyyyy\neeeeeeeeeeeee qqqqqqqqqqqqq';

  final double dollar;
  final int cal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              spreadRadius: 6.0,
              blurRadius: 10.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FlutterCardImage(),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Flutter Flutter',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                _text,
                maxLines: 3,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 20),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    '\$${dollar.toString()}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '\$${cal.toString()}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
