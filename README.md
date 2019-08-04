# PostgreSQL to Neo4j ETL Project

This project is built for migrating PostgreSQL db to Neo4j database.
Given below is the neo4j graph db creation process. 
Here I use Neo4j community edition.

![PROCESS](documents/img/process.png?raw=true "Process")

With the help of this docker images, you can migrate your rdbms to graph database, 
all you have to do is creating your rdbms CREATE script and also initial sql insert scripts;
put them under /docker/postgres/sqls folder
update /docker/migration/headers/ txt files, these files are  mapping of the extracted data from postgresql to graph db 
update /docker/migration/sqls txt files, these files are for exporting data from post 



### Folders
Given below is the folder definitions, this will give you a hint 
what are these folders for

### migration
Contains documents for migration docker image. This image is responsible for extract data from postgresql in csv format,
and after this, delete the header of each file and change the header with the ones in the header folder. This headers are important
to import data to graph db 

#### migration/headers/
contains all of the column header for graph db migration. These headers are added the
first line of the extracted csv data from test-db. With the help of the headers 
the data could be created in graph under each node and edges.

Ex:
Given below Catalog, SalesCategory and Catalog-SalesCategory headers
##### catalog Header
catalog_id:ID(CATALOG-ID),name,is_deleted:boolean

here; 
catalog_id: property name inside Catalog node
ID: catalog_id is the id of the Catalog
(CATALOG-ID): refers the namespace of this id. so we can use this id in other related csvs as a reference-id.
name: property name inside Catalog node
is_deleted: property name inside Catalog node
boolean: is the type of the property

##### sales_category-catalog Header
:END_ID(SALES-CATEGORY-ID),:START_ID(CATALOG-ID),sort_order,is_deleted:boolean

here;
as this is a edge (relation) it contains START_ID, END_ID With ID spaces like here START_ID  id space is
 CATALOG-ID, this is defined in catalog header file. And END_ID id space is CATEGORY-ID which is defined in sales_category header.
:END_ID(SALES-CATEGORY-ID): refers end node of the relation and connected to the id space of sales_category.SALES-CATEGORY-ID
:START_ID(CATALOG-ID): refers start node of the relation and connected to the id space of catalog.CATALOG-ID

the rest of the headers are properties

##### sales_category Header
sales_category_id:ID(SALES-CATEGORY-ID),is_deleted:boolean

here;
this file has almost same properties in catalog header. with its id property with id space of (SALES-CATEGORY-ID), and one more property is_deleted with boolean
type.


#### migration/scripts
there are 4 scripts
- migration.sh:  controller of all scripts.
- wait-for-postgres.sh: check if postgres docker is available or not
- copy-from-postgres.sh: extract data from postgres in csv format with copy command.
- change-header.sh: change the header of each extracted csv data with the given headers in header folder.

#### migration/sqls
contains the sql scripts to extract data from postgres database.


### neo4j
contains neo4j docker image related files, most important folder here for our application is import folder, cause 
this folder is mapped with migration docker image so extracted header-changed cvs files will be mapped to neo4j docker image
by volume, so when the neo4j is started, the extracted header-changed csv files will be imported to graph db by neo4j-admin
tool.

#### neo4j/scripts
- wrapper.sh: controller script for neo4j docker image. first load neo4j with related csvs and at the background starts neo4j graph
- load-to-neo4j.sh: check if all of the csvs are extracted to import folder with checking if completed.txt file is created
if yes, than with neo4j-admin import command, import all of the nodes and edges.
- create-indexes.sh: after neo4j graph has been started, change password and create related indexes.

#### neo4j/conf
initially nothing in this folder, but after neo4j is started, neo4j conf file will be reached in this folder

#### neo4j/data
initially nothing in this folder, but after neo4j is started, neo4j graph db will be reached in this folder

#### neo4j/import
initially nothing in this folder, but after neo4j is started, extracted csvs and completed.txt files will be reached in this folder

#### neo4j/logs
initially nothing in this folder, but after neo4j is started, log files will be reached in this folder

### postgres
This folder is for postgres docker image, only create-db and initial load scripts are under /postgres/sqls/local folder.

### Setting up the application
#### Local Configuration
- test database is created under /docker/postgres/sqls folder (if you want to change the db update these files)
- run the image `docker-compose --build --force-recreate migration postgres neo4j`

After your local run, if you want to run it again, than you have to clean the graph db data, 
better to run the `clean-graph.sh` script to delete the previously created configuration for graph data.


If everything is fine than given below output will be displayed
![NEO4J-IMAGE-OUTPUT](documents/img/docker-output.png?raw=true "Neo4j output")
 please wait till the indexes are created.

Afterwards you can reach the graph given link, when you click the link you will display the graph in a browser.
![GRAPH-DB](documents/img/graph-db.png?raw=true "Graph DB")

This is the result of imported csvs to graph db.
![IMPORT-OUTPUT](documents/img/import-output.png?raw=true "Import output")


###Caveat
node and edge names have been defined in the bash scripts in an array called NODES, so if you want to import specific node or edge, please update these arrays.
Arrays are inside these bash script files.
- /docker/migration/change-header.sh : NODES array for changing headers of the csv files
- /docker/migration/copy-from-postgres.sh : NODES array for copy command on postgresql to extract data to csv file

Also if you changed the nodes to be imported to the Graph DB, than you have to update the neo4j-admin import command parameters too.
this script is for importing csv files to graph db.
- /docker/neo4j/scripts/load-to-neo4j.sh

- sql script has to be inside the /docker/migration/sql folder and has to be one line, so save it in txt format.
- sql script txt file name and header txt file name has to be same.