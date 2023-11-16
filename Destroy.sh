if [ ${ACTION} = "destroy" ] ; then

    ~/kubectl delete -n dev -f K8_Manifests/Dev_Web_Manifest.yaml
fi