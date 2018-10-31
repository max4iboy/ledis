# ledis
Ledis - a simple version of a Redis server

## To run ledis on your local
1. Clone the repo
```
git clone https://github.com/max4iboy/ledis.git ~/ledis/
```
2. Run bundle
```
cd ~/ledis/
bundle
```
3. Start the DRb server
```
ruby server.rb
```
4. Start the web server
```
thin start
```
5. Use the client as a console
```
ruby cli.rb
```
