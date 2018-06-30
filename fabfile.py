# -*- coding: utf-8 -*-

import os
import sys

from fabric.colors import blue, cyan, green, magenta, red, yellow
from fabric.decorators import task
from fabric.operations import local
from fabric.state import env
from fabric.utils import puts


env.version = '0.10.2'
env.pypi_option = ' -i https://mirrors.aliyun.com/pypi/simple/'  # 如果是 http 地址，加 --trusted-host mirrors.aliyun.com


# ============
# =  Hello   =
# ============
@task(default=True, alias='别名测试')
def hello():
    puts('*' * 60)
    puts('*  ' + cyan('  Fabric 使用指南  '.center(58, '=')) + '  *')
    puts('*' + ' ' * 58 + '*')
    puts('*' + green('  查看所有命令: fab -l'.ljust(64)) + '*')
    puts('*' + green('  查看命令: fab -d 命令'.ljust(64)) + '*')
    puts('*' + yellow('  带参数命令请输入: fab 命令:参数'.ljust(70)) + '*')
    puts('*' + ' ' * 58 + '*')
    puts('*' * 60)


def get_function_name():
    return sys._getframe(1).f_code.co_name  # _getframe()则是自己的名字

@task
def pod_push():
    local('pod trunk push GesturePassword.podspec')
