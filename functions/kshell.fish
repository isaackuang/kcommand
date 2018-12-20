function pod_exist
    kubectl get pod |grep $argv[1] > /dev/null
    echo $status
end

function kshell
    set haspod (pod_exist $argv[1])
    if test $haspod -eq 1
        echo "no pod found"
    else
        switch (count $argv)
            case 0
                echo "Usage: $argv <deployment-name> <command>"
            case 1
                set pods (kubectl get pods |grep -m 1 $argv[1] |cut -d ' ' -f 1)
                echo Executing sh on $pods
                command kubectl exec -it $pods -- sh
            case '*'
                set pods (kubectl get pods |grep $argv[1] |cut -d ' ' -f 1)
                for pod in $pods
                    echo Executing \" $argv[2..-1] \" on $pod
                    command kubectl exec -it $pod -- $argv[2..-1]
                end
        end
    end
end
