require 'active_support/core_ext/hash'

return if ARGV.empty?

xmlString = `security cms -D -i #{ARGV.first}`
data = Hash.from_xml(xmlString)

# получили значение data из mobileprovision
provision_cert_data = data['plist']['dict']['array'].map { |e| e['data'] }.compact.first

# пробегаем по всем сертификатам и собираем их данные в .pem формате
certs = `security find-identity -v login.keychain | grep -o "\\".*\\""`.split("\n").map { |e| e[1..-2] }
pems = certs.map { |e| `security find-certificate -p -c "#{e}"`.split("\n")[1..-2].join('') }
dict = Hash[pems.zip(certs)] 

# сравниваем mobileprovision data с .pem данными сертификатов, если совпадет, значит нашли сертификат для mobileprovision, 
# если не нашли, значит на машине не установлен сертификат

if dict.keys.keep_if { |e| e == provision_cert_data }.empty? 
  puts "Have no certificate for file #{ARGV.first}"
else
  puts "Your mobileprovision issued for #{dict[provision_cert_data]}"
end