import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/models/news_model.dart';
import 'package:ResiEasy/views/pages/news/news_view_model.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:loadmore_listview/loadmore_listview.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'txt_news'.tr(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorApp().cl1,
        titleSpacing: 0,
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => NewsViewModel()..fetchNews(1, 10),
        child: Consumer<NewsViewModel>(
          builder:
              (BuildContext context, NewsViewModel viewModel, Widget? child) {
            return Container(
              color: Colors.white,
              child: LoadMoreListView.builder(
                  hasMoreItem: _hasMoreItem(viewModel),
                  onLoadMore: () async {
                    await loadMore(viewModel);
                  },
                  onRefresh: () async {
                    await refresh(viewModel);
                  },
                  loadMoreWidget: Container(
                    margin: const EdgeInsets.all(20.0),
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(ColorApp().cl1),
                    ),
                  ),
                  refreshColor: ColorApp().cl1,
                  refreshBackgroundColor: ColorApp().white,
                  itemCount: viewModel.listNews.length,
                  itemBuilder: (context, index) {
                    return _buildNewsItem(
                      viewModel.listNews[index],
                    );
                  }),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNewsItem(NewsModel news) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AnyLinkPreview(
        link: news.link ?? "",
        displayDirection: UIDirection.uiDirectionHorizontal,
        cache: const Duration(hours: 1),
        backgroundColor: ColorApp().white,
        errorWidget: Container(
          color: Colors.grey[300],
          child: const Text('Oops!'),
        ),
        removeElevation: false,
      ),
    );
  }
}

refresh(NewsViewModel viewModel) async {
 await viewModel.fetchNews(1, 10);
}

loadMore(NewsViewModel viewModel) async {
  await viewModel.fetchNews(viewModel.currentPage, 10);
}

_hasMoreItem(NewsViewModel viewModel) {
  return (viewModel.currentPage <= viewModel.totalPage);
}
