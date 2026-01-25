FROM registry.opensuse.org/opensuse/infrastructure/dale/containers/osem/base:latest
ARG CONTAINER_USERID

# Configure our user
RUN usermod -u $CONTAINER_USERID moraga

# We copy the Gemfiles into this intermediate build stage so it's checksum
# changes and all the subsequent stages (a.k.a. the bundle install call below)
# have to be rebuild. Otherwise, after the first build of this image,
# docker would use it's cache for this and the following stages.
COPY Gemfile /moraga/
COPY Gemfile.lock /moraga/
RUN chown -R moraga /moraga

# Continue as user
USER moraga
WORKDIR /moraga/

# Install our bundle
RUN bundle install --jobs=3 --retry=3

CMD ["foreman", "start"]
