docker build -t xenus90/multi-client:latest -t xenus90/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xenus90/multi-server:latest -t xenus90/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xenus90/multi-worker:latest -t xenus90/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xenus90/multi-client:latest
docker push xenus90/multi-server:latest
docker push xenus90/multi-worker:latest
docker push xenus90/multi-client:$SHA
docker push xenus90/multi-server:$SHA
docker push xenus90/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=xenus90/multi-client:$SHA
kubectl set image deployments/server-deployment server=xenus90/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=xenus90/multi-worker:$SHA
