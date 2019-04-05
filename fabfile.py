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
def show_latest_tag():
    tag = local('git describe --tags `git rev-list --tags --max-count=1`', capture=True)
    puts(green('\n历史 tag 版本:   ' + tag + '\n'))
   

def find_podspec_file():
    current_file = os.getcwd().split('/')[-1]
    return current_file + '.podspec'


@task
def pod_version():
    podspec_file = find_podspec_file()
    f = open('./' + podspec_file, 'r')
    result = ''
    for line in f.readlines():
        if 's.version' in line:
            result = line
            break
    version = result.split('=')[1].replace("'", "").replace(" ", "").replace("\n", "")
    f.close()
    return version



@task
def pod_publish():
    show_latest_tag()
    version = pod_version()
    tag = version
    puts(green('\nspec tag 版本:   ' + version + '\n'))
    message = raw_input(green("\n请输入 tag 信息:"))
    local('git tag -a {} -m \'{}\''.format(tag, message))
    local('git push origin {}'.format(tag))
    pod_push()

@task
def pod_push():
    local('pod trunk push GesturePassword.podspec')

