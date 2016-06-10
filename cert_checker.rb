require 'active_support/core_ext/hash'

return if ARGV.empty?

xmlString = `security cms -D -i #{ARGV.first}`
data = Hash.from_xml(xmlString)

# �������� �������� data �� mobileprovision
provision_cert_data = data['plist']['dict']['array'].map { |e| e['data'] }.compact.first

# ��������� �� ���� ������������ � �������� �� ������ � .pem �������
certs = `security find-identity -v login.keychain | grep -o "\\".*\\""`.split("\n").map { |e| e[1..-2] }
pems = certs.map { |e| `security find-certificate -p -c "#{e}"`.split("\n")[1..-2].join('') }
dict = Hash[pems.zip(certs)] 

# ���������� mobileprovision data � .pem ������� ������������, ���� ��������, ������ ����� ���������� ��� mobileprovision, 
# ���� �� �����, ������ �� ������ �� ���������� ����������

if dict.keys.keep_if { |e| e == provision_cert_data }.empty? 
  puts "Have no certificate for file #{ARGV.first}"
else
  puts "Your mobileprovision issued for #{dict[provision_cert_data]}"
end