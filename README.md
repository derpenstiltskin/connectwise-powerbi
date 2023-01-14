# Power BI Queries for the ConnectWise Ecosystem

[![GitHub version](https://badge.fury.io/gh/derpenstiltskin%2Fconnectwise-powerbi.svg)](https://badge.fury.io/gh/derpenstiltskin%2Fconnectwise-powerbi)
[![License](https://img.shields.io/badge/license-MIT-green)](https://github.com/derpenstiltskin/connectwise-powerbi/blob/main/LICENSE.md)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/derpenstiltskin/connectwise-powerbi)](https://github.com/derpenstiltskin/connectwise-powerbi/commits/main)

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

These Power Queries will perform requests against the ConnectWise ecosystem REST APIs.

## Features

- Handles authentication to the ConnectWise Manage, Automate, RMM REST APIs
- Handles retrieving access token from ConnectWise Automate
- Automatically manages API request paging on applicable APIs, no action needed to retrieve over 1000 records
- Option to automatically expand all return columns that contain records from applicable APIs
- Support for any condition, filtering, sorting that is applicable to the API
- Handles query responses with null value fields
- Able to be pushed to Power BI online and have the dataset automatically refresh

## Download

[Project Releases](https://github.com/derpenstiltskin/connectwise-powerbi/releases)

## Usage

Please refer to [USAGE.md](USAGE.md).

## Licensing

ConnectWise-PowerBI is licensed under the [MIT license](LICENSE.md).

## ConnectWise REST API Documentation

[ConnectWise Developer](https://developer.connectwise.com)

## Special Thanks

The basis of this function is based on the work that [Quinntin Comer](https://comertechnology.com/) did for this [article](https://comertechnology.com/cw-manage-getting-started-with-powerbi-the-update/).