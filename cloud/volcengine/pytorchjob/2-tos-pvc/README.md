# 2-tos-pvc

This directory goes through the creation, mounting, and deletion of a PVC,
using volcengine's object store.

Basically those YAMLs are copied from: https://www.volcengine.com/docs/6460/101643

## Dirty solution on secret 

An opaque secret is created via the console, called `kubeflow/chenweiwen-key`.
If time permits, I'd like create a secret with kubectl, but I don't have the time.
