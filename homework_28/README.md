1. Create DSL pipeline to validate shell scripts(all .sh scripts under provided location). You can use your previous scripts. Checker tool - https://github.com/koalaman/shellcheck(you can use any you like)

Сделал пайплайн, в нем ансиблом ставим спеллчек. Всё происходит на дженкинс ноде. По дефолту пайплайн возвращал ошибку если спеллчек находит проблемы в скриптах. Обернул в трай кетч.

2. Create DSL pipeline to validate Dockerfile. Use https://github.com/projectatomic/dockerfile_lint or anything else you like. Dockerfile to validate - Dockerfile you use to build image for jenkins
3. Update previous DSL with new stage - build new jenkins image(Only if lint successful). Tag - ${VERSION}_${GIT_HASH}_{JENKINS_BUILD_NUMBER}.  ${VERSION} -  should be set as parameter.
4. Update previous pipeline with new stage - push docker to your registry. It should be a private image, so provide creds(as jenkins secret) for docker login.
5. Do previous task as a separate pipeline. It should be triggered after successful linting.
6. Create multibranch pipeline to validate your PRs with your Jenkinsfile created above
