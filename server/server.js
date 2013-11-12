var http = require("http"),
url = require("url"),
fs = require("fs"),
mysql = require("mysql")
queryString = require("querystring"),
uri = require("uri");

var connectionToMySQL = mysql.createConnection({ 
   user: "root", 
   password: "", 
   database: "mySQLTest"
}); 

/*
    Sample link: http://localhost:8888/mysql?query=select+*+from+foo
 */

http.createServer(function(request, response, nyar) {
    response.writeHead(200, {"Content-Type": "text/plain"});

    // Figure out which databse to call
    var databasePathName = url.parse(request.url, true).pathname;
    var queryPathName = url.parse(request.url, true).query;
    var queryPathNameStringify = queryString.stringify(queryPathName);

    // Parse out the query 
    var fullQueryString = queryPathNameStringify.replace("query=", "");
    var finalQueryToDatabase = decodeURIComponent(fullQueryString);
    console.log("Query to be executed: \'"+finalQueryToDatabase+"\'");
    
    // Find out which database needs to be executed
    if (databasePathName == "/mysql") {
        console.log("mysql database needs to be executed")

        connectionToMySQL.query(finalQueryToDatabase+";", function (error, rows, fields) {
            // response.writeHead(200, {'Content-Type': 'x-application/json'}); 
            console.log(JSON.stringify(rows));
        });
    }
    else if (databasePathName == "/redis") {
        console.log("redis database needs to be executed")

    }
    else if (databasePathName == "/mongodb") {
        console.log("mongodb database needs to be executed")
    }
    else {
        console.log("Nothing was found");
    }



    // response.write('Here is your data: ' + parts + '\n');

    fs.readFile('test.txt', 'utf-8', function (error, data) {
        response.writeHead(200, {'Content-Type': 'text/plain'});
        data = 1;
        fs.writeFile('test.txt', data);
    });
   response.end();
}).listen(8888);

