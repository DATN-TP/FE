import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/data/data/list_bills.dart';
import 'package:ResiEasy/models/bill_model.dart';
import 'package:ResiEasy/views/common/no_result_widget.dart';
import 'package:ResiEasy/views/pages/bill/bill_view_model.dart';
import 'package:ResiEasy/views/pages/bill/detail/bill_detail_page.dart';
import 'package:ResiEasy/views/pages/bill/widget/bill_line_chart.dart';
import 'package:ResiEasy/views/pages/bill/widget/bill_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loadmore_listview/loadmore_listview.dart';
import 'package:provider/provider.dart';

class BillPage extends StatefulWidget {
  final String apartmentId;
  final String userId;
  const BillPage({super.key, required this.apartmentId, required this.userId});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> with WidgetsBindingObserver {
  BillViewModel billViewModel = BillViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      billViewModel.getBill(widget.apartmentId, 1, 6, "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => billViewModel..getBill(widget.apartmentId, 1, 6, ""),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'txt_listBill'.tr(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: ColorApp().cl1,
          titleSpacing: 0,
        ),
        body: Consumer<BillViewModel>(builder: (context, billViewModel, child) {
          return SafeArea(
            child: Container(
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  // const SizedBox(height: 15),
                  // _buildChart(billViewModel),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10),
                  //     child: Text(
                  //       'txt_listBill'.tr(),
                  //       style: const TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  _buildListBill(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildListBill() {
    return Consumer<BillViewModel>(
      builder: (context, billViewModel, child) {
        if (billViewModel.isLoading) {
          return Expanded(
              child: Center(
                  child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorApp().cl1),
          )));
        }
        billViewModel.ListBills.sort(
            (a, b) => b.createAt!.compareTo(a.createAt!));
        return Expanded(
          child: billViewModel.ListBills.isNotEmpty
              ? LoadMoreListView.builder(
                  hasMoreItem: _hasMoreItem(billViewModel),
                  onLoadMore: () async {
                    await loadMore(billViewModel, widget.apartmentId);
                  },
                  onRefresh: () async {
                    await refresh(billViewModel, widget.apartmentId);
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
                  itemCount: billViewModel.ListBills.length,
                  itemBuilder: (context, index) {
                    return BillItem(
                      bill: billViewModel.ListBills[index],
                      onTap: () async {
                        final result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BillDetailPage(
                              bill: billViewModel.ListBills[index],
                            ),
                          ),
                        );
                        if (result != null) {
                          billViewModel.getBill(widget.apartmentId, 1, 6, "");
                        }
                      },
                    );
                  })
              : const Center(
                  child: NoResultWidget(),
                ),
        );
      },
    );
  }

  Widget _buildChart(BillViewModel billViewModel) {
    try {
      return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(top: 15, bottom: 5),
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: BillLineChart(bills: billViewModel.ListBills),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: ColorApp().cl1.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorApp().cl1),
                ),
                child: Text(
                  'txt_chartBill'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorApp().cl1,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      return Center(
        child: Text('Error loading chart: $e'),
      );
    }
  }

  refresh(BillViewModel viewModel, String apartmentId) async {
    await viewModel.getBill(apartmentId, 1, 6, "");
  }

  loadMore(BillViewModel viewModel, String apartmentId) async {
    await viewModel.getBill(apartmentId, viewModel.currentPage, 6, "");
  }

  _hasMoreItem(BillViewModel viewModel) {
    return (viewModel.currentPage <= viewModel.totalPage);
  }
}
