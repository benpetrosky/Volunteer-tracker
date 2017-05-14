# _Volunteer Tacker_

#### _Database of Projects and the volunteers, 05.05.2017_

#### By _Ben Petrosky_

## Description

_A simple database of projects for a non profit that can add projects and from the view the individual projects can assign volunteers to that project.  The project can be changed and deleted.  The volunteers can be changed and deleted.  Each volunteer may only be assigned to one project._

## Setup/Installation Requirements

clone this repository on your desktop
in your terminal:
  move into the project folder
  run bundle Installation
  run postgress
in another terminal window:
  run psql
  CREATE DATABASE volunteer_tracker;
  \c volunteer_tracker;
  CREATE TABLE projects (id PRIMARY KEY, project_name varchar);
  CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar, project_id int);
in another terminal window:
  run ruby app.rb
  open the local host provided in the browser of your choice.




## Known Bugs

_There are no known bugs._

## Support and contact details

_If you have any suggestions please feel free to contribute to the code._

## Technologies Used

sql
ruby

### License

This is software is licensed under MIT License.

Copyright (c) 2017 **_Ben Petrosky_**
