#!/bin/bash

ssh-keygen -R 50.116.6.169
ssh-keygen -R fallinggarden.com

ssh-keygen -R 50.116.60.38
ssh-keygen -R fallingfoundry.com

scp ./geck-go.sh root@fallinggarden.com:/root/geck-go.sh
scp ./geck-go.sh root@fallingfoundry.com:/root/geck-go.sh