//-------- Content Server --------

// create new database
db = db.getSiblingDB('content-server'); 

// create admin user with read/write access
db.createUser({
    user:"contentadmin", 
    pwd:"password", 
    roles:["readWrite", "dbAdmin"]
}); 

// create 'content' collection and indexes
db.createCollection("content"); 
db.content.createIndex({"uid":1}); 

// insert sample document
db.content.insert( {"comment":"This is a test document"}); 
db.content.find(); 
db.content.find().pretty(); 

//-------- Resource Server --------

//create new database
db = db.getSiblingDB('resource-server'); 

//create a admin user with read/write access
db.createUser({
    user:"resourceadmin", 
    pwd:"password", 
    roles:["readWrite", "dbAdmin"]
});

// create 'credentials' collection and indexes
db.createCollection("credentials"); 
db.credentials.createIndex({"uid":1}); 
db.credentials.createIndex({"data.owner":1}, {unique:true});

// insert sample document
db.credentials.insert( {"comment":"This is a test document"}); 
db.credentials.find(); 
db.credentials.find().pretty(); 

// create 'resources' collection and indexes
db.createCollection("resources");
db.resources.createIndex({"uid":1}); 
db.resources.createIndex({"data.owner":1}); 
db.resources.createIndex({"data.register":1}); 

// insert sample document
db.resources.insert({"comment":"This is a test document"}); 
db.resources.find(); 
db.resources.find().pretty(); 

