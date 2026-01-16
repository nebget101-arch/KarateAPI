function fn() {
  var config = {
    baseUrl: 'https://jsonplaceholder.typicode.com'
  };
  
  if (karate.env == 'prod') {
    config.baseUrl = 'https://api.example.com';
  }
  
  return config;
}
