# Build image

1. Get SHARPE source code from GitHub

```
git clone https://github.com/wangnangg/SHARPE.git
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
