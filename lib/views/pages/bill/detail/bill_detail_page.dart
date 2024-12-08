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

class _BillDetailPageState extends State<BillDetailPage>
    with WidgetsBindingObserver {
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
    final totalVehicleFee = widget.bill?.listVehicle
        ?.map((vehicle) => vehicle.total ?? 0)
        .reduce((value, element) => value + element) ?? 0;
    final user = HiveProvider().getUser();
    return ChangeNotifierProvider(
      create: (context) => billViewModel..getBillById(widget.bill!.id ?? ""),
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('txt_billDetail'.tr(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: ColorApp().cl1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, (billViewModel.bill.status == 'paid'));
            },
          ),
        ),
        body: Consumer<BillViewModel>(
          builder: (context, billViewModel, child) {
            return billViewModel.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          color: ColorApp().white,
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _buildSumary(billViewModel),
                                         Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "Phí xe: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(totalVehicleFee)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        _buildListView(),
                                         Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "Phí điện: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.electric)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        _buildElectric(),
                                         Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "Phí nước: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.water)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        _buildWater(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "Phí quản lý: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.managementFee)}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        _buildManagementFee(),
                                      ]
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                      ),
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
                    ],
                  )
                : const SizedBox(),

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
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Loại',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Phí',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'SL',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tổng',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            ...widget.bill?.listVehicle
                ?.where((vehicle) => vehicle.quantity != 0)
                .map((vehicle) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          vehicle.type ?? "",
                          style: const TextStyle(
                            fontSize: 14, // Giảm kích thước font chữ
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(vehicle.price),
                          style: const TextStyle(
                            fontSize: 14, // Giảm kích thước font chữ
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          vehicle.quantity!.round().toString(),
                          style: const TextStyle(
                            fontSize: 14, // Giảm kích thước font chữ
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                              .format(vehicle.total),
                          style: const TextStyle(
                            fontSize: 14, // Giảm kích thước font chữ
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList() ??
                [],
          ],
        ),
      ),
    ),
  );
}

  _buttonPayment(BillViewModel billViewModel, User? user) {
    return billViewModel.bill.status == 'paid'
        ? const SizedBox(height: 10)
        : InkWell(
            onTap: () => {
              billViewModel.createPayment((widget.bill?.total?.toInt() ?? 0),
                  widget.bill!.id!, user!.id!, widget.bill!.apartment!)
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

  _buildElectric() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              border: TableBorder.all(color: Colors.grey),
              children: [
                _buildTableRow("Số cũ", widget.bill?.oldElectricNumber.toString() ?? ""),
                _buildTableRow("Số mới", widget.bill?.newElectricNumber.toString() ?? ""),
                _buildTableRow("Tiêu thụ", ((widget.bill?.newElectricNumber ?? 0) - (widget.bill?.oldElectricNumber ?? 0)).toString()),
                _buildTableRow("Định mức", widget.bill?.eQuota.toString() ?? ""),
                
              ],
            ),
            const SizedBox(height: 8),
            Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Định mức',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tiêu thụ',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Đơn giá',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Thành tiền',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if( widget.bill?.eQuota == 1)
            TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${(widget.bill?.newElectricNumber ?? 0) - (widget.bill?.oldElectricNumber ?? 0)}",
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.eQuota1),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(((widget.bill?.newElectricNumber ?? 0) - (widget.bill?.oldElectricNumber ?? 0)) * (widget.bill?.eQuota1 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              )
            else if( widget.bill?.eQuota == 2) ...[
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                   const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "50",
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.eQuota1),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(50* (widget.bill?.eQuota1 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
               TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                       "${(widget.bill?.newElectricNumber ?? 0) - (widget.bill?.oldElectricNumber ?? 0)-50}",
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.eQuota2),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(((widget.bill?.newElectricNumber ?? 0) - (widget.bill?.oldElectricNumber ?? 0)-50) * (widget.bill?.eQuota2 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              ]
            
            else if (widget.bill?.eQuota == 3) ...[
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                   const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "50",
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.eQuota1),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(50 * (widget.bill?.eQuota1 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                    const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                       "50",
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.eQuota2),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(50 * (widget.bill?.eQuota2 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '3',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                       "${(widget.bill?.newElectricNumber ?? 0) - (widget.bill?.oldElectricNumber ?? 0)-100}",
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.eQuota3),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(((widget.bill?.newElectricNumber ?? 0) - (widget.bill?.oldElectricNumber ?? 0)-100) * (widget.bill?.eQuota3 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
          ],
          ]
        ),
            ]
        ),
      ),
    ),
  );
}

_buildWater() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              border: TableBorder.all(color: Colors.grey),
              children: [
                _buildTableRow("Số cũ", widget.bill?.oldWaterNumber.toString() ?? ""),
                _buildTableRow("Số mới", widget.bill?.newWaterNumber.toString() ?? ""),
                _buildTableRow("Tiêu thụ", ((widget.bill?.newWaterNumber ?? 0) - (widget.bill?.oldWaterNumber ?? 0)).toString()),
                _buildTableRow("Định mức", widget.bill?.wQuota.toString() ?? ""),
              ],
            ),
            const SizedBox(height: 8),
            Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: Colors.grey),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Định mức',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tiêu thụ',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Đơn giá',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Thành tiền',
                    style: TextStyle(
                      fontSize: 14, // Giảm kích thước font chữ
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if( widget.bill?.wQuota == 1)
            TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${(widget.bill?.newWaterNumber ?? 0) - (widget.bill?.oldWaterNumber ?? 0)}",
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.wQuota1),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(((widget.bill?.newWaterNumber ?? 0) - (widget.bill?.oldWaterNumber ?? 0)) * (widget.bill?.wQuota1 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              )
            else if( widget.bill?.wQuota == 2) ...[
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                   const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "4",
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.wQuota1),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(4* (widget.bill?.wQuota1 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
               TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                       "${(widget.bill?.newWaterNumber ?? 0) - (widget.bill?.oldWaterNumber ?? 0)-4}",
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.wQuota2),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(((widget.bill?.newWaterNumber ?? 0) - (widget.bill?.oldWaterNumber ?? 0)-4) * (widget.bill?.wQuota2 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              ]
            
            else if (widget.bill?.eQuota == 3) ...[
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '1',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                   const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "4",
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.wQuota1),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(4 * (widget.bill?.wQuota1 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '2',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                    const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                       "6",
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.wQuota2),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(6 * (widget.bill?.wQuota2 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '3',
                      style: TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                       "${(widget.bill?.newWaterNumber ?? 0) - (widget.bill?.oldWaterNumber ?? 0)-10}",
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.wQuota3),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(((widget.bill?.newWaterNumber ?? 0) - (widget.bill?.oldWaterNumber ?? 0)-10) * (widget.bill?.wQuota3 ?? 0)),
                      style: const TextStyle(
                        fontSize: 14, // Giảm kích thước font chữ
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
          ],
          ]
        ),
          ],
        ),
      ),
    ),
  );
}

_buildManagementFee() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          border: TableBorder.all(color: Colors.grey),
          children: [
            _buildTableRow("Đơn giá", NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.managementPrice)),
            _buildTableRow("Diện tích", (widget.bill?.managementPrice != null && widget.bill?.managementFee != null)
                ? "${widget.bill!.managementFee! / widget.bill!.managementPrice!} m2"
                : ""),
            _buildTableRow("Thành tiền", NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.bill?.managementFee)),
          ],
        ),
      ),
    ),
  );
}

TableRow _buildTableRow(String label, String value) {
  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    ],
  );
}
}
