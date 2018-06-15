#!/usr/bin/expect
set timeout 60
set AppName [lindex $argv 0]
set PushType [lindex $argv 1]
spawn openssl pkcs12 -clcerts -nokeys -out /Users/chenshuao/Desktop/apns-cer.pem -in /Users/chenshuao/Desktop/cer.p12
expect "Enter Import Password:"
send "\r"
spawn openssl pkcs12 -nocerts -out /Users/chenshuao/Desktop/apns-key.pem -in /Users/chenshuao/Desktop/key.p12
expect "Enter Import Password:"
send "\r"
expect "Enter PEM pass phrase:"
send "0000\r"
expect "Verifying - Enter PEM pass phrase:"
send "0000\r"
spawn openssl pkcs12 -export -in /Users/chenshuao/Desktop/apns-cer.pem -inkey /Users/chenshuao/Desktop/apns-key.pem -out /Users/chenshuao/Desktop/$AppName\_$PushType.p12
expect "Enter pass phrase for /Users/chenshuao/Desktop/apns-key.pem:"
send "0000\r"
expect "Enter Export Password:"
send "hikvision\r"
expect "Verifying - Enter Export Password:"
send "hikvision\r"
spawn openssl s_client -connect gateway.push.apple.com:2195 -cert /Users/chenshuao/Desktop/apns-cer.pem -key /Users/chenshuao/Desktop/apns-key.pem
expect "Enter pass phrase for /Users/chenshuao/Desktop/apns-key.pem:"
send "0000\r"

expect "Verify return code: 0 (ok)"
send ":wq\r"

interact
