## 节点正则匹配

适用于 `subconverter\config\*.ini` , `subconverter\snippets\emoji.txt` 和 `subconverter\snippets\groups.txt` .

> 否定字符集不需要分隔符`|`, 但是断言需要.

### 香港

正则表达式:

```
^香港$|[^香港].*港.*
```

测试文本:

```
港
香港
中-港
中国-香港
港-美
香港-美国
Pro香港x4
```

### 日本

正则表达式:

```
^日本$|[^日].*日(?!利亚).*
```

测试文本:

```
日
日本
港-日
香港-日本
日-美
日本-美国
尼日利亚
Pro日本x4
```

### 台湾

正则表达式:

```
^台湾$|[^台].*台(?!负载).*|^台.*负载.*
```

测试文本:

```
台
台湾
港-台
香港-台湾
台-美
台湾-美国
多台负载均衡
台湾-多台负载均衡
🚀台湾-多台负载均衡
香港-多台负载均衡
Pro台湾x4
```

### 韩国, 新加坡, 美国

正则表达式:

```
^韩国$|[^韩].*韩.*
^新加坡$|[^新].*新.*
^美国$|[^美].*美.*
```

测试文本:

```
韩
韩国
港-韩
香港-韩国
韩-美
韩国-美国
Pro韩国x4
```