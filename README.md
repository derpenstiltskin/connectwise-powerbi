# Power BI Queries for ConnectWise Manage and Automate

#### Table of Contents

*   [Overview](#overview)
*   [Features](#features)
*   [Download](#download)
*   [Usage](#usage)
*   [Licensing](#licensing)
*   [ConnectWise REST API Documentation](#connectwise-rest-api-documentation)
*   [Special Thanks](#special-thanks)

----------

## Overview

These Power Queries will perform requests against the ConnectWise Manage and Automate REST APIs.

## Features

- Handles authentication to the ConnectWise Manage and Automate REST APIs
- Handles retrieving access token from ConnectWise Automate
- Automatically manages API request paging, no action needed to retrieve over 1000 records
- Option to automatically expand all return columns that contain records
- Support for any condition, filtering, sorting the API supports via query string
- Handles query responses with null value fields
- Able to be pushed to Power BI online and have the dataset automatically refresh

----------

## Download

[Project Releases](https://github.com/derpenstiltskin/connectwise-powerbi/releases)

----------

## Usage

Please refer to [USAGE.md](USAGE.md).

----------

## Licensing

OneDriveShortcuts is licensed under the [MIT license](LICENSE.md).

----------

## ConnectWise REST API Documentation

[ConnectWise Developer](https://developer.connectwise.com)
----------

## Special Thanks

The basis of this function is based on the work that [Quinntin Comer](https://comertechnology.com/) did for this [article](https://comertechnology.com/cw-manage-getting-started-with-powerbi-the-update/).