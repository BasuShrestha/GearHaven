const ipAddress = '192.168.1.67';
const port = '5000';

const baseUrl = 'http://$ipAddress:$port';

var getProductImageUrl = (imageUrl) {
  return '$baseUrl/product_images/$imageUrl';
};

var getUserImageUrl = (imageUrl) {
  return '$baseUrl/images/$imageUrl';
};
