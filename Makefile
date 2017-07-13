docker-cpu: Dockerfile.cpu
	docker build -t ailabs/face-swap:cpu -f $< .

docker-gpu: Dockerfile.gpu
	docker build -t registry.corp.ailabs.tw/lab/face-swap:gpu -f $< .

