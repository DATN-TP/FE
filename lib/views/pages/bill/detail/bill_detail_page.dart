import 'package:ResiEasy/data/config/colors.dart';
import 'package:ResiEasy/data/hive/hive_provider.dart';
import 'package:ResiEasy/models/bill_model.dart';
import 'package:ResiEasy/models/user_model.dart';
import 'package:ResiEasy/views/pages/bill/bill_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class BillDetailPage extends StatefulWidget {
  Bill? bill;
  BillDetailPage({super.key, this.bill});

  @override
  State<BillDetailPage> createState() => _BillDetailPageState();
}

class _BillDetailPageState extends State<BillDetailPage> with WidgetsBindingObserver{
  late IO.Socket socket;
  BillViewModel billViewModel = BillViewModel();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _connectSocket();
  }

  void _connectSocket() {
    socket = IO.io(dotenv.env['SOCKET_URL'], <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {});

    socket.on('disconnect', (_) {});

    socket.emit('joinBill', widget.bill?.id);

    socket.on('paymentInfo', (data) {
      widget.bill = Bill.fromJson(data);
      setState(() {});
    });
  }

  @override
  void dispose() {
    socket.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
     billViewModel.getBillById(widget.bill!.id ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = HiveProvider().getUser();
    return ChangeNotifierProvider(
      create: (context) => billViewModel..getBillById(widget.bill!.id ?? ""),
      child: Scaffold(
        appBar: AppBar(
          title: Text('txt_billDetail'.tr(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: ColorApp().cl1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
                Navigator.pop(context, (billViewModel.bill.status=='paid'));
            },
          ),
        ),
        body: Consumer<BillViewModel>(
          builder: (context, billViewModel, child) {
            return 
            billViewModel.isLoading
            ? const Center(
              child: CircularProgressIndicator(),
            ):
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSumary(billViewModel),
                          _buildListView(),
                        ],
                      ),
                    ),
                  ),
                ),
                _buttonPayment(billViewModel, user),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildSumary(BillViewModel billViewModel) {
    widget.bill;
    String monthYear =
        DateFormat('MM/yyyy').format(widget.bill!.createAt ?? DateTime.now());
    String amount = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(widget.bill?.total);

    Color colorStatus;
    Color colorBackgroundStatus;
    Text status;

    if (billViewModel.bill.status == 'paid') {
      status = const Text("Đã thanh toán",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold));
      colorStatus = Colors.green;
      colorBackgroundStatus = Colors.green.shade100;
    } else {
      status = const Text("Chờ thanh toán",
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold));
      colorStatus = Colors.orange;
      colorBackgroundStatus = Colors.orange.shade100;
    }
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${'txt_month'.tr()} $monthYear',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: colorBackgroundStatus,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: status,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'txt_totalBill'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' $amount',
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment:
            //       MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'txt_apartment'.tr(),
            //       style: const TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     Text(
            //       '${bill.apartment}',
            //       style: const TextStyle(
            //         fontSize: 16,
            //         fontStyle: FontStyle.italic,
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'txt_createAt'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(widget.bill?.createAt ?? DateTime.now()),
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            billViewModel.bill.status == 'paid'
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'txt_paymentDate'.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy').format(
                                billViewModel.bill.paymentDate ??
                                    DateTime.now()),
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  )
                : const SizedBox(),

            // phương thức thanh toán
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'txt_paymentMethod'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  billViewModel.bill.paymentMethod == "transfer"
                      ? 'txt_transfer'.tr()
                      : 'txt_cash'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // người thanh toán
            billViewModel.bill.status == 'paid'
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'txt_paymentBy'.tr(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${billViewModel.bill.paymentBy?.username}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : const SizedBox(),
            // ghi chú
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'txt_note'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.bill?.note ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: widget.bill?.service?.length,
      itemBuilder: (context, index) {
        final service = widget.bill?.service![index];
        final serviceName = service?.service?.name;
        final servicePrice = service?.service?.price;
        final serviceQuantity = service?.quantity;
        final serviceTotal = (serviceQuantity ?? 0) * (servicePrice ?? 0);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'txt_service'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      serviceName ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'txt_unitPrice'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                          .format(servicePrice),
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'txt_quantity'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$serviceQuantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'txt_total'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                          .format(serviceTotal),
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _buttonPayment(BillViewModel billViewModel, User? user) {
    return billViewModel.bill.status == 'paid'
        ? const SizedBox(height: 10)
        : InkWell(
            onTap: () => {
              billViewModel.createPayment((widget.bill?.total?.toInt() ?? 0), widget.bill!.id!,
                  user!.id!, widget.bill!.apartment!)
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  'txt_payNow'.tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
}
