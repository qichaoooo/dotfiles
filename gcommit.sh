#!/bin/bash
## 用法: ./gcommit.sh 

git add -A
git status
git commit

echo "=== 提交完成 ==="
git log -1 --format='Author:    %an <%ae>%nCommitter: %cn <%ce>%nMessage:   %s'
