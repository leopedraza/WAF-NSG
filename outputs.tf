
// Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

output "NSG_HTTP_name" {
  description = "NSG HTTP OCID"
  value       = oci_core_network_security_group.NSG_for_WAF_HTTP.id
}


output "NSG_HTTPS_name" {
  description = "NSG HTTPS OCID"
  value       = oci_core_network_security_group.NSG_for_WAF_HTTPS.id
}

