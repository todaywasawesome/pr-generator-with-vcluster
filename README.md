This uses two application sets to generate a vcluster for each pull request and then a cluster generator to deploy that pull request into that vcluster. 

Once each vcluster is deployed a post-sync job will automatically add the vcluster to Argo CD.

To do this we create an Argo CD service account with the ability to add/update clusters to Argo CD.

# Generate service account token

`argocd account generate-token --account vclusteradder`

```
k create secret generic vclusteradder \
> --from-literal=password='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJhcmdvY2QiLCJzdWIiOiJ2Y2x1c3RlcmFkZGVyOmFwaUtleSIsIm5iZiI6MTcyOTI3MTUzMiwiaWF0IjoxNzI5MjcxNTMyLCJqdGkiOiIzMGUzNGFlOC1mZGFkLTQ3NWMtYTY3MC1lYWU4ZDVmNTgxNmIifQ.KY95NLTfBwcA8-Blsulok20XAArktE6Oyn5UsQ_43zw'
```