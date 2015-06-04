FROM ubuntu-debootstrap:14.04
MAINTAINER Bitnami

ENV BITNAMI_PREFIX=/usr/local/bitnami
ENV BITNAMI_APP_NAME redis
ENV BITNAMI_APP_VERSION 2.8.20-0
ENV BITNAMI_APP_DIR=$BITNAMI_PREFIX/$BITNAMI_APP_NAME

ADD https://storage.googleapis.com/bitnami-artifacts/install.sh?GoogleAccessId=432889337695-e1gggo94k5qubupjsb35tajs91bdu0hg@developer.gserviceaccount.com&Expires=1434934078&Signature=QNkAu%2F8E2RlalSQy4n1sxMhsGKF%2FVltr6zu65HU6A9H0HKOgl6u9etqy9w6OwD4DsLMxYuy2uymOK3iDc5RbfkAMncKI1zJpxcwRQ4Mt43Oe8PBXKbQYcZ7mQaYPtpnjYblDs1S2p12Pu5NTDJHK2hJ1MrIUYwBup5n60R6OJRI%3D /tmp/install.sh
ADD post-install.sh /tmp/post-install.sh

RUN stack=1 sh /tmp/install.sh --disable-components common --redis_enable_authentication 0

EXPOSE 6379
VOLUME ["/data", "/conf", "/logs"]

ENV PATH /usr/local/bitnami/redis/bin:/usr/local/bitnami/common/bin:$PATH

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["redis-server", "/usr/local/bitnami/redis/etc/redis.conf"]