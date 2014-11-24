lighttpdのリバースプロキシをテストするためのDockerfile 
なおまだできていない模様。

docker run --privileged=true --name lighttpd -d -t -i -v <host path>:/root/lighttpd:rw lighttpd 
で起動すると/root/lighttpdにホストファイルの<path>がマウントされるので適当にいじると良い
(aclocalやらのautomake周りのlibraryはinstallされていないのでそこら辺ミスるかも)

基本的に/root/lighttpd内にはlighttpdのソースが入るようになっている。

