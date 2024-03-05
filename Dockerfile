FROM ubuntu:latest AS BASE
RUN apt update && apt install -y default-jre

FROM BASE AS BUILD
RUN apt install -y gradle curl bzip2
RUN curl -L -O https://code.briarproject.org/briar/briar-mailbox/-/archive/main/briar-mailbox-main.tar.bz2
RUN tar xf briar-mailbox-main.tar.bz2
RUN cd briar-mailbox-main && ./gradlew x86LinuxJar

FROM BASE
RUN mkdir -p /mailbox/data /mailbox/lib
COPY --from=BUILD /briar-mailbox-main/mailbox-cli/build/libs/mailbox-cli-linux-x86_64.jar /mailbox/lib
VOLUME [ "/mailbox/data" ]
ENV LANG=C.UTF-8 XDG_DATA_HOME=/mailbox/data
ENTRYPOINT [ "/usr/bin/java", "-jar", "/mailbox/lib/mailbox-cli-linux-x86_64.jar" ]
