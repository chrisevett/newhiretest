FROM phusion/passenger-ruby21:0.9.15

ENV HOME /home/deployer

CMD ["/sbin/my_init"]

EXPOSE 80

RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default

COPY nginx.conf /etc/nginx/sites-enabled/webapp.conf

WORKDIR /tmp
COPY Gemfile /tmp/
COPY Gemfile.lock /tmp/
RUN bundle install

COPY . /home/app/webapp
RUN chown -R app:app /home/app/webapp

WORKDIR /home/app/webapp
RUN jekyll build


RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*