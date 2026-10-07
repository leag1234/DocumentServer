<!--
SPDX-FileCopyrightText: 2026 Euro-Office contributors
SPDX-License-Identifier: AGPL
-->

[![License](https://img.shields.io/badge/License-GNU%20AGPL%20V3-green.svg?style=flat)](https://www.gnu.org/licenses/agpl-3.0.en.html)

# ElixirOffice
**Your sovereign office**

[Learn more.](https://github.com/elixiroffice/)

## Get involved
Get involved! You can file issues, propose pull requests and more. We are looking forward to make the digital sovereign office space better than ever before!

### Try out
We currently provide a docker image for testing and integration purposes. We are going to publish deb/rpm packages shortly.

```
docker pull ghcr.io/elixiroffice/documentserver:latest
docker run -i -t -d -p 8080:80 --restart=always -e EXAMPLE_ENABLED=true -e JWT_SECRET=my_long_jwt_secret_at_least_32_chars ghcr.io/elixiroffice/documentserver:latest
```

### Building

Our build steps and processes are documented in https://github.com/elixiroffice/DocumentServer/tree/main/build. For development there are more detailed steps to build and run individual components in https://github.com/elixiroffice/DocumentServer/tree/main/develop 
