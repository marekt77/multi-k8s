docker build -t mtyrpa/multi-client:latest -t mtyrpa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mtyrpa/multi-server:latest -t mtyrpa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mtyrpa/multi-worker:latest -t mtyrpa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mtyrpa/multi-client:latest
docker push mtyrpa/multi-client:$SHA

docker push mtyrpa/multi-server:latest
docker push mtyrpa/multi-server:$SHA

docker push mtyrpa/multi-worker:latest
docker push mtyrpa/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mtyrpa/multi-server:$SHA
kubectl set image deployments/client-deployment client=mtyrpa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mtyrpa/multi-worker:$SHA