test:
    docker build . -t elasticsearch

upload:
    rsync -avP -e 'ssh -J dev5' ./ xmh-es:es-dockercompose
