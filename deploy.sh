
docker build -t codesjl/multi-client:latest -t codesjl/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t codesjl/multi-server:latest -t codesjl/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t codesjl/multi-worker:latest -t codesjl/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push codesjl/multi-client:latest
docker push codesjl/multi-server:latest
docker push codesjl/multi-worker:latest

docker push codesjl/multi-client:$SHA
docker push codesjl/multi-server:$SHA
docker push codesjl/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=codesjl/multi-server:$SHA
kubectl set image deployments/client-deployment client=codesjl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=codesjl/multi-worker:$SHA
