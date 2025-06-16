FROM absolutapps/oracle-12c-ee-base

ENV INIT_MEM_PST 40
ENV SW_ONLY false
ENV TERM dumb
ENV TNS_ADMIN ${ORACLE_HOME}/network/admin
ENV FORMS60_PATH /path/to/forms
ENV REPORTS60_PATH /path/to/reports

ADD entrypoint.sh /entrypoint.sh

EXPOSE 1521
EXPOSE 8080
EXPOSE 5500

VOLUME ["/u01/app/oracle"]

ENTRYPOINT ["/entrypoint.sh"]

