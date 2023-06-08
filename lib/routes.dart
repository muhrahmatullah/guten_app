import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guten_app/data/guten_repo.dart';
import 'package:guten_app/screens/detail/book_detail_screen.dart';
import 'package:guten_app/screens/detail/book_detail_vm.dart';
import 'package:guten_app/screens/list/book_list_screen.dart';
import 'package:guten_app/screens/list/book_list_vm.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';
import 'data/remote/http_client.dart';
import 'data/remote/remote_data_source.dart';

class GutenRoutes {
  static Map<String, WidgetBuilder> get() {
    return {
      GutenBookListScreen.route: (context) => ChangeNotifierProvider(
            create: (ctx) {
              AppConfig appConfig = Provider.of<AppConfig>(ctx, listen: false);
              GutenRepository repo = GutenRepository(GutenRemoteDataSource(
                  AppClientService(Dio(), appConfig.baseUrlConfig.domainUrl)));
              return BookListViewModel(repo);
            },
            child: const GutenBookListScreen(),
          ),
      GutenBookDetailScreen.route: (context) => ChangeNotifierProvider(
        create: (ctx) {
          AppConfig appConfig = Provider.of<AppConfig>(ctx, listen: false);
          GutenRepository repo = GutenRepository(GutenRemoteDataSource(
              AppClientService(Dio(), appConfig.baseUrlConfig.domainUrl)));
          return BookDetailViewModel(repo);
        },
        child: const GutenBookDetailScreen(),
      ),
    };
  }
}
