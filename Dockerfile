FROM 3.5-jdk-8

RUN	apt-get update \
	&& apt-get install -y git \
	 					  curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/iTXTech/Nemisys.git

WORKDIR Nemisys

RUN git submodule update --init \
	mvn clean \
	mvn package
