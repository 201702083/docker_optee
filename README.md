Dockerfile for OP-TEE
=====================

# Intel osx를 위한 OPTEE 설치입니다.
다른 환경이라면 https://github.com/jbech-linaro/docker_optee 을 따라 진행해주세요.
### XQuartz가 없다면 아래 쉘을 통해 XQuartz 설치 및 실행을 합니다
```bash
$ ./init.sh
```
------
### 1. Dockerfile 사용하여 직접 빌드 (권장)

해당 레포지토리를 클론 & 이동 후 Dockerfile을 이용해 optee 로 이미지를 만들어주세요.
약 30분의 시간이 소요됩니다.

```bash
$ git clone <this_repository>
$ cd <this_repository>
$ docker build -t optee .
```
쉘 스크립트 혹은 docker cli를 이용해 optee 컨테이너를 생성합니다.
 - 빌드한 optee 이미지로 container를 가동합니다.
 - normal world와 secure world의 terminal을 x11 display로 보기위해 Display 옵션과 .X11-unix 볼륨을 마운트합니다.
```bash
$ ./intel-os-run.sh
```
```bash
$ docker run -ti \
	-e DISPLAY -e XAUTHORITY=/.Xauthority \
	--net host \
	-v /tmp/.X11-unix:/tmp/.X11-unix -v ~/.Xauthority:/.Xauthority \
	optee
```
성공적으로 실행되었다면 container 내에서 아래 명령어를 통해 optee 스크립트를 빌드합니다.
```bash
$ make run
```
이 과정에서 약 30 ~ 60분 정도 소요되었습니다.
<br>build후 XQuartz에 2개의 새로운 터미널 창 normal world, secure world가 생성되었다면 성공입니다.<br><br>

**주의**
- 빌드를 마친 이미지를 삭제하는 경우 처음부터 다시 수행해야 합니다..
------
### 2. 빌드된 이미지 사용 ( 작성자의 Local 환경에서 빌드한 이미지라 오류 가능성 있음 )
해당 레포지토리를 클론 & 이동 후 Dockerfile을 이용해 optee 로 이미지를 만들어주세요.
약 30분의 시간이 소요됩니다.

```bash
$ git clone <this_repository>
$ cd <this_repository>
$ docker build -t optee .
```
빌드한 optee 이미지로 container를 가동합니다.
normal world와 secure world의 terminal을 x11 display로 보기위해 Display 옵션과 .X11-unix 볼륨을 마운트합니다. <br><br>

이제 아래 쉘 스크립트를 사용해 optee-v1 image를 pull하여 컨테이너를 생성합니다.<br>
약 9GB의 이미지이므로 pull 과정이 오래 걸릴 수 있습니다.
```bash
$ ./intel-os-run-with-builtImage.sh
```
성공적으로 실행되었다면 container 내에서 아래 명령어를 통해 optee 실행합니다.

```bash
$ make run
```


## Trouble shooting
> ---
> ### c++: fatal error: Killed signal terminated program cc1plus
> - memory 부족 문제, 빌드한 내용은 유지되므로 계속해서 빌드 시도를 하면 됩니다.
>   - 0 ~ 30% build -> failed.. -> 30% ~ 60% -> failed .. -> .. -> build success !
