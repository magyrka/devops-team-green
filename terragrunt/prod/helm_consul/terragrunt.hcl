include "root" {
  path = find_in_parent_folders()
}

include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/helm_consul.hcl"
}

inputs = {
  values = ["${file("consul-config.yaml")}"]
}