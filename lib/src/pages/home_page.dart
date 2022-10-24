import 'package:control_de_gastos/src/pages/graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller;
  int currentPage = 9;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 9,
      viewportFraction: 0.4,
    );
  }

  Widget _bottomAction(IconData icon) {
    return InkWell(
      child: Icon(icon),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 10.0,
        notchMargin: 10.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          verticalDirection: VerticalDirection.up,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction(FontAwesomeIcons.chartColumn),
            _bottomAction(FontAwesomeIcons.chartPie),
            SizedBox(
              width: 50.0,
              height: 60,
            ),
            _bottomAction(FontAwesomeIcons.wallet),
            _bottomAction(Icons.settings),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [
          _selector(),
          _expenses(),
          _graph(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          ),
          _list()
        ],
      ),
    );
  }

  Widget _graph() {
    return Container(
      child: GraphWidget(),
      height: 250,
    );
  }

  Widget _pageItem(String name, int position) {
    var _alignment;

    final selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );

    final unselected = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );

    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.centerRight;
    } else {
      _alignment = Alignment.centerLeft;
    }
    return Align(
      alignment: _alignment,
      child: Text(
        name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            currentPage = newPage;
          });
        },
        controller: _controller,
        children: [
          _pageItem('Enero', 0),
          _pageItem('Febrero', 1),
          _pageItem('Marzo', 2),
          _pageItem('Abril', 3),
          _pageItem('Mayo', 4),
          _pageItem('Junio', 5),
          _pageItem('Julio', 6),
          _pageItem('Agosto', 7),
          _pageItem('Septiembre', 8),
          _pageItem('Octubre', 9),
          _pageItem('Noviembre', 10),
          _pageItem('Diciembre', 11),
        ],
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) =>
            _item(FontAwesomeIcons.cartShopping, 'Shoping', 14, 145.12),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          );
        },
      ),
    );
  }

  Widget _expenses() {
    return Column(
      children: [
        Text(
          '\$ 2367,41',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        Text(
          'Gasto Total',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.blueGrey,
          ),
        )
      ],
    );
  }

  Widget _item(IconData icon, String nombre, int percent, double value) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32.0,
      ),
      title: Text(
        nombre,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      subtitle: Text(
        "$percent% of expenses",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$$value",
            style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
                fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
