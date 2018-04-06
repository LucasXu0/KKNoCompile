#!/usr/local/bin/node

var http        = require('http');
var url         = require('url');
var util        = require('util');
var JPConvertor = require('./js/JPConvertor.js');
var shell       = require("shelljs");
var fs          = require("fs");
var net         = require('net');

var server = new net.Server();

server.listen(9527, function() {
  console.log('机甲开始监听');
});

server.on('connection', function(socket) {

  console.log("机甲已连接 %j:%j",socket.remoteAddress,socket.remotePort);

  http.createServer(function(req, res){
      res.writeHead(200, {'Content-Type': 'text/plain;charset:utf-8'});

      // 解析 url 参数
      var params = url.parse(req.url, true).query;

      var file_name   = params.filename     // 传入文件名
      var input_string  = params.inputstring  // 待修改函数

      // 处理函数
      input_string = input_string.replace('\n', '');
      // console.log(input_string);
      input_string = new Buffer(input_string, 'base64').toString();
      console.log("机甲待修复:");
      console.log(input_string);

      // 代码转换
      var result;
      JPConvertor.convertor(input_string, function(r, error) {
          result = r;
          console.log("\n机甲处理中:\n" + r);
      });

      // 写入文件
      console.log("\n机甲开始注入" + file_name);
      fs.writeFile(file_name, result,  function(err) {
         if (err) {
             return console.error(err);
         }

         fs.readFile(file_name, function (err, data) {
            if (err) {
               return console.error(err);
            }
            console.log("\n机甲注入成功\n" + data.toString());

            res.write("File Name:" + file_name);
            res.write("\n");
            res.write("Input String:" + input_string);
            res.write("\n");
            res.write("写入成功");
            res.end();
         });
      });

      socket.write('机甲修复完成', function() {
        console.log('机甲修复完成');
      });
  }).listen(9526);
  //
  // socket.on("error",function(err){
  //     console.log("机甲错误" + err);
  // });
  //
  // socket.on("close",function(had_error){
  //     if(!had_error){
  //         console.log("机甲被动关闭 %j:%j",socket.remoteAddress,socket.remotePort);
  //     }
  //     else{
  //         console.log("机甲主动关闭 %j:%j",socket.remoteAddress,socket.remotePort);
  //     }
  // });
});
