FROM maven:3.5-jdk-8

RUN	apt-get update \
	&& apt-get install -y git \
	 					  curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN git clone https://github.com/iTXTech/Nemisys.git

WORKDIR /root/Nemisys

RUN git submodule update --init \
	&& mvn clean \
	&& mvn package

RUN mkdir /srv/nemisys \
	&& mv /root/Nemisys/target/nemisys-1.0-SNAPSHOT.jar / \
	&& rm -rf /root/Nemisys

WORKDIR /srv/nemisys

ADD server.properties ./

VOLUME ["/srv/nemisys/plugins"]

EXPOSE 19132
EXPOSE 19921

CMD ["java", "-jar", "/nemisys-1.0-SNAPSHOT.jar"]
