# Bikes Tester Exercise

## Usage

Please open the Site/index.html file in the latest version of Chrome - Enjoy :)

Tests can be run by opening the Tests/RunTests.html file in the latest version of Chrome.

## Running

This application can be run simply using [Docker](https://www.docker.com/).  You will be using Docker a lot here so learn that stuff:

```bash
docker run -it -v ${PWD}/app:/usr/share/nginx/html:ro -p 80:80 nginx:1.13
````
Then browse to http://localhost to see the application:
You can also run the Jasmine based unit test suite by browsing http://localhost

It can also be run by simply serving the `app/` directory from any web server on your machine.  


## Tasks

### Bonus points
-



## To do

1. Unit tests for session storage of filtered options
