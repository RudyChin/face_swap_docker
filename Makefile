docker-cpu: Dockerfile.cpu
	docker build -t ailabs/face-swap:cpu -f $< .

docker-gpu: Dockerfile.gpu
	docker build -t ailabs/face-swap:gpu -f $< .

