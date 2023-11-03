
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# RabbitMQ Node Resource Exhaustion.
---

This incident type refers to a situation where a RabbitMQ node in a system has exhausted its resources, such as CPU, memory, or disk space. This can lead to various issues, including degraded system performance, failed message deliveries, and even system downtime. It is important to address this type of incident promptly to restore normal system operation and prevent any data loss.

### Parameters
```shell
export YOUR_NODE_NAME="PLACEHOLDER"

export NEW_CPU_ALLOCATION="PLACEHOLDER"

export NEW_MEMORY_ALLOCATION="PLACEHOLDER"
```

## Debug

### Check RabbitMQ queue sizes
```shell
sudo rabbitmqctl list_queues
```

### Check RabbitMQ node status
```shell
sudo rabbitmqctl status
```

### Check RabbitMQ node resource utilization
```shell
sudo rabbitmqctl eval 'erlang:memory().'
```

### Check system memory usage
```shell
free -m
```

### Check system CPU usage
```shell
top
```

### Check system disk usage
```shell
df -h
```

### Check RabbitMQ cluster status
```shell
sudo rabbitmqctl cluster_status
```

### Check system network usage
```shell
sudo netstat -tunap
```

## Repair

### Increase the resources allocated to the RabbitMQ node, such as CPU, memory, and disk space.
```shell
bash

#!/bin/bash



# Define the RabbitMQ node name and desired resource allocation

NODE_NAME=${YOUR_NODE_NAME}

CPU_ALLOCATION=${NEW_CPU_ALLOCATION}

MEMORY_ALLOCATION=${NEW_MEMORY_ALLOCATION}



# Stop the RabbitMQ node

sudo systemctl stop rabbitmq-server@$NODE_NAME.service



# Edit the RabbitMQ node config file to increase CPU and memory allocation

sudo sed -i "s/CPU_LIMIT=.*$/CPU_LIMIT=$CPU_ALLOCATION/" /etc/rabbitmq/rabbitmq-env.conf

sudo sed -i "s/MEMORY_LIMIT=.*$/MEMORY_LIMIT=$MEMORY_ALLOCATION/" /etc/rabbitmq/rabbitmq-env.conf



# Start the RabbitMQ node

sudo systemctl start rabbitmq-server.service



# Verify that the node is running with the new resource allocation

sudo systemctl status rabbitmq-server.service


```