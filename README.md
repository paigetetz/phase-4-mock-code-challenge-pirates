# Rails Mock Code Challenge - Pirates

For this assessment, you'll be working with the Pirates domain.

In this repo, there is a Rails application with some features built out. There
is also a fully built React frontend application, so you can test if your API is
working.

Your job is to build out the Rails API to add the functionality described in the
deliverables below.

## Setup

To download the dependencies for the frontend and backend, run:

```sh
bundle install
```

There is some starter code in the `db/seeds.rb` file so that once you've
generated the models, you'll be able to create data to test your application.

You can run your Rails API on [`localhost:3000`](http://localhost:3000) by
running:

```sh
rails s
```

There is no React front-end for this challenge.

There are tests included which you can run using `rspec` to check your
work.

Depending on your preference, you can either check your progress by:

- Running `rspec` and seeing if your code passes the tests
- Running the React application in the browser and interacting with the API via
  the frontend
- Running the Rails server and using Postman to make requests

## Models

There are three models in the domain: `Pirate`, `Island`, and `Treasure`.

You need to create the following relationships:

- A `Pirate` has many `Island`s through `Treasure`
- An `Island` has many `Pirate`s through `Treasure`
- A `Treasure` belongs to a `Pirate` and belongs to an `Island`

Start by creating the models and migrations for the following database tables:

### Pirate:

| Column    | Data Type |
|-----------|-----------|
| id        | integer   |
| name      | string    |
| age       | integer   |

### Island:

| Column       | Data Type |
|--------------|-----------|
| id           | integer   |
| name         | string    |

### Treasure:

| Column    | Data Type |
|-----------|-----------|
| id        | integer   |
| contents  | string    |
| pirate_id | integer   |
| island_id | integer   |

If you use a Rails generator to create the models, make sure to use the
`--no-test-framework` flag to avoid overwriting the test files.

Add any code needed in the model files to establish the relationships.

Then, run the migrations and seed file:

```sh
rails db:migrate db:seed
```

## Validations

Add validations to the `Pirate` model:

- `name` must be present
- `age` must be between 18 and 100 (inclusive - 18 and 100 are okay)

Add validations to the `Island` model:

- `name` must be present

Add validations to the `Treasure` model:

- `pirate_id` must be a number greater than 0
- `island_id` must be a number greater than 0

## Routes

Set up the following routes. Make sure to return JSON data in the format
specified along with the appropriate HTTP verb.

### GET /pirates

Return JSON data in the format below:

```json
[
  {
    "id": 1,
    "name": "Blackbeard",
    "age": 35
  },
  {
    "id": 2,
    "name": "Bluebeard",
    "age": 40
  }
]
```

### GET /pirates/:id

If the `Pirate` exists, return JSON data in the format below:

```json
{
  "id": 1,
  "name": "Blackbeard",
  "ship_name": "Queen Anne's Revenge",
  "age": 35,
  "islands": [
    {
      "id": 1,
      "name": "Ocracoke"
    },
    {
      "id": 3,
      "name": "Trinidad"
    }
  ]
}
```

If the `Pirate` does not exist, return the following JSON data, along with the
appropriate HTTP status code:

```json
{
  "error": "Pirate not found"
}
```

### DELETE /pirates/:id

If the `Pirate` exists, it should be removed from the database, along with any
`Treasure`s that are associated with it.

After deleting the `Pirate`, return an _empty_ response body, along with the
appropriate HTTP status code.

If the `Pirate` does not exist, return the following JSON data, along with the
appropriate HTTP status code:

```json
{
  "error": "Pirate not found"
}
```

### GET /islands

Return JSON data in the format below:

```json
[
  {
    "id": 1,
    "name": "Ocracoke"
  },
  {
    "id": 2,
    "name": "Jamaica"
  }
]
```

### POST /treasures

This route should create a new `Treasure` that is associated with an existing
`Pirate` and `Island`. It should accept an object with the following properties
in the body of the request:

```json
{
  "contents": "Spanish gold!",
  "pirate_id": 2,
  "island_id": 5
}
```

If the `Treasure` is created successfully, send back a response with the
following data:

```json
{
  "id": 1,
  "contents": "Spanish gold!",
  "pirate": {
    "id": 2,
    "name": "Bluebeard",
    "age": 40
  },
  "island": {
    "id": 5,
    "name": "Tortuga"
  }
}
```

If the `Treasure` is **not** created successfully, return the following JSON
data, along with the appropriate HTTP status code:

```json
{
  "errors": ["show your validation errors here"]
}
```
