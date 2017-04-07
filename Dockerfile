FROM debian:latest
RUN apt-get -y update && apt-get install -y flex python-pip python-dev build-essential wget sudo 
RUN pip install virtualenv
RUN mkdir openfst_pywrapfst_thrax_install
RUN cd openfst_pywrapfst_thrax_install && virtualenv env
RUN cd openfst_pywrapfst_thrax_install && . env/bin/activate
RUN cd openfst_pywrapfst_thrax_install && wget http://www.openfst.org/twiki/pub/FST/FstDownload/openfst-1.6.2.tar.gz
RUN cd openfst_pywrapfst_thrax_install && tar -xvf openfst-1.6.2.tar.gz
RUN cd openfst_pywrapfst_thrax_install/openfst-1.6.2 && ./configure --enable-python --enable-far --enable-pdt --enable-mpdt  --enable-grm --prefix /openfst_pywrapfst_thrax_install/env/local/
RUN cd openfst_pywrapfst_thrax_install/openfst-1.6.2 && make 
RUN cd openfst_pywrapfst_thrax_install/openfst-1.6.2 && make install
RUN cd openfst_pywrapfst_thrax_install && wget http://openfst.cs.nyu.edu/twiki/pub/GRM/ThraxDownload/thrax-1.2.3.tar.gz
RUN cd openfst_pywrapfst_thrax_install && tar -xvf thrax-1.2.3.tar.gz 
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/openfst_pywrapfst_thrax_install/env/local/
RUN cd openfst_pywrapfst_thrax_install/thrax-1.2.3 && ./configure --prefix /openfst_pywrapfst_thrax_install/env/ LDFLAGS="-L/openfst_pywrapfst_thrax_install/env/local/lib" CPPFLAGS="-I/openfst_pywrapfst_thrax_install/env/local/include/"
RUN cd openfst_pywrapfst_thrax_install/thrax-1.2.3 && make
RUN cd openfst_pywrapfst_thrax_install/thrax-1.2.3 && make install
RUN cd openfst_pywrapfst_thrax_install && cp -r env/share/thrax/grammars .
ENV PATH=/openfst_pywrapfst_thrax_install/env/bin:/openfst_pywrapfst_thrax_install/env/local/bin/:$PATH
RUN cd openfst_pywrapfst_thrax_install/grammars/ && thraxmakedep example.grm 
RUN cd openfst_pywrapfst_thrax_install/grammars/ && make
RUN apt-get install -y expect
ENTRYPOINT cd openfst_pywrapfst_thrax_install/grammars/ && /usr/bin/expect -c 'spawn thraxrewrite-tester --far=example.far --rules=TOKENIZER; expect "Input string:"; send "Mr. Ernest Worthing, B. 4, The Albany. \n"; expect "Output string:"; interact; ' && echo "\n"

