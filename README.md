# Chrome-Sync-Storage 

## Example of uses

`storage.login = "Bob";` Will store "Bob" as Login.
`console.log(storage.login);` Will print "Bob" in the console.

You can also have nested objects like
`storage.session.token = "mytoken";`
`console.log(storage.session.token);` Will print "mytoken"

Pay attention that the storage calls are in facts asynchronous so it can take some time to be updated for other script that use the storage.
But for normal use (like an option page that set settings for a background page) it doesn't causes any problems.