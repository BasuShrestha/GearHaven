import 'package:get_ip_address/get_ip_address.dart';

var ip = IpAddress();

Future<String> getIp() async {
  dynamic data = await ip.getIpAddress();
  return data;
}

// String getDeviceIp = () async {
//   String ip = await getIp();
//   return ip;
// };
const ipAddress = '172.16.17.73';
const port = '5000';

const baseUrl = 'http://$ipAddress:$port';

var getProductImageUrl = (imageUrl) {
  return '$baseUrl/product_images/$imageUrl';
};

var getUserImageUrl = (imageUrl) {
  return '$baseUrl/images/$imageUrl';
};
