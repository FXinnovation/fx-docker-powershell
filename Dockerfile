FROM mcr.microsoft.com/powershell:7.1.5-alpine-3.13-20211021

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION

ADD ./resources /resources
RUN chmod 777 /resources/build
RUN /resources/build && rm -rf /resources

USER powershell

VOLUME /data

WORKDIR /data


ENTRYPOINT ["pwsh"]

LABEL "maintainer"="cloudsquad@fxinnovation.com" \
    "org.label-schema.name"="powershell" \
    "org.label-schema.base-image.name"="mcr.microsoft.com/powershell" \
    "org.label-schema.base-image.version"="7.1.5-alpine-3.13-20211021" \
    "org.label-schema.description"="Powershell for linux in a container" \
    "org.label-schema.url"="https://microsoft.com" \
    "org.label-schema.vcs-url"="https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/docker-powershell" \
    "org.label-schema.vendor"="FXinnovation" \
    "org.label-schema.schema-version"="1.0.0-rc.1" \
    "org.label-schema.vcs-ref"=$VCS_REF \
    "org.label-schema.version"=$VERSION \
    "org.label-schema.build-date"=$BUILD_DATE \
    "org.label-schema.usage"="Please read README.md in repository"
