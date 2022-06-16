# CHANGELOG

## 1.2.0

*   Split Token Request from CWAutomateApiRequest into own query CWAutomateApiTokenRequest to allow token reuse and minimize Automate API calls
*   Added Token parameter to CWAutomateApiRequest to pass Token value into
*   Updated existing Automate sample to reflect changes
*   Added CWAutomate_GetDriveHealthStats to show token reuse and a more complex Automate API task

## 1.1.0

*   Split ConnectWise Manage and ConnectWise Automate queries into separate files
*   Added handling of null field values being returned from the APIs on the first record
*   Added additional condition handling of data being returned from APIs that could result in errors
*   Updated Samples

## 1.0.1

*   Fixed query string bug in Automate and Manage queries

## 1.0.0

*   First release for the project.
