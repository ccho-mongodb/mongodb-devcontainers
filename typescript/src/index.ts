const { MongoClient } = require("mongodb");

const uri = "mongodb://mongo-database:27017/";
const client = new MongoClient(uri);

async function run() {
  try {
    const database = client.db('sample_data');
    const movies = database.collection('movies');

    const query = { title: 'Back to the Future' };
    const movie = await movies.findOne(query);

    console.log(movie);
  } finally {
    await client.close();
  }
}
run().catch(console.dir);