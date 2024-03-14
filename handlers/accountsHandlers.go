package handlers

import (
	"net/http"

	"git.local.osmonfan.net/personalf-services-accounts/accounts"
)

func accountsGetInfo(w http.ResponseWriter, _ *http.Request, accountID int64, accountType int64) {
	accountsInfo, err := accounts.GetAccounts(accountID, accountType)
	if err != nil {
		postError(w, http.StatusInternalServerError)
		return
	}
	if len(accountsInfo) == 0 {
		postError(w, http.StatusNotFound)
	} else {
		postBodyResponse(w, http.StatusOK, jsonResponse{"accounts": accountsInfo})
	}
}

// accountsGetFavouritesInfo returns the JSON object with the information of the accounts marked as favourites
func accountsGetFavouritesInfo(w http.ResponseWriter, _ *http.Request, accountID int64, accountType int64) {
	accountsInfo, err := accounts.GetFavouriteAccounts(accountID, accountType)
	if err != nil {
		postError(w, http.StatusInternalServerError)
		return
	}
	if len(accountsInfo) == 0 {
		postError(w, http.StatusNotFound)
	} else {
		postBodyResponse(w, http.StatusOK, jsonResponse{"accounts": accountsInfo})
	}
}
