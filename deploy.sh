docker build -t adamszabo76/multi-client:latest -t adamszabo76/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adamszabo76/multi-server:latest -t adamszabo76/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adamszabo76/multi-worker:latest -t adamszabo76/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push adamszabo76/multi-client:latest
docker push adamszabo76/multi-server:latest
docker push adamszabo76/multi-worker:latest
docker push adamszabo76/multi-client:$SHA
docker push adamszabo76/multi-server:$SHA
docker push adamszabo76/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=adamszabo76/multi-server:$SHA
kubectl set image deployments/client-deployment client=adamszabo76/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=adamszabo76/multi-worker:$SHA
