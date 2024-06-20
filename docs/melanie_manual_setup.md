# Installation

## Info
```
user: deerhide-operator
ssh_port: 22
```

## Sudoers configuration

### Add groups to deerhide-operator
```
groupadd admin
usermod -Ga sudo deerhide-operator
usermod -Ga admin deerhide-operator
```
### Add /etc/sudoers.d/deerhide-operator
```
deerhide-operator ALL=(ALL) NOPASSWD: ALL
```

