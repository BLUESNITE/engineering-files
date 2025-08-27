import jenkins.model.*

def env = System.getenv()
def instance = Jenkins.getInstance()

def hudsonRealm = new hudson.security.HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(env['JENKINS_USER'], env['JENKINS_PASSWORD'])
instance.setSecurityRealm(hudsonRealm)

instance.save()
