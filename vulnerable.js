const express = require("express")
const app = express();

const secret_key = "my-super-secret"

app.get("/user" , (req,res)=>{
const userId = req.query.id;
const query = "SELECT * FROM users where id = " + userId;
res.send("Executing query : "+ query);
})

app.listen(3000 , ()=>{
console.log("server running")
});
