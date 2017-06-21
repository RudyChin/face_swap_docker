docker-cpu: Dockerfile.cpu
	sudo docker build -t ailabs/face-swap:cpu -f $< .

docker-gpu: Dockerfile.gpu
	sudo docker build -t ailabs/face-swap:gpu -f $< .

docker-gpu-opengl: Dockerfile.opengl
	sudo docker build -t ailabs/face-swap:gpu-opengl -f $< .

docker-cpu-opengl: Dockerfile.cpu.opengl
	sudo docker build -t ailabs/face-swap:cpu-opengl -f $< .

