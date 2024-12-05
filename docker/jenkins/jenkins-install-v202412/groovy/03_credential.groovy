
import com.cloudbees.plugins.credentials.CredentialsScope
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl
import org.jenkinsci.plugins.plaincredentials.impl.StringCredentialsImpl
import hudson.util.Secret

import jenkins.model.Jenkins

def env = System.getenv()

// Jenkins 인스턴스 가져오기
def jenkinsInstance = Jenkins.getInstance()

// Credentials 스토어 가져오기
def credentialsStore = jenkinsInstance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0]?.getStore()

// 자격증명 생성
def gitlabCredentials = new UsernamePasswordCredentialsImpl(
    CredentialsScope.GLOBAL, // 자격증명 범위
    env['CREDENTIAL_GITLAB_JENKINS'],        // ID
    "aws gitlab access",     // 설명
    env['CREDENTIAL_GITLAB_JENKINS_USER'],             // 사용자명
    env['CREDENTIAL_GITLAB_JENKINS_PASSWORD']     // 비밀번호
)

// 자격증명 생성
def dockerCredentials = new UsernamePasswordCredentialsImpl(
    CredentialsScope.GLOBAL, // 자격증명 범위
    env['CREDENTIAL_DOCKER_JENKINS'],        // ID
    "aws docker access",     // 설명
    env['CREDENTIAL_DOCKER_JENKINS_USER'],             // 사용자명
    env['CREDENTIAL_DOCKER_JENKINS_PASSWORD']     // 비밀번호
)

def sonarCredentials = new StringCredentialsImpl(
    CredentialsScope.GLOBAL, // 자격증명 범위
    env['CREDENTIAL_SONAR_JENKINS'],        // ID
    "jenkins-sonar",     // 설명
    Secret.fromString(env['CREDENTIAL_SONAR_JENKINS_TEXT'])
)

def argocdCredentials = new StringCredentialsImpl(
    CredentialsScope.GLOBAL, // 자격증명 범위
    env['CREDENTIAL_ARGOCD'],        // ID
    "argocd-role-namespace",     // 설명
    Secret.fromString(env['CREDENTIAL_ARGOCD_TEXT'])
)

// 자격증명 추가
credentialsStore.addCredentials(Domain.global(), gitlabCredentials)
credentialsStore.addCredentials(Domain.global(), dockerCredentials)
credentialsStore.addCredentials(Domain.global(), sonarCredentials)
credentialsStore.addCredentials(Domain.global(), argocdCredentials)

// 완료 메시지 출력
println "GitLab Jenkins credentials created successfully!"
