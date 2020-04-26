# ROS-Jetson-Docker
ROS melodic-desktop-full のJetson用Dockerイメージを作成する．
また，コンテナ上でcatkin_make，ROSノードの起動を行えるようにする．

## インストール
```bash
#!/bin/bash
git clone https://github.com/shikishima-TasakiLab/ros-jetson-docker.git ROS-Jetson
```

## 使い方

### Dockerイメージの作成

次のコマンドでDockerイメージをビルドする．
```bash
#!/bin/bash
./ROS-Jetson/docker/build-docker.sh
```

### Dockerコンテナの起動

1. 次のコマンドでDockerコンテナを起動する．
    ```bash
    #!/bin/bash
    ./ROS-Jetson/docker/run-docker.sh
    ```
    |オプション       |パラメータ|説明                                      |既定値    |例                                           |
    |-----------------|----------|------------------------------------------|----------|---------------------------------------------|
    |`-h`, `--help`   |なし      |このヘルプを表示                          |なし      |`-h`                                         |
    |`-n`, `--name`   |NAME      |コンテナの名前を指定                      |ros-master|`-n ros-talker`                              |
    |`-e`, `--env`    |ENV=VALUE |コンテナの環境変数を指定する（複数指定可）|なし      |`-e ROS_MASTER_URI=http://192.168.2.10:11311`|
    |`-c`, `--command`|CMD       |コンテナ起動時に実行するコマンドを指定    |なし      |`-c roscore` , `-c "rosrun rviz rviz"`       |

2. ROS-BridgeのDockerコンテナで複数のROSパッケージを使用する際は，次のコマンドを別のターミナルで実行する．

    ```bash
    #!/bin/bash
    ./ROS-Jetson/docker/exec-docker.sh
    ```
    |オプション    |パラメータ|説明                |既定値|例               |
    |--------------|----------|--------------------|------|-----------------|
    |`-h`, `--help`|なし      |このヘルプを表示    |なし  |`-h`             |
    |`-i`, `--id`  |ID        |コンテナのIDを指定  |なし  |`-i 4f8eb7aeded7`|
    |`-n`, `--name`|NAME      |コンテナの名前を指定|なし  |`-n ros-talker`  |

### ROSパッケージの作成・ビルド・実行

1. `./ROS-Jetson/docker/run-docker.sh`でコンテナを起動する．

2. `~/catkin_ws/src/`にパッケージを作成する．

    ```bash
    #!/bin/bash
    cd ~/catkin_ws/src

    # パッケージを作成
    # catkin_create_pkg ...
    #
    # ソースコードを編集

    # GitHubからダウンロード
    # git clone ...
    ```

3. `~/catkin_ws`に移動して，`catkin_make`を実行

    ```bash
    #!/bin/bash
    cd ~/catkin_ws
    catkin_make
    ```

4. 次のコマンドを実行することにより，ビルドしたROSパッケージが使用可能になる．

    ```bash
    #!/bin/bash
    source ~/catkin_ws/devel/setup.bash

    # ROSノードの起動
    # rosrun ... ...
    # roslaunch ... ...
    ```