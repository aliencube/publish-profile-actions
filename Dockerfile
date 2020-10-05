FROM mcr.microsoft.com/azure-powershell:latest

LABEL "com.github.actions.name"="Azure App Service Publish Profile"
LABEL "com.github.actions.description"="Retrieve the publish profile of Azure Web App or Functions App in XML format"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/aliencube/publish-profile-actions"
LABEL "homepage"="http://github.com/aliencube"
LABEL "maintainer"="Justin Yoo <no-reply@aliencube.com>"

ADD entrypoint.ps1 /entrypoint.ps1
RUN chmod +x /entrypoint.ps1

ENTRYPOINT ["pwsh", "-File", "/entrypoint.ps1"]
