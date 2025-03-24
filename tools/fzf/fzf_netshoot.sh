#!/bin/bash

# 名前空間を取得してfzfでフィルタリング
NAMESPACE=$(kubectl get namespaces --no-headers | awk '{print $1}' | fzf --height 40% --reverse --header "Select Name
space")

# ユーザーが名前空間を選択しなかった場合は終了
if [ -z "$NAMESPACE" ]; then
  echo "No namespace selected. Exiting."
  exit 1
fi

# 選択した名前空間にデプロイ
echo "Selected Namespace: $NAMESPACE"
echo "Deploying tmp-shell in the selected namespace..."

kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot -n "$NAMESPACE"
