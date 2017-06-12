docker-cpu: Dockerfile.cpu
	sudo docker build -t ailabs/face-swap:cpu -f $< .

docker-gpu: Dockerfile.gpu
	sudo docker build -t ailabs/face-swap:gpu -f $< .
