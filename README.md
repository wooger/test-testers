# Bikes Tester Exercise

## Your Challenge
We need you to create an integration test suite to test that the application described below functions correctly and renders according to the user stories.  
- Fork this project
- write your integration test suite
- document profusely
- if you have time attempt to get some bonus points (see below for assesment criteria)

You have a week to get this done in.
**Good Luck!**

## The Scenario
One of our dev team has developed this wonderful Bikes application in [Angular.js](https://angularjs.org/) to meet our customer's requirements.
It reads a bunch of [json data](https://raw.githubusercontent.com/jujhars13/test-testers/master/app/bikes.json) and renders a listing of all the bikes according to the following user story:

### The User story
As a user, Assuming I have access to a modern web browser (chrome) with an internet connection and I am visiting the page

- I would like to see a list/grid of bikes (taken from the bike data URL below)
- I would like to see a the name, an image, a description and the class for each bike
- I would like to be able to sort the bikes into a custom order based on class
- I would like my custom order to be saved and not change when I refresh the page
- A JSON object with all the relevant bike data is available at, feel free to call that URL directly from your page or host it on your server if you're using one: https://jujhar.com/bikes.json

In addition the developer has also created some BDD based unit tests using [jasmine](https://jasmine.github.io/) which can be found in `/app/tests`
See [Getting the application Running] to see how to run the application.

![bikes application screenshot](https://raw.githubusercontent.com/jujhars13/test-testers/master/screenshot.png)

## Assessment Criteria
Your test suite will be assessed on the following criteria (with scoring in order of importance):

- Approach
- Code organisation, commenting, documentation
- If test suite can be easily reproduced and ran on any machine
- Flair
- use of git
- use of docker

### Bonus Points
- Modify the existing unit test suite + mock data to satisfy the following BDD criteria:
    - `when we filter by "class: gravel" and "gears: 21" we get one result`
- get your integration test suite working in Docker so it can be ran on any machine

## Assumptions:
- Please list any assumptions or scope limitations that you may make
- Feel free to use any languages and libraries/frameworks

## Getting the application Running

This application can be run simply using [Docker](https://www.docker.com/).  You will be using Docker a lot here so learn that stuff:

```bash
docker run -it -v ${PWD}/app:/usr/share/nginx/html:ro -p 80:80 nginx:1.13
````
Then browse to [http://localhost]() to see the application:
You can also run the Jasmine based unit test suite by browsing [http://localhost/test]() 

It can also be run by simply serving the `app/` directory from any web server on your machine if you're so inclined.