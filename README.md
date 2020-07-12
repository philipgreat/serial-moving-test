# serial-moving-test



## Install Lua 5.3
```
-$ curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
-$ tar -zxf lua-5.3.5.tar.gz
-$ cd lua-5.3.5
-$ make linux test
-$ sudo make install
```
## Install Luarocks

```
-$ wget https://luarocks.org/releases/luarocks-3.3.1.tar.gz
-$ tar zxpf luarocks-3.3.1.tar.gz
-$ cd luarocks-3.3.1
-$ ./configure --with-lua-include=/usr/local/include
-$ make
-$ make install

```

## Install Module

```
luarocks install --local rs232
```
Do not install librs232, it is NOT working for lua version > 5.1


