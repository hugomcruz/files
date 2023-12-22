## [Changes](https://docs.konghq.com/gateway/changelog/#3500)

#### Session Plugin

| New Config field ` read_body_for_logout ` with a default value of  `false` |  |
|----|----|
| This changes `logout_post_arg` behaviour unless the new field is explicitly set to `true` |   |
| This adjustment prevents the plugin from automatically reading request bodies for logout detection on **POST** requests | |

#### Developer Portal

| As of this release the component known as **Kong Enterprise Portal** ( Developer Portal ) is no longer included in the **Kong Gateway Enterprise** ( previously known as **Kong Enterprise**) | The initial ideia was to use this as the place to go to get information about the API's that were passing through Kong with this change this is no longer possible |
|----|----|
| Existing customers who have purchased **Kong Enterprise Portal** can continue to use it and be supported via a dedicated mechanism | The use of this feature might mean a bigger cost on the Kong side  |
| If you have purchased **Kong Enterprise Portal** in the past and would like to continue to use it contact Kong Support for more information | |

#### Vitals

| As of this release the component known as **Vitals** is  ***deprecated*** and is no longer included in **Kong Gateway Enterprise** | More power to our implementation of Splunk to get traces and metrics, or if Vodafone doesn't want Splunk there are a few alternatives but that means more moving parts and more possible points of failure  |
|----|----|
| (Kong Alternative) Kong Konnect users can take advantages of the API Analytics, which provides a superset of Vitals functionality |   |
| Vitals continues to be supported for existing customers until ***August 2026*** via **Kong Enterprise 3.4 LTS** release | |

## Features

#### Enterprise

| Modified **AWS Vault** backend to support `CredentialProviderChain` so users can choose not to use `AK-SK` environment variables to grant IAM role permissions |   |
|----|----|
| Added support for Microsoft Azure's KeyVault Secrets Engine. To set it up use the `*_azure_vault` configuration parameters  |   |
| Renamed Kong Enterprise package to Kong Gateway Enterprise, it only affects the documentation, no changes to the code| |

##### License management

| Implemented new grace period of 30 days from Kong Enterprise License expiration date |   |
| --- | --- |
| During that period all open source functionality will be available, and Enterprise functionality will be set to read-only mode | |
| Added support for counters such as routes, plugins, licenses and deployment information to the license report | Still need to get more information about the license report to see this change in action |
| Added checksum to the output of the license endpoint | |

#### Kong Manager

| Added the ability to delete workspaces without needing to delete all associated resources. More info at [Delete a workspace](https://docs.konghq.com/gateway/3.5.x/kong-manager/workspaces/#delete-a-workspace) | This is a good and a bad change, in my opinion this is a good change but creates a higher possibility to accidentally delete the wrong namespace |
| ---  | ---  |
| Added support for Azure's KeyVault Secrets Engine |   |
| Enabled plugins to be scoped to consumer groups | Only a few Plugins can be use as of now, (Traffic Control and Transformation) |
| Implemented the removal of consumer groups policies |   |
| "Enhance" the user experience of detail pages for entities with refined look and feel |   |
| "Improved" the user experience with a new design for the **Overview** and **Workspaces** page |  |
| The Vault form now supports TTL fields |   |

#### Core

| Added `analytics_debug` option to the output of logged requests |   |
| ---  | ---  |
| Added `cluster_fallback_export_s3_config` option to allow adding a config table to the Kong exporter config S3 `putObject` request |   |
| Added troubleshooting tools to container images |   |
| `workspaces.get_workspace()` now tries to get the workspace from the cache instead of querying the database directly | |
| Introduced new endpoint `/schemas/vaults/:name` for retrieving the schema of the vault | |
| Renamed `privaleged_agent` to `dedicated_config_processing` and enabled it by default | |

##### Debugging tools

| Added a unique Request ID that is now populated  in the error log, access log, error templated, log serializer and a new `X-Kong-Request_Id` header. This configuration can  be customized for upstream and downstream using `headers` and `headers_upstream` options | I've already encounter this change but i still need to find where this id is located |
| ---  | ---  |
| Added support for the debug request header `X-Kong-Request-Debug-Output`, which lets you observe the time consumed by specific components in a given request. Enable it using the `request_debug` configuration parameter. This header helps diagnose the cause of any latency in Kong Gateway. See the [Request Debugging](https://docs.konghq.com/gateway/3.5.x/production/debug-request/) guide for more information |   |

#### Kong Manager Open Source 

| Added `JSON` and `YAML` formats in entity configuration cards |   |
| ---  | ---  |
| Plugin form fields now display descriptions from backend schema |   |
| Added the `protocols` field to the plugins form |   |
| The upstream target list shows the `Mark Healthy` and `Mark Unhealthy` action items when certain conditions are met |  |

#### Plugins

| [**Mocking**](https://docs.konghq.com/hub/kong-inc/mocking/) | Added a new property `include_base_path` for path match evaluation | |
| ---  | ---  | --- |
| [**OAS Validation**](https://docs.konghq.com/hub/kong-inc/oas-validation/) |Added a new property `include_base_path` for path match evaluation | |
| [**OpenID Connect**](https://docs.konghq.com/hub/kong-inc/openid-connect/) | Added the new field `unauthorized_destroy_session`. When set to `true`, it destroys the session when receiving an unauthorized request by deleting the user’s session cookie | Need to check with Hugo to see if this changes are significant since he used the plugin more than me|
|  | Added the new field `using_pseudo_issuer`. When set to `true`, the plugin instance will not discover configuration from the issuer | |
|  | Added support for public clients for token revocation and introspection  | |
|  | Added support for designating parameter names `introspection_token_param_name` and `revocation_token_param_name`  | |
|  | Added support for mTLS proof of possession. The feature is available by enabling `proof_of_possession_mtls` | |
| [**OpenTelemetry**](https://docs.konghq.com/hub/kong-inc/opentelemetry/) | Added a new value to the parameter `header_type`, which allows Kong Gateway to inject Datadog headers into the headers of requests forwarding to the upstream | If this change is specific to Datadog it doesn't affect us |
| [**Response Rate Limiting**](https://docs.konghq.com/hub/kong-inc/response-ratelimiting/) |Added support for secret rotation with Redis connections |   |
| [**CORS**](https://docs.konghq.com/hub/kong-inc/cors) | Added support for the `Access-Control-Request-Private-Network` header in cross-origin pre-flight requests |   |
| [**ACME**](https://docs.konghq.com/hub/kong-inc/acme/) |Exposed the new configuration field `scan_count` for Redis storage, which controls how many keys are returned in a `scan` call |   |
| [**Session**](https://docs.konghq.com/hub/kong-inc/session/) | Introduced the new configuration field `read_body_for_logout` with a default value of `false`. This change alters the behavior of `logout_post_arg` in such a way that it is no longer considered, unless `read_body_for_logout` is explicitly set to `true` |   |



## Fixes

#### Core

| Removed the chart `Current Database Availability`, which is not a vitals metric with Prometheus |   |
| ---  | ---  |
| Applied Nginx patch to detect HTTP/2 stream reset attacks early, addressing [CVE-2023-44487](https://nvd.nist.gov/vuln/detail/CVE-2023-44487) |   |
