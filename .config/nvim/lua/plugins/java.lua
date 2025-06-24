-- return {
--   {
--     "mfussenegger/nvim-jdtls",
--     opts = {
--       cmd = {
--         "/usr/lib/jvm/java-21-openjdk-amd64/bin/java", -- use Java 21 explicitly
--         "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--         "-Dosgi.bundles.defaultStartLevel=4",
--         "-Declipse.product=org.eclipse.jdt.ls.core.product",
--         "-Dlog.protocol=true",
--         "-Dlog.level=ALL",
--         "-Xms1g",
--         "--add-modules=ALL-SYSTEM",
--         "--add-opens",
--         "java.base/java.util=ALL-UNNAMED",
--         "--add-opens",
--         "java.base/java.lang=ALL-UNNAMED",
--         "-jar",
--         vim.fn.glob("/home/marcelo/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
--         "-configuration",
--         "/home/marcelo/.local/share/nvim/mason/packages/jdtls/config_linux",
--         "-data",
--         vim.fn.stdpath("data") .. "/jdtls_workspace",
--       },
--     },
--   },
-- }

return {
  "mfussenegger/nvim-jdtls",
  opts = {
    jdtls = function(opts)
      local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
      local jvmArg = "-javaagent:" .. install_path .. "/lombok.jar"
      opts.cmd = {
        "/usr/lib/jvm/java-21-openjdk-amd64/bin/java", -- use Java 21 explicitly
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob("/home/marcelo/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        "/home/marcelo/.local/share/nvim/mason/packages/jdtls/config_linux",
        "-data",
        vim.fn.stdpath("data") .. "/jdtls_workspace",
      }
      table.insert(opts.cmd, "--jvm-arg=" .. jvmArg)

      opts.settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            runtimes = {
              {
                name = "JavaSE-8",
                path = "/usr/lib/jvm/java-8-openjdk-amd64/jre/bin",
              },
              {
                name = "JavaSE-17",
                path = "/usr/lib/jvm/java-17-openjdk-amd64/bin",
              },
              {
                name = "JavaSE-17",
                path = "/usr/lib/jvm/java-21-openjdk-amd64/bin",
              },
            },
          },
          format = {
            enabled = true,
            settings = {
              url = vim.fn.expand("~/Workspace/eclipse-java-google-style.xml"),
              profile = "GoogleStyle",
            },
          },
          inlayHints = {
            parameterNames = {
              enabled = "all",
            },
          },
          maven = {
            downloadSources = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
        },
      }

      return opts
    end,
  },
}
