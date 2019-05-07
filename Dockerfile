FROM mcr.microsoft.com/powershell:6.1.3-alpine-3.8

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

ADD ./resources /resources

# Install ASP.NET Core
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
# Install .NET Core SDK
    DOTNET_SDK_VERSION="2.2.203" \
    DOTNET_SHA512='18c821c8f9c110d3e1bc4e8d6a88e01c56903a58665a23a898457a85afa27abfa23ef24709602d7ad15845f1cd5b3c3dd8c24648ab8ab9e281b5705968e60e41' \
# Enable correct mode for dotnet watch (only mode supported in a container)
    DOTNET_USE_POLLING_FILE_WATCHER=true \
# Skip extraction of XML docs - generally not useful within an image/container - helps performance
    NUGET_XMLDOC_MODE=skip

RUN /resources/build && rm -rf /resources

USER powershell

VOLUME /data

WORKDIR /data

ENTRYPOINT ["pwsh"]

LABEL "maintainer"="cloudsquad@fxinnovation.com" \
      "org.label-schema.name"="powershell" \
      "org.label-schema.base-image.name"="mcr.microsoft.com/powershell" \
      "org.label-schema.base-image.version"="6.1.3-alpine-3.8" \
      "org.label-schema.description"="Powershell for linux in a container" \
      "org.label-schema.url"="https://microsoft.com" \
      "org.label-schema.vcs-url"="https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/docker-powershell" \
      "org.label-schema.vendor"="FXinnovation" \
      "org.label-schema.schema-version"="1.0.0-rc.1" \
      "org.label-schema.vcs-ref"=$VCS_REF \
      "org.label-schema.version"=$VERSION \
      "org.label-schema.build-date"=$BUILD_DATE \
      "org.label-schema.usage"="Please read README.md in repository" \
      "org.label-schema.applications.dotnet-sdk.version"=$DOTNET_SDK_VERSION