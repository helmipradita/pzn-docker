docker container create --name smallnginx --memory 100m --cpus 0.5 --publish 8081:80 nginx:latest

``bash
286b6d12967b   contohnginx     0.00%     14.12MiB / 11.68GiB   0.12%     998B / 126B       2.51MB / 4.1kB    15
2fa34b49b532   smallnginx      0.00%     12.43MiB / 100MiB     12.43%    872B / 126B       664kB / 8.19kB    15