#for interactive debugging switch to just bash shell
docker run --ulimit core=-1 -it --rm --volume `pwd`:/build:rw --entrypoint=/bin/bash mosdepth -i
#docker run --ulimit core=-1 -it --rm --volume `pwd`:/build:rw --entrypoint=/build/build_in_container.sh mosdepth -i
