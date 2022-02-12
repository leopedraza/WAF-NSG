
// Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.
// Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

terraform {
}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  region       = var.region
}

data "oci_core_vcn" "vcn" {
  vcn_id = var.vcn_ocid
}

#data "oci_core_subnet" "subnet" {
#  subnet_id = var.subnet_ocid
#}

# Protocols are specified as protocol numbers.
# http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml

resource "oci_core_network_security_group" "NSG_for_WAF_HTTP" {
  #Required
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_ocid

  #Optional
  display_name = "NSG_for_WAF_HTTP"

}

resource "oci_core_network_security_group" "NSG_for_WAF_HTTPS" {
  #Required
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_ocid

  #Optional
  display_name = "NSG_for_WAF_HTTPS"

}

resource "oci_core_network_security_group_security_rule" "http_ingreess_security_rules" {
  for_each                  = local.WAF_subnets
  network_security_group_id = oci_core_network_security_group.NSG_for_WAF_HTTP.id
  protocol                  = "6" // TCP
  direction                 = "INGRESS"
  source                    = each.key
  stateless                 = false
  description = "OCI WAF Server HTTP"

  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }

  }
}

resource "oci_core_network_security_group_security_rule" "https_ingreess_security_rules" {
  for_each                  = local.WAF_subnets
  network_security_group_id = oci_core_network_security_group.NSG_for_WAF_HTTPS.id
  protocol                  = "6" // TCP
  direction                 = "INGRESS"
  source                    = each.key
  stateless                 = false
  description = "OCI WAF Server HTTPS"

  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }

  }
}


locals { WAF_subnets = toset([
  "129.146.12.128/25",
  "129.146.13.128/25",
  "129.146.14.128/25",
  "129.148.156.0/22",
  "129.213.0.128/25",
  "129.213.2.128/25",
  "129.213.4.128/25",
  "130.35.0.0/20",
  "130.35.112.0/22",
  "130.35.116.0/25",
  "130.35.120.0/21",
  "130.35.128.0/20",
  "130.35.144.0/20",
  "130.35.16.0/20",
  "130.35.176.0/20",
  "130.35.192.0/19",
  "130.35.224.0/22",
  "130.35.232.0/21",
  "130.35.240.0/20",
  "130.35.48.0/20",
  "130.35.64.0/19",
  "130.35.96.0/20",
  "130.35.228.0/22",
  "132.145.0.128/25",
  "132.145.2.128/25",
  "132.145.4.128/25",
  "134.70.16.0/22",
  "134.70.24.0/21",
  "134.70.32.0/22",
  "134.70.56.0/21",
  "134.70.64.0/22",
  "134.70.72.0/22",
  "134.70.76.0/22",
  "134.70.8.0/21",
  "134.70.80.0/22",
  "134.70.84.0/22",
  "134.70.88.0/22",
  "134.70.92.0/22",
  "134.70.96.0/22",
  "138.1.0.0/20",
  "138.1.104.0/22",
  "138.1.128.0/19",
  "138.1.16.0/20",
  "138.1.160.0/19",
  "138.1.192.0/20",
  "138.1.208.0/20",
  "138.1.224.0/19",
  "138.1.32.0/21",
  "138.1.40.0/21",
  "138.1.48.0/21",
  "138.1.64.0/20",
  "138.1.80.0/20",
  "138.1.96.0/21",
  "138.1.112.0/20",
  "140.204.0.128/25",
  "140.204.12.128/25",
  "140.204.16.128/25",
  "140.204.20.128/25",
  "140.204.24.128/25",
  "140.204.4.128/25",
  "140.204.8.128/25",
  "140.91.10.0/23",
  "140.91.12.0/22",
  "140.91.22.0/23",
  "140.91.24.0/22",
  "140.91.28.0/23",
  "140.91.30.0/23",
  "140.91.32.0/23",
  "140.91.34.0/23",
  "140.91.36.0/23",
  "140.91.38.0/23",
  "140.91.4.0/22",
  "140.91.40.0/23",
  "140.91.8.0/23",
  "147.154.0.0/18",
  "147.154.128.0/18",
  "147.154.192.0/20",
  "147.154.208.0/21",
  "147.154.224.0/19",
  "147.154.64.0/20",
  "147.154.80.0/21",
  "147.154.96.0/19",
  "192.157.18.0/24",
  "192.157.19.0/24",
  "192.29.0.0/20",
  "192.29.128.0/21",
  "192.29.138.0/23",
  "192.29.144.0/21",
  "192.29.152.0/22",
  "192.29.16.0/20",
  "192.29.160.0/21",
  "192.29.168.0/22",
  "192.29.172.0/25",
  "192.29.178.0/25",
  "192.29.180.0/22",
  "192.29.32.0/21",
  "192.29.40.0/22",
  "192.29.44.0/25",
  "192.29.48.0/21",
  "192.29.56.0/21",
  "192.29.60.0/23",
  "192.29.64.0/20",
  "192.29.96.0/20",
  "192.29.140.0/22",
  "192.69.118.0/23",
  "198.181.48.0/21",
  "199.195.6.0/23",
  "205.147.88.0/21",
]) }
