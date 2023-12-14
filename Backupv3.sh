#!/bin/bash

filename=`date +%Y%m%d%H%M%S%3N`

echo "Realizando compactação do diretório backup..."  
tar cvf $filename.tar backup

echo "Realizando transferência do arquivo compactado para o host de destino..."
scp -r $filename.tar root@10.0.1.2:/tmp
