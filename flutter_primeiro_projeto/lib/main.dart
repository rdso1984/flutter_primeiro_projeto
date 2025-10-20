import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_primeiro_projeto/pages/botoes_rotacao_texto/botoes_rotacao_texto.dart';
import 'package:flutter_primeiro_projeto/pages/container/container_page.dart';
import 'package:flutter_primeiro_projeto/pages/dialogs/dialogs_page.dart';
import 'package:flutter_primeiro_projeto/pages/home/home_page.dart';
import 'package:flutter_primeiro_projeto/pages/layout_builder/layout_builder_page.dart';
import 'package:flutter_primeiro_projeto/pages/rows_columns/rows_colums_page.dart';
import 'package:flutter_primeiro_projeto/pages/scrolls/listview_page.dart';
import 'package:flutter_primeiro_projeto/pages/scrolls/singlechildscrollview_page.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false, // !kReleaseMode, //alterar para false quando estiver testado
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/container': (context) => const ContainerPage(),
        '/rows_columns': (context) => const RowsColumsPage(),
        '/layout_builder': (context) => const LayoutBuilderPage(),
        '/botoes_rotacao_texto': (context) => const BotoesRotacaoTexto(),
        '/scrolls/single_child': (context) => const SinglechildscrollviewPage(),
        '/scrolls/list_view': (context) => const ListviewPage(),  
        '/dialogs': (context) => const DialogsPage(),
      },
    );
  }
}

