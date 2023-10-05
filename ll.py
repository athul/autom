from frappe import _
import requests
from frappe.utils import now, nowdate, add_days
device_id = "BJ2C192661859"
url = "http://172.16.60.221:9090/iclock/WebAPIService.asmx?op=GetTransactionsLog"
payload = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\r\n <soap:Body>\r\n <GetTransactionsLog xmlns=\"http://tempuri.org/\">\r\n <FromDateTime>{}</FromDateTime>\r\n <ToDateTime>{}</ToDateTime>\r\n <SerialNumber>{}</SerialNumber>\r\n <UserName>api</UserName>\r\n <UserPassword>Iftas@123</UserPassword>\r\n <strDataList></strDataList>\r\n </GetTransactionsLog>\r\n </soap:Body>\r\n</soap:Envelope>".format(str(add_days(nowdate(), -15)) + " 12:00:00", now(), device_id)
headers = {'Content-Type': 'text/xml'}
response = requests.request("POST", url, headers=headers, data=payload)
print(response)
