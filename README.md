




[![Massdriver][logo]][website]

# azure-mysql-flexible-server

[![Release][release_shield]][release_url]
[![Contributors][contributors_shield]][contributors_url]
[![Forks][forks_shield]][forks_url]
[![Stargazers][stars_shield]][stars_url]
[![Issues][issues_shield]][issues_url]
[![MIT License][license_shield]][license_url]

<!--
##### STILL NEED TO GET SLACK WORKING ###
[!["Slack Community"](%s)][slack]
-->


Azure Database for MySQL Flexible Server is a fully managed production-ready database service designed for more granular control and flexibility over database management functions and configuration settings.


---

## Design

For detailed information, check out our [Operator Guide](operator.mdx) for this bundle.

## Usage

Our bundles aren't intended to be used locally, outside of testing. Instead, our bundles are designed to be configured, connected, deployed and monitored in the [Massdriver][website] platform.

### What are Bundles?

Bundles are the basic building blocks of infrastructure, applications, and architectures in [Massdriver][website]. Read more [here](https://docs.massdriver.cloud/concepts/bundles).

## Bundle

### Params

Form input parameters for configuring a bundle for deployment.

<details>
<summary>View</summary>

<!-- PARAMS:START -->
## Properties

- **`backup`** *(object)*
  - **`backup_retention_days`** *(integer)*: How many days to retain MySQL database backups (minimum of 1, maximum of 35). Minimum: `1`. Maximum: `35`. Default: `7`.
- **`database`** *(object)*
  - **`cidr`** *(string)*: Specify a /28 CIDR range within your vnet to create subnet for the database. The subnet CIDR cannot be changed after creation.
  - **`high_availability`** *(boolean)*: Default: `False`.
  - **`mysql_version`** *(string)*: The version of MySQL to use. The version cannot be changed. Must be one of: `['8.0.21', '5.7']`. Default: `5.7`.
  - **`sku_name`** *(string)*: Select the amount of cores, memory, and max iops you need for your workload (D = General Purpose, E = Memory Optimized).
    - **One of**
      - D2ds (2 vCores, 8 GiB memory, 3200 max iops)
      - D4ds (4 vCores, 16 GiB memory, 6400 max iops)
      - D8ds (8 vCores, 32 GiB memory, 12800 max iops)
      - D16ds (16 vCores, 64 GiB memory, 18000 max iops)
      - D32ds (32 vCores, 128 GiB memory, 18000 max iops)
      - D48ds (48 vCores, 192 GiB memory, 18000 max iops)
      - D64ds (64 vCores, 256 GiB memory, 18000 max iops)
      - E2ds (2 vCores, 16 GiB memory, 3200 max iops)
      - E4ds (4 vCores, 32 GiB memory, 6400 max iops)
      - E8ds (8 vCores, 64 GiB memory, 12800 max iops)
      - E16ds (16 vCores, 128 GiB memory, 18000 max iops)
      - E32ds (32 vCores, 256 GiB memory, 18000 max iops)
      - E48ds (48 vCores, 384 GiB memory, 18000 max iops)
      - E64ds (64 vCores, 432 GiB memory, 18000 max iops)
  - **`storage_gb`** *(integer)*: The storage you provision is the amount of storage capacity available to your Azure Database for MySQL server. Storage size cannot be scaled down.
    - **One of**
      - 20GB
      - 32GB
      - 64GB
      - 128GB
      - 256GB
      - 512GB
      - 1TB
      - 2TB
      - 4TB
      - 8TB
      - 16TB
  - **`username`** *(string)*: The administrator login for the MySQL Flexible Server. Username cannot be changed after creation. (Username cannot be 'admin', 'root', 'administrator', 'username', 'azure_superuser', 'azure_pg_admin', 'guest', or 'public'.).
## Examples

  ```json
  {
      "__name": "Development",
      "backup": {
          "backup_retention_days": 1
      },
      "database": {
          "high_availability": false,
          "sku_name": "GP_Standard_D2ds_v4",
          "storage_gb": 32
      }
  }
  ```

  ```json
  {
      "__name": "Production",
      "backup": {
          "backup_retention_days": 30
      },
      "database": {
          "high_availability": true,
          "sku_name": "MO_Standard_E4ds_v4",
          "storage_gb": 256
      }
  }
  ```

<!-- PARAMS:END -->

</details>

### Connections

Connections from other bundles that this bundle depends on.

<details>
<summary>View</summary>

<!-- CONNECTIONS:START -->
## Properties

- **`azure_service_principal`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`client_id`** *(string)*: A valid UUID field.

      Examples:
      ```json
      "123xyz99-ab34-56cd-e7f8-456abc1q2w3e"
      ```

    - **`client_secret`** *(string)*
    - **`subscription_id`** *(string)*: A valid UUID field.

      Examples:
      ```json
      "123xyz99-ab34-56cd-e7f8-456abc1q2w3e"
      ```

    - **`tenant_id`** *(string)*: A valid UUID field.

      Examples:
      ```json
      "123xyz99-ab34-56cd-e7f8-456abc1q2w3e"
      ```

  - **`specs`** *(object)*
- **`vnet`** *(object)*: . Cannot contain additional properties.
  - **`data`** *(object)*
    - **`infrastructure`** *(object)*
      - **`cidr`** *(string)*

        Examples:
        ```json
        "10.100.0.0/16"
        ```

        ```json
        "192.24.12.0/22"
        ```

      - **`default_subnet_id`** *(string)*: Azure Resource ID.

        Examples:
        ```json
        "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
        ```

      - **`id`** *(string)*: Azure Resource ID.

        Examples:
        ```json
        "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
        ```

  - **`specs`** *(object)*
    - **`azure`** *(object)*: .
      - **`region`** *(string)*: Select the Azure region you'd like to provision your resources in.
        - **One of**
          - East US
          - North Central US
          - South Central US
          - West US
<!-- CONNECTIONS:END -->

</details>

### Artifacts

Resources created by this bundle that can be connected to other bundles.

<details>
<summary>View</summary>

<!-- ARTIFACTS:START -->
## Properties

- **`authentication`** *(object)*: Authentication parameters for a MySQL database. Cannot contain additional properties.
  - **`data`** *(object)*: Cannot contain additional properties.
    - **`authentication`** *(object)*
      - **`hostname`** *(string)*
      - **`password`** *(string)*
      - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
      - **`username`** *(string)*
    - **`infrastructure`** *(object)*: Cloud specific MySQL configuration data.
      - **One of**
        - AWS Infrastructure ARN*object*: Minimal AWS Infrastructure Config. Cannot contain additional properties.
          - **`arn`** *(string)*: Amazon Resource Name.

            Examples:
            ```json
            "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
            ```

            ```json
            "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
            ```

        - Azure Infrastructure Resource ID*object*: Minimal Azure Infrastructure Config. Cannot contain additional properties.
          - **`ari`** *(string)*: Azure Resource ID.

            Examples:
            ```json
            "/subscriptions/12345678-1234-1234-abcd-1234567890ab/resourceGroups/resource-group-name/providers/Microsoft.Network/virtualNetworks/network-name"
            ```

        - GCP Infrastructure Name*object*: GCP Infrastructure Config For Resources With A Name Not A GRN. Cannot contain additional properties.
          - **`name`** *(string)*: Name Of GCP Resource.

            Examples:
            ```json
            "my-cloud-function"
            ```

            ```json
            "my-sql-instance"
            ```

    - **`security`** *(object)*: TBD.
      - **Any of**
        - AWS Security information*object*: Informs downstream services of network and/or IAM policies. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Policies. Cannot contain additional properties.
            - **`^[a-z-/]+$`** *(object)*
              - **`policy_arn`** *(string)*: AWS IAM policy ARN.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

          - **`network`** *(object)*: AWS security group rules to inform downstream services of ports to open for communication. Cannot contain additional properties.
            - **`^[a-z-]+$`** *(object)*
              - **`arn`** *(string)*: Amazon Resource Name.

                Examples:
                ```json
                "arn:aws:rds::ACCOUNT_NUMBER:db/prod"
                ```

                ```json
                "arn:aws:ec2::ACCOUNT_NUMBER:vpc/vpc-foo"
                ```

              - **`port`** *(integer)*: Port number. Minimum: `0`. Maximum: `65535`.
              - **`protocol`** *(string)*: Must be one of: `['tcp', 'udp']`.
        - Security*object*: Azure Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Scopes. Cannot contain additional properties.
            - **`^[a-z/-]+$`** *(object)*
              - **`role`**: Azure Role.

                Examples:
                ```json
                "Storage Blob Data Reader"
                ```

              - **`scope`** *(string)*: Azure IAM Scope.
        - Security*object*: GCP Security Configuration. Cannot contain additional properties.
          - **`iam`** *(object)*: IAM Roles And Conditions. Cannot contain additional properties.
            - **`^[a-z-/]+$`** *(object)*
              - **`condition`** *(string)*: GCP IAM Condition.
              - **`role`**: GCP Role.

                Examples:
                ```json
                "roles/owner"
                ```

                ```json
                "roles/redis.editor"
                ```

                ```json
                "roles/storage.objectCreator"
                ```

                ```json
                "roles/storage.legacyObjectReader"
                ```

  - **`specs`** *(object)*: Cannot contain additional properties.
    - **`rdbms`** *(object)*: Common metadata for relational databases.
      - **`engine`** *(string)*: The type of database server.

        Examples:
        ```json
        "postgresql"
        ```

        ```json
        "mysql"
        ```

      - **`engine_version`** *(string)*: The cloud provider's database version.

        Examples:
        ```json
        "5.7.mysql_aurora.2.03.2"
        ```

      - **`version`** *(string)*: The database version. Default: ``.

        Examples:
        ```json
        "12.2"
        ```

        ```json
        "5.7"
        ```


      Examples:
      ```json
      {
          "engine": "postgresql",
          "engine_version": "10.14",
          "version": "10.14"
      }
      ```

      ```json
      {
          "engine": "mysql",
          "engine_version": "5.7.mysql_aurora.2.03.2",
          "version": "5.7"
      }
      ```

<!-- ARTIFACTS:END -->

</details>

## Contributing

<!-- CONTRIBUTING:START -->

### Bug Reports & Feature Requests

Did we miss something? Please [submit an issue](https://github.com/massdriver-cloud/azure-mysql-flexible-server/issues) to report any bugs or request additional features.

### Developing

**Note**: Massdriver bundles are intended to be tightly use-case scoped, intention-based, reusable pieces of IaC for use in the [Massdriver][website] platform. For this reason, major feature additions that broaden the scope of an existing bundle are likely to be rejected by the community.

Still want to get involved? First check out our [contribution guidelines](https://docs.massdriver.cloud/bundles/contributing).

### Fix or Fork

If your use-case isn't covered by this bundle, you can still get involved! Massdriver is designed to be an extensible platform. Fork this bundle, or [create your own bundle from scratch](https://docs.massdriver.cloud/bundles/development)!

<!-- CONTRIBUTING:END -->

## Connect

<!-- CONNECT:START -->

Questions? Concerns? Adulations? We'd love to hear from you!

Please connect with us!

[![Email][email_shield]][email_url]
[![GitHub][github_shield]][github_url]
[![LinkedIn][linkedin_shield]][linkedin_url]
[![Twitter][twitter_shield]][twitter_url]
[![YouTube][youtube_shield]][youtube_url]
[![Reddit][reddit_shield]][reddit_url]

<!-- markdownlint-disable -->

[logo]: https://raw.githubusercontent.com/massdriver-cloud/docs/main/static/img/logo-with-logotype-horizontal-400x110.svg
[docs]: https://docs.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=azure-mysql-flexible-server&utm_content=docs
[website]: https://www.massdriver.cloud/?utm_source=github&utm_medium=readme&utm_campaign=azure-mysql-flexible-server&utm_content=website
[github]: https://github.com/massdriver-cloud?utm_source=github&utm_medium=readme&utm_campaign=azure-mysql-flexible-server&utm_content=github
[slack]: https://massdriverworkspace.slack.com/?utm_source=github&utm_medium=readme&utm_campaign=azure-mysql-flexible-server&utm_content=slack
[linkedin]: https://www.linkedin.com/company/massdriver/?utm_source=github&utm_medium=readme&utm_campaign=azure-mysql-flexible-server&utm_content=linkedin



[contributors_shield]: https://img.shields.io/github/contributors/massdriver-cloud/azure-mysql-flexible-server.svg?style=for-the-badge
[contributors_url]: https://github.com/massdriver-cloud/azure-mysql-flexible-server/graphs/contributors
[forks_shield]: https://img.shields.io/github/forks/massdriver-cloud/azure-mysql-flexible-server.svg?style=for-the-badge
[forks_url]: https://github.com/massdriver-cloud/azure-mysql-flexible-server/network/members
[stars_shield]: https://img.shields.io/github/stars/massdriver-cloud/azure-mysql-flexible-server.svg?style=for-the-badge
[stars_url]: https://github.com/massdriver-cloud/azure-mysql-flexible-server/stargazers
[issues_shield]: https://img.shields.io/github/issues/massdriver-cloud/azure-mysql-flexible-server.svg?style=for-the-badge
[issues_url]: https://github.com/massdriver-cloud/azure-mysql-flexible-server/issues
[release_url]: https://github.com/massdriver-cloud/azure-mysql-flexible-server/releases/latest
[release_shield]: https://img.shields.io/github/release/massdriver-cloud/azure-mysql-flexible-server.svg?style=for-the-badge
[license_shield]: https://img.shields.io/github/license/massdriver-cloud/azure-mysql-flexible-server.svg?style=for-the-badge
[license_url]: https://github.com/massdriver-cloud/azure-mysql-flexible-server/blob/main/LICENSE


[email_url]: mailto:support@massdriver.cloud
[email_shield]: https://img.shields.io/badge/email-Massdriver-black.svg?style=for-the-badge&logo=mail.ru&color=000000
[github_url]: mailto:support@massdriver.cloud
[github_shield]: https://img.shields.io/badge/follow-Github-black.svg?style=for-the-badge&logo=github&color=181717
[linkedin_url]: https://linkedin.com/in/massdriver-cloud
[linkedin_shield]: https://img.shields.io/badge/follow-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&color=0A66C2
[twitter_url]: https://twitter.com/massdriver?utm_source=github&utm_medium=readme&utm_campaign=azure-mysql-flexible-server&utm_content=twitter
[twitter_shield]: https://img.shields.io/badge/follow-Twitter-black.svg?style=for-the-badge&logo=twitter&color=1DA1F2
[discourse_url]: https://community.massdriver.cloud?utm_source=github&utm_medium=readme&utm_campaign=azure-mysql-flexible-server&utm_content=discourse
[discourse_shield]: https://img.shields.io/badge/join-Discourse-black.svg?style=for-the-badge&logo=discourse&color=000000
[youtube_url]: https://www.youtube.com/channel/UCfj8P7MJcdlem2DJpvymtaQ
[youtube_shield]: https://img.shields.io/badge/subscribe-Youtube-black.svg?style=for-the-badge&logo=youtube&color=FF0000
[reddit_url]: https://www.reddit.com/r/massdriver
[reddit_shield]: https://img.shields.io/badge/subscribe-Reddit-black.svg?style=for-the-badge&logo=reddit&color=FF4500

<!-- markdownlint-restore -->

<!-- CONNECT:END -->
