prog='dbfilealter'
args='-Z none'
in='TEST/dbfilealter_compress_bzip2.out'
cmp='diff -c -b '
requires='IO::Compress::Bzip2'
