# For debugging
#FROM alpine:3.10.3
#WORKDIR /
#COPY --from=build-env /server /
#CMD ["/server"]

# Go part
FROM golang:1.13
LABEL maintainer="eduardo.osorio.it@gmail.com"
EXPOSE 11111
WORKDIR /go/src/git.osmon.local
COPY personalf-services-accounts/accounts personalf-services-accounts/accounts/
COPY personalf-services-accounts/handlers personalf-services-accounts/handlers/
COPY personalf-services-accounts/accountsService.go personalf-services-accounts/
COPY personalf-services/databaseInfo personalf-services/databaseInfo

RUN go get --insecure -d -v ./...
#RUN go install -v ./...

RUN go build -o /accountsService -i /go/src/git.osmon.local/personalf-services-accounts/accountsService.go
CMD ["/accountsService"]

