docker build -t anookinov/multi-client:latest -t anookinov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anookinov/multi-server:latest -t anookinov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anookinov/multi-worker:latest -t anookinov/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anookinov/multi-client:latest
docker push anookinov/multi-server:latest
docker push anookinov/multi-worker:latest
docker push anookinov/multi-client:$SHA
docker push anookinov/multi-server:$SHA
docker push anookinov/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anookinov/multi-server:$SHA
kubectl set image deployments/client-deployment client=anookinov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anookinov/multi-worker:$SHA