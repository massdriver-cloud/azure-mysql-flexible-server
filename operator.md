## Azure MySQL Flexible Server

Azure MySQL Flexible Server is a managed service provided by Microsoft Azure for deploying, managing, and scaling MySQL databases. This service allows for greater control and customization than the single server option, offering flexibility in high availability, maintenance windows, and server configurations. It is suitable for mission-critical applications due to its high availability configurations and various backup options.

### Design Decisions

1. **Resource Creation**: The module creates the necessary resources such as the MySQL flexible server, associated resource group, private DNS zone, and network configurations.
2. **Private Networking**: The MySQL server is configured with a private DNS zone and subnet to enhance security by being accessible only within the specified virtual network.
3. **High Availability**: High availability is configurable and is enabled to run within the same zone for redundancy.
4. **Monitoring and Alerts**: Automated alarms are set up for monitoring CPU, memory, and storage usage of the MySQL server, triggering alerts when thresholds are exceeded.
5. **Access and Security**: Uses a randomly generated master password for the MySQL administrator and stores essential access information as artifacts.

### Runbook

#### Unable to Connect to MySQL Server

One common issue might be an inability to connect to the MySQL server. This can be due to various network, configuration, or credential problems.

Check network connectivity to the MySQL server:
```sh
az network vnet show --resource-group <resource-group-name> --name <vnet-name>
```
Ensure your machine is within the same virtual network or has appropriate access.

Verify the DNS and private endpoint configuration:
```sh
az network private-endpoint dns-zone-group show --name <dns-zone-group-name> --resource-group <resource-group-name> --endpoint-name <endpoint-name>
```

Validate the MySQL server status:
```sh
az mysql flexible-server show --resource-group <resource-group-name> --name <mysql-server-name>
```
Check the `state` property to ensure the server is `Ready`.

#### Incorrect Credentials

If you receive a "Failed to connect due to incorrect credentials" error, make sure you are using the right username and password.

Retrieve stored credentials:
```sh
# Replace placeholders with actual values
export MYSQL_HOSTNAME=<hostname>
export MYSQL_USERNAME=<username>
export MYSQL_PASSWORD=<password>
export MYSQL_DATABASE=<database>
```

Attempt MySQL connection manually:
```sh
mysql -h ${MYSQL_HOSTNAME} -u ${MYSQL_USERNAME} -p${MYSQL_PASSWORD} -D ${MYSQL_DATABASE}
```
Ensure no special characters in the password are causing issues.

#### High CPU Usage

High CPU usage can affect database performance. Investigate CPU usage alerts and their history:

View metrics in Azure Monitor:
```sh
az monitor metrics list --resource <mysql-server-id> --metric cpu_percent --interval PT1M
```

In MySQL:
```sql
SHOW PROCESSLIST;
```
Identify queries that might be causing high CPU usage.

#### High Memory Usage

Monitor memory usage to prevent out-of-memory errors.

Check memory usage in Azure Monitor:
```sh
az monitor metrics list --resource <mysql-server-id> --metric memory_percent --interval PT1M
```

In MySQL, inspect memory-intensive queries:
```sql
SHOW GLOBAL STATUS LIKE 'Max_used_connections';
```
Check if the number is close to your max_connections setting.

#### High Storage Usage

Ensure your database doesn’t run out of storage.

View storage metrics:
```sh
az monitor metrics list --resource <mysql-server-id> --metric storage_percent --interval PT1M
```

In MySQL, check for large tables:
```sql
SELECT table_schema AS 'Database', 
    table_name AS 'Table', 
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)' 
FROM information_schema.TABLES 
ORDER BY (data_length + index_length) DESC;
```

Ensure you have adequate storage space to host your data.

This runbook helps diagnose and troubleshoot common issues that might arise while managing an Azure MySQL Flexible Server. Follow the steps accordingly to resolve the issues effectively.

