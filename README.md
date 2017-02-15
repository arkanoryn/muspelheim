# Muspelheim project - client

> Webapplication written in Elm

## Run the server
```
$> ./run_server.sh
```

Will run a server that reload on each change files.
Run server use Webpack.

I noticed that after a few time, it breaks the Vagrant machine and I have to reboot it.
Javascript beauty... ?

## Alternative
```
elm-reactor  -a 192.168.55.55
```

It will run a server on the IP given after `-a`.
By default, the Vagrant machine IP is the one from the previous command.

Would you change Vagrant configuration, think about adapting the command.


When accessing `http://192.168.55.55:8000`, you will see the hierarchy from `root/client`.
To access your webapplication, click on: `src > Main.elm` or go directly to: `http://192.168.55.55:8000/src/Main.elm`
