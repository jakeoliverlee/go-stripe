STRIPE_SECRET=sk_test_51Nc3poDrsASSuWnLkqb2s439GClxmwJGj4GsKF399q6VE05XThKvw6rkAB3QxuLmWcOCjexyqMmzD5emZub1y9Cv00tQYyhNva
STRIPE_KEY=pk_test_51Nc3poDrsASSuWnLyDSB1TulZ7OXSyzHGWc2OdZoDmqGYTEb8vBchaO6T1ztlJAdhMLk32RzkFXk47zdRdxUH6Uc00SbLQtQKx
GOSTRIPE_PORT=4000
API_PORT=4001

## build: builds all binaries
build: clean build_front build_back
	@echo All binaries built!

## clean: cleans all binaries and runs go clean
clean:
	@echo Cleaning...
	@echo y | DEL /S dist\*
	@go clean
	@echo Cleaned!

## build_front: builds the front end
build_front:
	@echo Building front end...
	@go build -o ./tmp/main.exe ./cmd/web/
	@echo Front end built!

## build_back: builds the back end
build_back:
	@echo Building back end...
	@go build -o dist/gostripe_api.exe .\cmd\api
	@echo Back end built!

## start: starts front and back end
start: start_front start_back

## start_front: starts the front end
start_front: build_front
	@echo Starting the front end...
	@set "STRIPE_KEY=$(STRIPE_KEY)" && set "STRIPE_SECRET=$(STRIPE_SECRET)" && start /B tmp\main.exe -port=$(GOSTRIPE_PORT)
	@echo Front end running!

## start_back: starts the back end
start_back: build_back
	@echo Starting the back end...
	@set "STRIPE_KEY=$(STRIPE_KEY)" && set "STRIPE_SECRET=$(STRIPE_SECRET)" && start /B dist\gostripe_api.exe -port=$(API_PORT)
	@echo Back end running!

## stop: stops the front and back end
stop: stop_front stop_back
	@echo All applications stopped

## stop_front: stops the front end
stop_front:
	@echo Stopping the front end...
	@taskkill /IM main.exe /F
	@echo Stopped front end

## stop_back: stops the back end
stop_back:
	@echo Stopping the back end...
	@taskkill /IM gostripe_api.exe /F
	@echo Stopped back end
