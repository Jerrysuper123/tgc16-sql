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
async function main() {
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

    // let query = "select * from actor";
    // //results will be an array, first element index 0 will contain all the rows in the query
    // let results = await connection.execute(query);
    // console.log(results[0]);
    app.get("./", function (req, res) {
        console.log("started");
        res.send("welcome");
    })

    app.get("./actors", async function (req, res) {
        //[actors] are to do array destructuring, destucture array into separate variables
        //actions store the first variable of the return result
        let [actors] = await connection.execute("select * from actor");
        //similar to let actors = results[0];
        console.log(actors);
        res.send("welcome");
        // res.render("actor.hbs",{
        //     "actors": actors
        // })
    })

    app.get("/actors/create", function(req, res){
        res.send("create_actor");
    })


    // never write below - high security risk sql injection risk
    //you directly embed variables into sql query string
    // people can input the query string into the variable when user submit
    app.post("actor/create", async function(req, res){
        //it is possible to type sql into req.body
        //we can escape the sql code into string, but hacker gets smarter
        // industry now use prepared statement
        let firstName = req.body.first_name;
        let lastName = req.body.last_name;

        //alwys write you test query first
        // insert into actor (first_name, last_name) values ("zoe", "tay")
        //do not use below
        // let query = `insert into actor (first_name, last_name) values (${firstName}, ${lastName})`;

        //use prepared statement
        // ? will be treated as literal string
        let query = `insert into actor (first_name, last_name) values (?, ?)`;
        //below firstName and LastName will be escaped string instead of sql code
        await connection.execute(query, [firstName, lastName]);
        res.send(query);
    })

}

main();

app.listen(3000, () => {
    console.log("server has started")
})