const express = require("express");
const path = require("path");
const app = express();

app.use("/wazer", express.static(path.join(__dirname, "dist")));
app.get("/wazer/*", (req, res) => {
  res.sendFile(path.join(__dirname, "dist/index.html"));
});
app.get("/wazer", (req, res) => {
  res.sendFile(path.join(__dirname, "dist/index.html"));
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server started on port ${port}`);
});
