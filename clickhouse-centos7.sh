yum -y install git cmake wget bzip2 clang
yum -y install unixODBC-devel* openssl-devel* readline-devel* glib2-devel* libicu*
yum -y install mysql++-devel* libodb-mysql-devel* libssh-devel* libssh2-devel.* libffi*
yum -y install openssl-static libtool-ltdl-devel readline-static
 
export THREADS=$(grep -c ^processor /proc/cpuinfo)
export DISABLE_MONGODB=1
export CC=gcc-5
export CXX=g++-5
export LD_LIBRARY_PATH=/usr/lib64:/usr/local/lib64:/usr/local:/usr/local/lib/mysql:/usr/lib:$LD_LIBRARY_PATH
 
### g++
wget ftp://ftp.fu-berlin.de/unix/languages/gcc/releases/gcc-5.3.0/gcc-5.3.0.tar.bz2
tar xf gcc-5.3.0.tar.bz2
cd gcc-5.3.0
./contrib/download_prerequisites
../gcc-5.3.0/configure --enable-languages=c,c++ --disable-multilib
make -j $THREADS
make install
hash gcc g++
gcc --version
ln -s /usr/local/bin/gcc /usr/local/bin/gcc-5
ln -s /usr/local/bin/g++ /usr/local/bin/g++-5
ln -s /usr/local/bin/gcc /usr/local/bin/cc
ln -s /usr/local/bin/g++ /usr/local/bin/c++
 
### icu
wget http://download.icu-project.org/files/icu4c/50.1.2/icu4c-50_1_2-src.tgz
tar -xvf icu4c-50_1_2-src.tgz
cd icu/source/
./runConfigureICU Linux --enable-static
make
make install
cd ..
 
### glib2
wget http://ftp.gnome.org/pub/gnome/sources/glib/2.48/glib-2.48.1.tar.xz
./configure
make
make install
cd ..
 
### boost
wget http://downloads.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.bz2
tar xf boost_1_60_0.tar.bz2
cd boost_1_60_0
./bootstrap.sh
./b2 --toolset=gcc-5 -j $THREADS
./b2 install --toolset=gcc-5 -j $THREADS
cd ..
 
### zlib
wget http://prdownloads.sourceforge.net/libpng/zlib-1.2.8.tar.gz?download
mv zlib-1.2.8.tar.gz\?download zlib-1.2.8.tar.gz
tar xf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure
make
make install
cd ..
 
### mysql
wget http://dev.mysql.com/get/Downloads/MySQL-5.0/mysql-5.1.62.tar.gz
mv mysql-5.1.62.tar.gz mysql.tar.gz
tar xf mysql.tar.gz
cd mysql-5.1.62/
./configure
make
make install
ln -s /usr/local/lib/mysql/libmysqlclient_r.a /lib/libmysqlclient.a
cd ..
 
### libtool
wget http://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz
tar xf libtool-2.4.6.tar.gz
cd libtool-2.4.6
./configure
make
make install
cd ..
 
### ClickHouse
git clone git@github.com:yandex/ClickHouse.git
rm -f ../clickhouse*.deb
cd ClickHouse/dbms
cmake .
make
