pipeline {
    agent any
    environment {
        region = 'us-east-1'
    }
    stages {
        stage('build') {
            script {
                def identity = awsIdentity()
                if (env.BRANCH_NAME == 'master' ) {
                    publish = 'true'
                } else { publish = '' }
            }
            awsCodeBuild projectName: tox, envVariables: "[{ AWS_ACCOUNT_ID, " + identity.account + "}, { AWS_DEFAULT_REGION, $env.region }, { PUBLISH, $publish }]", buildSpecFile: buildspec.yml, sourceControType: 'jenkins', credentialsType: 'keys'
        }
    }
}
