var http = require("http"),
url = require("url"),
fs = require("fs"),
mysql = require("mysql");

var connection = mysql.createConnection({ 
   user: "root", 
   password: "", 
   database: "db_name"
}); 

http.createServer(function(request, response) {
   response.writeHead(200, {"Content-Type": "text/plain"});
   var _get = url.parse(request.url, true).query;
   response.write("Hello World\n");
   response.write('Here is your data: ' + _get['data'] + '\n');
   
   connection.query('SELECT * FROM your_table;', function (error, rows, fields) { 
   		response.writeHead(200, {'Content-Type': 'x-application/json'});         
		response.end(JSON.stringify(rows)); 
	}); 

    fs.readFile('test.txt', 'utf-8', function (error, data) {
        response.writeHead(200, {'Content-Type': 'text/plain'});
        data = parseInt(data) + 1;
        fs.writeFile('test.txt', data);
        response.end();
    });
   response.end();
}).listen(8888);
