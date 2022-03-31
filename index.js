const express = require('express');
const hbs = require("hbs");
const wax = require("wax-on");
require('dotenv').config();


//must put in promise, so that we could use await async
//if you just import mysql2 without promise, you cannot access await async functions
const mysql = require("mysql2/promise")

const helpers = require("handlebars-helpers")({
    "handlebars": hbs.handlebars
})

const app = express();

//set up express
app.set("view enginee", "hbs");
app.use(express.urlencoded({
    extended: false
}))

wax.on(hbs.handlebars);
wax.setLayoutPath("./views/layouts")

//create connection with sql
async function main(){
//put local host - the database server is the same api address of express server
//you can have multiple express servers (for speed) connecting to the same mysql database
//load balancer for express server- just like lift algorithm send people to the right lift
//what if multiple servers - replication of database - shared database across database (might need to write codes)
//sharding - split 1 m people across different servers (each server is known as shard)
// premature optimization - root of all sins/bugs (plan large traffic before reaching it)
const connection = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASSWORD
})
}

main();


app.listen(3000, ()=>{
    console.log("server has started")
})