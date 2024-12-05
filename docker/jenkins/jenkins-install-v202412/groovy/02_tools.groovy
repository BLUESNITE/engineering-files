import jenkins.model.*
import hudson.tasks.Maven
import hudson.tools.InstallSourceProperty
import hudson.tools.ToolProperty

// Jenkins 인스턴스 가져오기
def instance = Jenkins.getInstance()
def env = System.getenv()

// Maven 설치 설정
def mavenName = env['TOOLS_MAVEN_NAME'] // Maven 이름
def mavenVersion = env['TOOLS_MAVEN_VERSION']    // Maven 버전

// 기존 Maven 설정 제거 (중복 방지)
def mavenDescriptor = instance.getDescriptorByType(Maven.DescriptorImpl)
mavenDescriptor.getInstallations().each { existingInstallation ->
    if (existingInstallation.getName() == mavenName) {
        println "Removing existing Maven installation: ${existingInstallation.getName()}"
    }
}
mavenDescriptor.setInstallations(
    mavenDescriptor.getInstallations().findAll { it.getName() != mavenName } as Maven.MavenInstallation[]
)

// Maven 설치 소스 정의
def mavenInstaller = new Maven.MavenInstaller(mavenVersion)
def installSourceProperty = new InstallSourceProperty([mavenInstaller] as List<ToolProperty<?>>)

// Maven 설정 추가
def mavenInstallation = new Maven.MavenInstallation(mavenName, "", [installSourceProperty] as List<ToolProperty<?>>)
mavenDescriptor.setInstallations((mavenDescriptor.getInstallations() + mavenInstallation) as Maven.MavenInstallation[])

// Jenkins 인스턴스 저장
instance.save()

println "Maven (${mavenName}) installation configured successfully!"
