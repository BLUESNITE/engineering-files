import jenkins.model.*
import hudson.PluginManager
import hudson.PluginWrapper

def instance = Jenkins.getInstance()
def updateCenter = instance.getUpdateCenter()

// 설치할 플러그인 목록 정의
def plugins = [
    "git-parameter:0.9.19",                      // Git Parameter
    "pipeline-stage-view:2.33",                  // Pipeline: Stage View
    "pipeline-utility-steps:2.16.0",             // Pipeline Utility Steps
    "github-branch-source:42.v0739460cda_c4",    // Pipeline: GitHub Groovy Libraries
    "pipeline-maven:1331.v003efa_fd6e81",        // Pipeline Maven Integration
    "docker-workflow:572.v950f58993843"          // Docker Pipeline
]

// 현재 설치된 플러그인 확인
def installedPlugins = instance.getPluginManager().getPlugins().collect { it.getShortName() + ":" + it.getVersion() }

// 필요한 플러그인 설치
plugins.each { plugin ->
    def (pluginName, pluginVersion) = plugin.split(":")

    if (!installedPlugins.any { it.startsWith(pluginName) }) {
        println "Installing plugin: ${pluginName} (version: ${pluginVersion})"
        def pluginToInstall = updateCenter.getPlugin(pluginName)
        if (pluginToInstall != null) {
            def deployment = pluginToInstall.deploy(true) // 동기적 설치
            deployment.get() // 설치 완료 대기
            println "Plugin installed: ${pluginName} (version: ${pluginVersion})"
        } else {
            println "Plugin ${pluginName} not found in update center."
        }
    } else {
        println "Plugin already installed: ${pluginName} (version: ${pluginVersion})"
    }
}

// Jenkins 저장 및 재시작 안내
println "All plugins are installed. Please restart Jenkins manually to apply changes."
instance.save()
