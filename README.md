# InnovateMart EKS Deployment – Project Bedrock

**Student:** Ogbuinya Johnmark Chisom  
**AltSchool ID:** ALT/SOE/024/1754

---

## 📌 Overview
This project is my solution to the AltSchool Cloud Engineering Semester 3, Month 2 assessment.  
The goal was to deploy **InnovateMart’s Retail Store Application** to AWS **Elastic Kubernetes Service (EKS)** with automation, security, and scalability best practices.  

The implementation covers:  
- **Infrastructure as Code (IaC)** using Terraform  
- **Kubernetes deployment** of microservices  
- **CI/CD automation** with GitHub Actions  
- **IAM roles and developer access**  


---

## 🚀 Step 1: Provisioning Infrastructure with Terraform
1. Created a **VPC** and stored the variables in in terraform.tfvars 
   ![Screenshot](screenshot/vpc.png)

3. Added **Internet Gateway** and NAT Gateway for private subnet access.  
   ![Screenshot](screenshot/igw.png)

4. Configured **route tables**:  
   - Public subnets → `0.0.0.0/0` to IGW  
   - Private subnets → `0.0.0.0/0` to NAT Gateway  
   ![Screenshot](screenshot/routetable.png)

5. Provisioned **EKS cluster**:  
   - Cluster Name: `innovatemart-cluster`  
   - Kubernetes Version: `1.30`  
   - Node Group: `t3.small`, Desired: 2, Min: 2, Max: 4  
   ![Screenshot](screenshot/ekscluster.png)

6. Created **IAM roles & policies** for:  
   - EKS cluster  
   - Node group  
   - Read-only developer user  

---

## 🌐 Step 2: Deploying the Retail Store Application
1. Configure `kubectl` to connect to EKS:
```bash
aws eks update-kubeconfig --name innovatemart-cluster --region us-east-1
kubectl get nodes
