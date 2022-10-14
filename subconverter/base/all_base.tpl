{% if request.target == "clash" or request.target == "clashr" %}

# https://github.com/Dreamacro/clash/wiki/configuration
mixed-port: 7890
allow-lan: false
bind-address: "*"
ipv6: true
log-level: silent
mode: rule
external-controller: '127.0.0.1:9090'
profile:
  store-selected: false
  store-fake-ip: true

dns:
  enable: true
  ipv6: true
  listen: 0.0.0.0:5353
  enhanced-mode: fake-ip
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - +.stun.*.*.*.*.*
    - "*.n.n.srv.nintendo.net"
    - +.stun.playstation.net
    - xbox.*.*.microsoft.com
    - "*.*.xboxlive.com"
    - "*.msftncsi.com"
    - "*.msftconnecttest.com"
    - WORKGROUP
  nameserver:
{% if default(request.clash.dot, "true") == "true" %}
    - "tls://dns.alidns.com:853"
    - "tls://dot.pub:853"
{% endif %}
{% if default(request.clash.doh, "true") == "true" %}
    - "https://dns.alidns.com/dns-query"
    - "https://doh.pub/dns-query"
{% else %}
    - 223.5.5.5
    - 223.6.6.6
    - "[2400:3200::1]:53"
    - "[2400:3200:baba::1]:53"
    - 119.29.29.29
    - "[2402:4e00::]:53"
{% endif %}
  fallback:
{% if default(request.clash.dot, "true") == "true" %}
    - "tls://1.1.1.1:853"
    - "tls://8.8.4.4:853"
    - "tls://dns10.quad9.net:853"
    - "tls://security-filter-dns.cleanbrowsing.org:853"
    - "tls://uncensored.dns.dnswarden.com:853"
{% endif %}
{% if default(request.clash.doh, "true") == "true" %}
    - "https://cloudflare-dns.com/dns-query"
    - "https://dns.google/dns-query"
    - "https://dns10.quad9.net/dns-query"
    - "https://doh.cleanbrowsing.org/doh/security-filter/"
    - "https://dns.dnswarden.com/uncensored"
{% else %}
    - 1.1.1.1
    - 1.0.0.1
    - "[2606:4700:4700::1111]:53"
    - "[2606:4700:4700::1001]:53"
    - 8.8.8.8
    - 8.8.4.4
    - "[2001:4860:4860::8888]:53"
    - "[2001:4860:4860::8844]:53"
    - 9.9.9.10
    - 149.112.112.10
    - "[2620:fe::10]:53"
    - "[2620:fe::fe:10]:53"
    - 185.228.168.9
    - 185.228.169.9
    - "[2a0d:2a00:1::2]:53"
    - "[2a0d:2a00:2::2]:53"
{% endif %}
  fallback-filter:
    geoip: true
    geoip-code: CN

{% if local.clash.new_field_name == "true" %}
proxies: ~
proxy-groups: ~
rules: ~
{% else %}
Proxy: ~
Proxy Group: ~
Rule: ~
{% endif %}

{% endif %}

{% if request.target == "surge" %}

[General]
loglevel = notify
bypass-system = true
skip-proxy = 127.0.0.1,192.168.0.0/16,10.0.0.0/8,172.16.0.0/12,100.64.0.0/10,localhost,*.local,e.crashlytics.com,captive.apple.com,::ffff:0:0:0:0/1,::ffff:128:0:0:0/1
#DNS设置或根据自己网络情况进行相应设置
bypass-tun = 192.168.0.0/16,10.0.0.0/8,172.16.0.0/12

{% if default(request.doh, "false") == "true" %}
doh-server = https://dns.alidns.com/dns-query
{% else %}
dns-server = 119.29.29.29,223.5.5.5
{% endif %}

[Script]
http-request https?:\/\/.*\.iqiyi\.com\/.*authcookie= script-path=https://raw.githubusercontent.com/NobyDa/Script/master/iQIYI-DailyBonus/iQIYI.js

{% endif %}

{% if request.target == "loon" %}

[General]
skip-proxy = 192.168.0.0/16,10.0.0.0/8,172.16.0.0/12,localhost,*.local,e.crashlynatics.com
bypass-tun = 10.0.0.0/8,100.64.0.0/10,127.0.0.0/8,169.254.0.0/16,172.16.0.0/12,192.0.0.0/24,192.0.2.0/24,192.88.99.0/24,192.168.0.0/16,198.18.0.0/15,198.51.100.0/24,203.0.113.0/24,224.0.0.0/4,255.255.255.255/32
dns-server = system,119.29.29.29,223.5.5.5
allow-udp-proxy = false
host = 127.0.0.1

[Proxy]

[Remote Proxy]

[Proxy Group]

[Rule]

[Remote Rule]

[URL Rewrite]
enable = true
^https?:\/\/(www.)?(g|google)\.cn https://www.google.com 302

[Remote Rewrite]
https://raw.githubusercontent.com/Loon0x00/LoonExampleConfig/master/Rewrite/AutoRewrite_Example.list,auto

[MITM]
hostname = *.example.com,*.sample.com
enable = true
skip-server-cert-verify = true
#ca-p12 =
#ca-passphrase =

{% endif %}

{% if request.target == "quan" %}

[SERVER]

[SOURCE]

[BACKUP-SERVER]

[SUSPEND-SSID]

[POLICY]

[DNS]
119.29.29.29

[REWRITE]

[URL-REJECTION]

[TCP]

[GLOBAL]

[HOST]

[STATE]
STATE,AUTO

[MITM]

{% endif %}

{% if request.target == "quanx" %}

[general]
excluded_routes=192.168.0.0/16, 172.16.0.0/12, 100.64.0.0/10, 10.0.0.0/8
geo_location_checker=http://ip-api.com/json/?lang=zh-CN, https://github.com/KOP-XIAO/QuantumultX/raw/master/Scripts/IP_API.js
network_check_url=http://www.baidu.com/
server_check_url=http://www.gstatic.com/generate_204

[dns]
server=119.29.29.29
server=223.5.5.5

[policy]
static=♻️ 自动选择, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/Auto.png
static=🚀 节点选择, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/Proxy.png
static=🌎 国外媒体, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/GlobalMedia.png
static=🇨🇳 国内媒体, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/DomesticMedia.png
static=Ⓜ️ 微软服务, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/Microsoft.png
static=🤖 电报信息, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/Telegram.png
static=🍎 苹果服务, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/Apple.png
static=🎯 全球直连, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/Direct.png
static=🚫 全球拦截, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/Advertising.png
static=🐠 漏网之鱼, direct, img-url=https://raw.githubusercontent.com/Koolson/Qure/master/IconSet/Final.png

[server_remote]

[filter_remote]

[rewrite_remote]

[server_local]

[filter_local]

[rewrite_local]

[mitm]

{% endif %}

{% if request.target == "mellow" %}

[Endpoint]
DIRECT, builtin, freedom, domainStrategy=UseIP
REJECT, builtin, blackhole
Dns-Out, builtin, dns

[Routing]
domainStrategy = IPIfNonMatch

[Dns]
hijack = Dns-Out
clientIp = 119.29.29.29

[DnsServer]
localhost
119.29.29.29

[DnsRule]
DOMAIN-KEYWORD, geosite:geolocation-!cn, Remote
DOMAIN-SUFFIX, google.com, Remote

[DnsHost]
doubleclick.net = 127.0.0.1

[Log]
loglevel = warning

{% endif %}

{% if request.target == "surfboard" %}

[General]
loglevel = notify
interface = 127.0.0.1
skip-proxy = 127.0.0.1, 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, 100.64.0.0/10, localhost, *.local
ipv6 = false
dns-server = system, 119.29.29.29, 223.5.5.5
exclude-simple-hostnames = true
enhanced-mode-by-rule = true
{% endif %}

{% if request.target == "sssub" %}
{
  "route": "bypass-lan-china",
  "remote_dns": "dns.google",
  "ipv6": false,
  "metered": false,
  "proxy_apps": {
    "enabled": false,
    "bypass": true,
    "android_list": [
      "com.eg.android.AlipayGphone",
      "com.wudaokou.hippo",
      "com.zhihu.android"
    ]
  },
  "udpdns": false
}

{% endif %}
