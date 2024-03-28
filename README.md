# kaif-app

Вітаємо в репозиторії проекту "kaif-app", який розроблено з використанням Next.js!

![Next.js Logo](/img/nextjs.jpg)

## Огляд

Проект "kaif-app" є тестовим проектом, створеним для демонстрації розгортання різної інфраструктури у сервісі AWS Cloud. Він показує, як можна ефективно використовувати облачні технології для розгортання та управління веб-додатками.

## Гілки Репозиторію

Репозиторій містить дві основні гілки, кожна з яких демонструє різні підходи до розгортання інфраструктури в AWS Cloud.

### 1. CloudFront

**Гілка**: [cloud_front](https://github.com/vvmarchenko/kaif-app/tree/cloud_front)

Цей сетап показує, як можна розгорнути простий веб-додаток через AWS CloudFront, використовуючи S3 Bucket та GitHub Actions для неперервної інтеграції та розгортання. Інфраструктура створена та управляється за допомогою Terraform.

Детальніше в [README бранча](https://github.com/vvmarchenko/kaif-app/tree/cloud_front).

### 2. EKS Cluster

**Гілка**: [eks_cluster](https://github.com/vvmarchenko/kaif-app/tree/eks_cluster)

У цьому сетапі демонструється розгортання додатку в сервісі AWS Elastic Kubernetes Service. Використовуються Docker для збірки додатку, AWS ECR для зберігання образів і GitHub Actions для автоматизації процесу збірки та розгортання додатку в EKS кластер. Інфраструктура також розгортається за допомогою Terraform.

Детальніше в [README бранча](https://github.com/vvmarchenko/kaif-app/tree/eks_cluster).


