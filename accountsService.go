package main

import (
	"fmt"
	"net/http"
	"os"

	"git.local.osmonfam.net/personalf-services-accounts/handlers"
)

func main() {
	http.HandleFunc("/accounts", handlers.AccountsRouter)
	http.HandleFunc("/", handlers.RootHandler)
	err := http.ListenAndServe("0.0.0.0:11111", nil)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
