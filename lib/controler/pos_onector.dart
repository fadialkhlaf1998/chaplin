import 'package:http/http.dart' as http;

class POS_Conecter{
  static String token="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6ImdDN25CdHNHQmVFRzZlRXIifQ.eyJpc3MiOiJodHRwczovL2FwaS5zdGFnaW5nLmRlbGl2ZXJlY3QuY29tIiwiYXVkIjoiaHR0cHM6Ly9hcGkuZGVsaXZlcmVjdC5jb20iLCJleHAiOjE2MzI2NDM2MDYsImlhdCI6MTYzMjU1NzIwNiwic3ViIjoieVVJWmFiNFZRNzc2VjB3TkBjbGllbnRzIiwiYXpwIjoieVVJWmFiNFZRNzc2VjB3TiIsInNjb3BlIjoiZ2VuZXJpY0NoYW5uZWw6bWF4YXJ0In0.sT7fwguWXO0TU0gp4tJJ39aI8e1ERtzLhtj66dESbCCO830644xYLYGKboxSb2Nsjj24t2XIPGVyd7d3mgBnUadbptKWspgbFiUGKcRBia-BKDF_cgYdB9RG68P_PgkE00r1GDtrwuIclopr7y3Cy2ule4X-2hxocHvUaOL35-KIsTw96TDjVGHxVcFapdQV8GHyeVRm--vWNW1Z5q45EmV3ob3VpwNQx0OHCPUeIhH-b8xOv4g6xR06ZKzxUndOLUuAjZk_VZXY-z3jaj0UkENLpELyopfgwbW-u2DNR6bU2O9uouhiSw5y4uN00TdfOlfekLagH9DoH-Nwzws04g";

  static get_acount()async{
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };
    var request = http.Request('GET', Uri.parse('https://api.staging.deliverect.com/accounts'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }

}