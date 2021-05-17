# GNOME Display Manager

对于Ubuntu，是GDM-Gnome显示管理器，SDDM和LightDM是其他常见的显示管理器。

##　命令行检查状态

```
sudo systemctl status gdm
```

## 停止

```
sudo systemctl stop gdm
```

## 启动

```
sudo systemctl start gdm
```

## 禁用GUI(防止在系统启动时加载)

```
sudo systemctl disable gdm
```

## sudo systemctl enable gdm

```
sudo systemctl enable gdm
```

## 其他常见命令

切换到"文本模式"

```
sudo systemctl isolate multi-user.target
```

切换到"图形模式"

```

sudo systemctl isolate graphical.target
```