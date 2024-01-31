docker build -t tonyalex/multi-client-k8:latest -t tonyalex/multi-client-k8:$SHA -f ./client/Dockerfile ./client
docker build -t tonyalex/multi-server-k8:latest -t tonyalex/multi-server-k8:$SHA -f ./server/Dockerfile ./server
docker build -t tonyalex/multi-worker-k8:latest -t tonyalex/multi-worker-k8:$SHA -f ./worker/Dockerfile ./worker

docker push tonyalex/multi-client-k8:latest
docker push tonyalex/multi-server-k8:latest
docker push tonyalex/multi-worker-k8:latest

docker push tonyalex/multi-client-k8:$SHA
docker push tonyalex/multi-server-k8:$SHA
docker push tonyalex/multi-worker-k8:$SHA

kubectl apply -f k8s/

kubectl set image deployments/server-deployment  server=tonyalex/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment  client=tonyalex/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment  worker=tonyalex/multi-worker-k8s:$SHA
