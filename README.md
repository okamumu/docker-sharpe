# Build image

1. Get codes from GitHub

```
git clone https://github.com/okamumu/docker-sharpe.git
cd docker-sharpe
git clone https://github.com/sharpe-duke/SHARPE.git
```

2. Build images for debug and release

```
sh build_images.sh
```

3. Run with the image

```
docker run -it --rm -v $(pwd):/app sharpe:debug example.sharpe
```

```
docker run -it --rm -v $(pwd):/app sharpe:release example.sharpe
```
