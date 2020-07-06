# Go part
FROM golang:1.13
EXPOSE 11111
WORKDIR /go/src/git.osmon.local
COPY personalf-services-accounts/accounts personalf-services-accounts/accounts/
COPY personalf-services-accounts/handlers personalf-services-accounts/handlers/
COPY personalf-services-accounts/accountsService.go personalf-services-accounts/
COPY personalf-services/databaseInfo personalf-services/databaseInfo

RUN go get -d -v ./...
#RUN go install -v ./...

RUN go build -o /accountsService -ldflags "-linkmode external -extldflags -static" -i /go/src/git.osmon.local/personalf-services-accounts/accountsService.go
CMD ["/accountsService"]

FROM scratch
LABEL maintainer="eduardo.osorio.it@gmail.com"
WORKDIR /
COPY --from=0 /accountsService /accountsService
EXPOSE 11111
CMD ["/accountsService"]
