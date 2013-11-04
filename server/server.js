var http = require("http"),
url = require("url"),
fs = require("fs"),
mysql = require("mysql");

var connection = mysql.createConnection({ 
   user: "root", 
   password: "", 
   database: "mySQLTest"
}); 

http.createServer(function(request, response) {
    response.writeHead(200, {"Content-Type": "text/plain"});

    var parts = url.parse(request.url, true).pathname;


    request.on('end', function () {
        response.writeHead(200, {'Content-Type': 'x-application/json'}); 

        connection.query('SELECT * FROM foo;', function (error, rows, fields) { 
            response.write("Hello World\n");

            response.write(JSON.stringify(rows));
            response.end();      
    	});
    });

    // response.write('Here is your data: ' + parts + '\n');

    fs.readFile('test.txt', 'utf-8', function (error, data) {
        response.writeHead(200, {'Content-Type': 'text/plain'});
        data = 1;
        fs.writeFile('test.txt', data);
    });
   // response.end();
}).listen(8888);

