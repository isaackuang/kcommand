function kpod
    switch (count $argv)
        case 0
          command kubectl get pod
        case '*'
          command kubectl get pod |grep $argv[1]
    end
end