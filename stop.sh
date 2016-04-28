#!/bin/bash

ps -ef|grep LdpRtbServerApi|grep -v grep|awk '{print $2}'|xargs kill
