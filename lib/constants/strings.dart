const appName = 'Cara';

const String baseUrl = 'https://cara-api-01.herokuapp.com/api/v1';

const HEADER_DETAILS_KEY = 'Content-Type';
const HEADER_DETAILS_VALUE = 'application/json; charset=UTF-8';
const headers = <String, String>{HEADER_DETAILS_KEY: HEADER_DETAILS_VALUE};

const String fetchUser = baseUrl + '/users/';
const String postUser = baseUrl + '/users/';
const String patchUser = baseUrl + '/users/';
const String upperBannerUrl = baseUrl + '/display/upperbanner/';
const String recommendedSalonsUrl = baseUrl + '/recommendations/salons/';
const String searchSalonsUrl = baseUrl + '/search/salons/';
const String getSalonByIdUrl = baseUrl + '/salons/';
const String getSlotsUrl = baseUrl + '/appointments/slots/';
const String bookAppointmentUrl = baseUrl + '/appointments/';
const String getUserAppointmentsUrl = baseUrl + '/appointments/users/';
const String updateAppointmentStatusUrl = baseUrl + '/appointments/update/';
