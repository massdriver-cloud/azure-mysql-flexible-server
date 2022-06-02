# azure-mysql-flexible-server

Azure Database for MySQL Flexible Server is a fully managed production-ready database service designed for more granular control and flexibility over database management functions and configuration settings.

### Development

### Enabling Pre-commit

This repo includes Terraform pre-commit hooks.

[Install precommmit](https://pre-commit.com/index.html#installation) on your system.

```shell
mv pre-commit-config.yaml .pre-commit-config.yaml
pre-commit install
```

Terraform hooks will now be run on each commit.
