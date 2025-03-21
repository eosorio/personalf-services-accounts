# Go part
FROM docker.io/golang:1.16
EXPOSE 11111

WORKDIR /go/src/git.local.osmonfam.net
COPY personalf-services/databaseInfo personalf-services/databaseInfo
WORKDIR /go/src/git.local.osmonfam.net/personalf-services/databaseInfo
RUN go mod init git.local.osmonfam.net/personalf-services/databaseInfo
RUN go mod edit -replace git.local.osmonfam.net/databaseInfo=/go/src/git.local.osmonfam.net/personalf-services/databaseInfo
RUN go get github.com/lib/pq

WORKDIR /go/src/git.local.osmonfam.net
COPY personalf-services-accounts/accounts personalf-services-accounts/accounts/
WORKDIR /go/src/git.local.osmonfam.net/personalf-services-accounts/accounts
RUN go mod init git.local.osmonfam.net/personalf-services-accounts/accounts
RUN go mod edit -replace git.local.osmonfam.net/personalf-services/databaseInfo=../../personalf-services/databaseInfo
RUN go mod tidy

WORKDIR /go/src/git.local.osmonfam.net
COPY personalf-services-accounts/handlers personalf-services-accounts/handlers/
WORKDIR /go/src/git.local.osmonfam.net/personalf-services-accounts/handlers
RUN go mod init git.local.osmonfam.net/personalf-services-accounts/handlers
RUN go mod edit -replace git.local.osmonfan.net/personalf-services-accounts/accounts=../accounts
RUN go mod edit -replace git.local.osmonfam.net/personalf-services/databaseInfo=../../personalf-services/databaseInfo
RUN go mod tidy

WORKDIR /go/src/git.local.osmonfam.net
COPY personalf-services-accounts/accountsService.go personalf-services-accounts/
WORKDIR /go/src/git.local.osmonfam.net/personalf-services-accounts
RUN go mod init git.local.osmonfam.net/personalf-services-accounts
RUN go mod edit -replace git.local.osmonfam.net/personalf-services-accounts/handlers=./handlers
RUN go mod edit -replace git.local.osmonfan.net/personalf-services-accounts/accounts=./accounts
RUN go mod edit -replace git.local.osmonfam.net/personalf-services/databaseInfo=../personalf-services/databaseInfo
RUN go mod tidy

RUN go build -o /accountsService -ldflags "-linkmode external -extldflags -static"

FROM scratch
LABEL maintainer="eduardo.osorio.it@gmail.com"
WORKDIR /
COPY --from=0 /accountsService /personalf-services-accounts/accountsService
EXPOSE 11111
CMD ["/personalf-services-accounts/accountsService"]
