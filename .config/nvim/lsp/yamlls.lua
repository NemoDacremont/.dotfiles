return {
    single_file_support = true,
    settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
            format = { enable = true },
            schemas = {
                ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master-standalone-strict/all.json"] =
                "/*.k8s.yml"
            },
        },
    }
}
