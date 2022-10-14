## 来源

- 后端原仓库: [https://github.com/tindy2013/subconverter](https://github.com/tindy2013/subconverter)

- 前端原仓库: [https://github.com/CareyWang/sub-web](https://github.com/CareyWang/sub-web)

- 规则参考: [https://github.com/ACL4SSR/ACL4SSR/tree/master/Clash](https://github.com/ACL4SSR/ACL4SSR/tree/master/Clash)

- 本项目后端版本: [tindy2013/subconverter@Release_v0.7.2](https://github.com/tindy2013/subconverter/releases/tag/v0.7.2)

- 本项目前端版本: [CareyWang/sub-web@417ea1d](https://github.com/CareyWang/sub-web/tree/417ea1d)


## subconverter

- `subconverter/subconverter`是Linux-x64执行程序, 来自[https://github.com/tindy2013/subconverter/releases/download/v0.7.2/subconverter_linux64.tar.gz](https://github.com/tindy2013/subconverter/releases/download/v0.7.2/subconverter_linux64.tar.gz)
- `subconverter/subconverter.exe`是Windows-x64执行程序, 来自[https://github.com/tindy2013/subconverter/releases/download/v0.7.2/subconverter_win64.7z](https://github.com/tindy2013/subconverter/releases/download/v0.7.2/subconverter_win64.7z)

### systemd

```bash
sudo vim /etc/systemd/system/subconverter.service
```

```
[Unit]
Description=订阅转换
After=network.target

[Service]
Type=simple
ExecStart=/home/bhsr/project/subconverter/subconverter
Restart=always
RestartSec=10
ExecStop=/bin/kill $MAINPID

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
```

```bash
sudo systemctl enable --now subconverter.service
```

### nginx代理后端

```
# upstream subconverter { 
#     server 127.0.0.1:25500;
# }

server {
    listen 80;
    listen [::]:80;
    server_name subc.bahuangshanren.tech;
    return 301 https://subc.bahuangshanren.tech$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name subc.bahuangshanren.tech; 

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_session_tickets off;
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:10m;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    ssl_certificate /usr/share/nginx/conf/subc.bahuangshanren.tech.pem;
    ssl_certificate_key /usr/share/nginx/conf/subc.bahuangshanren.tech.key;

    location / {
        proxy_pass http://127.0.0.1:25500;
        # proxy_pass http://subconverter;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## sub-web

### 开发

```bash
yarn install
```

```bash
yarn serve
```

```bash
yarn build
```

如遇报错：

```bash
  opensslErrorStack: [ 'error:03000086:digital envelope routines::initialization error' ],
  library: 'digital envelope routines',
  reason: 'unsupported',
  code: 'ERR_OSSL_EVP_UNSUPPORTED'
```

需要设置变量`NODE_OPTIONS`为`--openssl-legacy-provider`: 

#### bash

```bash
export NODE_OPTIONS=--openssl-legacy-provider
```

#### cmd

```shell
set NODE_OPTIONS="--openssl-legacy-provider"
```

#### powershell

```shell
$env:NODE_OPTIONS="--openssl-legacy-provider"
```

#### dockerfile

```bash
NODE_OPTIONS=--openssl-legacy-provider
```

### nginx代理前端

```bash
server {
    listen 80;
    listen [::]:80;
    server_name sub.bahuangshanren.tech;
    return 301 https://sub.bahuangshanren.tech$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name sub.bahuangshanren.tech; 

    if ($http_user_agent ~* (bot|spider)) {
        return 444;
    }

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;
    ssl_session_tickets off;
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:10m;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    ssl_certificate /usr/share/nginx/conf/sub.bahuangshanren.tech.pem;
    ssl_certificate_key /usr/share/nginx/conf/sub.bahuangshanren.tech.key;

    location / {
        root /home/bhsr/project/sub-web;
        expires 30d;
        valid_referers none blocked server_names 
            *.bahuangshanren.tech;
        if ($invalid_referer) {
            return 444;
        }
    }

    location ~* \.(aspx|php)$ {
        access_log off;
        log_not_found off;
        return 444;
    }
}
```