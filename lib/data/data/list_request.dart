import 'package:ResiEasy/models/request_model.dart';

class ListRequest {
  static List<Request> request = [
    Request(
      title: 'Yêu cầu sửa bóng đèn',
      description: 'Cần sửa chữa ống nước tại căn hộ 101',
      status: -1,
      createAt: DateTime.parse('2022-01-01'),
      updateAt: DateTime.parse('2022-01-01'),
      image: ['assets/images/repair.jpg'],
    ),
    Request(
      title: 'Yêu cầu sửa chữa',
      description: 'Cần sửa chữa ống nước tại căn hộ 102',
      status: 3,
      createAt: DateTime.parse('2022-01-01'),
      updateAt: DateTime.parse('2022-01-01'),
      image: ['assets/images/repair.jpg'],
    ),
    Request(
      title: 'Yêu cầu sửa chữa',
      description: 'Cần sửa chữa ống nước tại căn hộ 103',
      status: 2,
      createAt: DateTime.parse('2022-01-01'),
      updateAt: DateTime.parse('2022-01-01'),
      image: ['assets/images/repair.jpg'],
    ),
    Request(
      title: 'Yêu cầu sửa chữa',
      description: 'Cần sửa chữa ống nước tại căn hộ 104',
      status: 1,
      createAt: DateTime.parse('2022-01-01'),
      updateAt: DateTime.parse('2022-01-01'),
      image: ['assets/images/repair.jpg'],
    ),
  ];
}
