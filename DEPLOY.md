VERSION=0.6
git tag v$VERSION
git push origin v$VERSION
docker build . -t timcharper/mcli:$VERSION 
docker tag timcharper/mcli:$VERSION timcharper/mcli:latest
docker push timcharper/mcli:$VERSION 
docker push timcharper/mcli:latest
