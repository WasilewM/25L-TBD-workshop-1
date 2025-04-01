IMPORTANT ❗ ❗ ❗ Please remember to destroy all the resources after each work session. You can recreate infrastructure by creating new PR and merging it to master.
  
![img.png](doc/figures/destroy.png)

1. Authors:

   Group 5
- Sypuła Aleksandra  
- Szarejko Łukasz  
- Wasilewski Mateusz  

   https://github.com/WasilewM/25L-TBD-workshop-1.git
   
2. Follow all steps in README.md.

3. In boostrap/variables.tf add your emails to variable "budget_channels".

4. From avaialble Github Actions select and run destroy on main branch.
   
5. Create new git branch and:
    1. Modify tasks-phase1.md file.
    
    2. Create PR from this branch to **YOUR** master and merge it to make new release. 
    
    ![release](screenshots/release.png)


6. Analyze terraform code. Play with terraform plan, terraform graph to investigate different modules.

    ![dataproc_graph](modules/dataproc/dataproc_graph.png)

`google_dataproc_cluster.tbd-dataproc-cluster`: This resource defines a Dataproc cluster in Google Cloud. Dataproc is a managed service that allows you to run computations using Apache Hadoop and Apache Spark in the cloud.

- **`google_project_service.dataproc`**: Enables the Dataproc service in the Google Cloud project, which is necessary for creating the cluster.

- **`google_dataproc_cluster.tbd-dataproc-cluster`**: Defines the Dataproc cluster:
   - **`depends_on`**: Ensures that the Dataproc service is enabled before creating the cluster.
   - **`name`**: The name of the cluster, in this case, "tbd-cluster".
   - **`project`**: Specifies the name of the project in which the cluster is created.
   - **`region`**: The region where the cluster is deployed.

- **`cluster_config`**: Section that defines the configuration of the cluster:
   - **`software_config`**: Allows the specification of the software version to be used on the cluster.
   - **`gce_cluster_config`**: Configuration related to GCE (Google Compute Engine) instances, including information about the subnet and metadata.
   - **`initialization_action`**: Specifies a script to be run during the initialization of the cluster, in this case, a script that installs Python packages.
   
- **`master_config`**: Defines the configuration for the master node:
   - **`num_instances`**: The number of instances for the master node.
   - **`machine_type`**: The machine type for the master node.
   - **`disk_config`**: Specifies the type and size of the boot disk.
   
- **`worker_config`**: Defines the configuration for worker nodes:
   - **`num_instances`**: The number of instances for the worker nodes.
   - **`machine_type`**: The machine type for the worker nodes.
   - **`disk_config`**: Specifies the type and size of the boot disk for the worker nodes.

7. Reach YARN UI
   
   Used command:  
   ```
   gcloud compute ssh tbd-cluster-m --project=tbd-2025l-310972 --zone=europe-west1-d --tunnel-through-iap -- -L 8088:localhost:8088
   ```
   ![hadoop](screenshots/hadoop2.png)
   
8. Draw an architecture diagram (e.g. in draw.io) that includes:
    1. VPC topology with service assignment to subnets
    2. Description of the components of service accounts
    3. List of buckets for disposal
    4. Description of network communication (ports, why it is necessary to specify the host for the driver) of Apache Spark running from Vertex AI Workbech
  
    ***place your diagram here***

9. Create a new PR and add costs by entering the expected consumption into Infracost
For all the resources of type: `google_artifact_registry`, `google_storage_bucket`, `google_service_networking_connection`
create a sample usage profiles and add it to the Infracost task in CI/CD pipeline. Usage file [example](https://github.com/infracost/infracost/blob/master/infracost-usage-example.yml) 


```
version: 0.1
resource_usage:
  google_artifact_registry_repository:
    storage_gb: 64
    monthly_egress_data_transfer_gb:
      europe_west1: 16
  google_storage_bucket:
    storage_gb: 128
    monthly_class_a_operations: 4096
    monthly_class_b_operations: 8192
    monthly_data_retrieval_gb: 32
    monthly_egress_data_transfer_gb:
      same_continent: 32
      worldwide: 0
      asia: 0
      china: 0
      australia: 0
  google_service_networking_connection:
    monthly_egress_data_transfer_gb:
      same_region: 16
      europe: 16
      us_or_canada: 0
      asia: 0
      south_america: 0
      oceania: 0
      worldwide: 16
```

   ![infracost](screenshots/infracost.png)
   
10. Create a BigQuery dataset and an external table using SQL
    
    ***place the code and output here***
   
    ***why does ORC not require a table schema?***

11. Find and correct the error in spark-job.py

    ***describe the cause and how to find the error***

12. Add support for preemptible/spot instances in a Dataproc cluster

    ***place the link to the modified file and inserted terraform code***
    
    
