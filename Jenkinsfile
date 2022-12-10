def buildNumber = env.BUILD_NUMBER
def imageTag = "nltimv/ansible-ci"

podTemplate(namespace: 'jenkins-ci', yaml: '''
    apiVersion: v1
    kind: Pod
    spec:
      containers:
      - name: kaniko
        image: gcr.io/kaniko-project/executor:debug
        command:
        - sleep
        args:
        - 9999999
        volumeMounts:
        - name: kaniko-secret
          mountPath: /kaniko/.docker
        resources:
          requests:
            cpu: 200m
            memory: 512Mi
      restartPolicy: Never
      volumes:
      - name: kaniko-secret
        secret:
            secretName: dockercred
            items:
            - key: .dockerconfigjson
              path: config.json
''') {
  node(POD_LABEL) {
    stage('Build') {
      git url: 'https://github.com/nltimv/docker-ansible-ci', branch: 'main'
      container('kaniko') {
        stage('Build image') {
          sh """
            /kaniko/executor --context "`pwd`" --destination $imageTag:$buildNumber --destination $imageTag:latest
          """
        }
      }
    }
  }
}