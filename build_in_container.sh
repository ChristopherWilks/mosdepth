#MEGROOT=/data7/all_megadepth
#export CPPFLAGS="-I./libdeflate_ci"
#export LDFLAGS="-L./libdeflate_ci"

if [[ ! -e libdeflate ]]; then
    ./get_libdeflate.sh
fi

export CPPFLAGS="-I../libdeflate"
export LDFLAGS="-L../libdeflate"

HTSVER=1.11
#HTSVER=1.10.2
wget https://github.com/samtools/htslib/archive/${HTSVER}.tar.gz
tar xzf ${HTSVER}.tar.gz
pushd htslib-${HTSVER}/
autoheader && autoconf && ./configure --with-libdeflate --disable-libcurl
make -j 4
popd
ln -fs htslib-${HTSVER} htslib
export LD_LIBRARY_PATH=htslib-${HTSVER}

export CPPFLAGS=
export LDFLAGS=

/nim-devel/bin/nimble install -y

nim c -a -d:static -d:release mosdepth.nim
