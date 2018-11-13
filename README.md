# Dog Walkings


### Project

#### Dependencies

- Docker 18.09
- Docker-compose 1.21

#### How to run

run:

```
./scripts/dog_walking setup
```

then:
```
./scripts/dog_walking
```

#### Running the tests

```
./scripts/dog_walkings rspec
```

### Api Documentation

#### Summary

- Dog walkings
  - [index](#index)
  - [show](#show)
  - [create](#create)
  - [start_walk](#start_walk)
  - [finish_walk](#finish_walk)

#### Docs

##### Index
###### Listing Dog Walkings
**_([Voltar](#summary))_**

```
# GET /v1/dog_walkings
```

Sample:

```
curl -X GET http://0.0.0.0:3000/v1/dog_walkings
```

Example Response:

```
HTTP 200 OK
{
  dog_walkings: [
    {
      id: 1,
      appointment_date: 2018/10/01 - 12:31:00,
      price: 35.00,
      duration: 30,
      start_date: 2018/10/01 - 12:31:00,
      end_date: 2018/10/01 - 13:01:00,
      latitude: 0.0,
      longitude: 0.0,
      created_at: 2018/10/01 - 00:00:00,
      updated_at: 2018/10/01 - 00:00:00,
      pets: [
        {
          id: 582,
          name: Tutti,
          created_at: 2018-11-13T08:39:38.466-02:00,
          updated_at: 2018-11-13T08:39:38.466-02:00
        }
      ]
    }
    {
      # other dog_walking here
    }
  ]
}
```

Obs: you can send an optional flag param not_started to return only the future
walkings

Example:

```
curl -X GET 'http://0.0.0.0:3000/v1/dog_walkings?not_started=true'
```

##### Show

**_([Voltar](#summary))_**

```
# GET /v1/dog_walkings/:id
```

Sample:

```
curl -X GET http://0.0.0.0:3000/v1/dog_walkings/1
```

Example Response:

```
HTTP 200 OK

dog_walking:
  {
    id: 1,
    appointment_date: 2018/10/01 - 12:31:00,
    price: 35.00,
    duration: 27, # returns the true duration of the walking
    start_date: 2018/10/01 - 12:31:00,
    end_date: 2018/10/01 - 13:01:00,
    latitude: 0.0,
    longitude: 0.0,
    created_at: 2018/10/01 - 00:00:00,
    updated_at: 2018/10/01 - 00:00:00,
    pets: [
      {
        id: 582,
        name: Tutti,
        created_at: 2018-11-13T08:39:38.466-02:00,
        updated_at: 2018-11-13T08:39:38.466-02:00
      }
    ]
  }
```

##### Create
**_([Voltar](#summary))_**

```
# POST /v1/dog_walkings
```

Sample:

```
curl -X POST http://0.0.0.0:3000/v1/dog_walkings \
-d 'appointment_date: 2018/10/01 - 12:31:00' \
-d 'price: 35.00' \
-d 'duration: 30' \
-d 'start_date: 2018/10/01 - 12:31:00' \
-d 'end_date: 2018/10/01 - 13:01:00' \
-d 'latitude: 0.0' \
-d 'longitude: 0.0' \
-d 'pet_ids: [582]'

```

Example Response:

```
HTTP 201 CREATED

dog_walking:
  {
    id: 1,
    appointment_date: 2018/10/01 - 12:31:00,
    price: 35.00,
    duration: 27, # returns the true duration of the walking
    start_date: 2018/10/01 - 12:31:00,
    end_date: 2018/10/01 - 13:01:00,
    latitude: 0.0,
    longitude: 0.0,
    created_at: 2018/10/01 - 00:00:00,
    updated_at: 2018/10/01 - 00:00:00,
    pets: [
      {
        id: 582,
        name: Tutti,
        created_at: 2018-11-13T08:39:38.466-02:00,
        updated_at: 2018-11-13T08:39:38.466-02:00
      }
    ]
  }
```

##### start_walk
**_([Voltar](#summary))_**

```
# PUT /v1/dog_walkings/:id/start_walk
```

Sample:

```
curl -X PUT http://0.0.0.0:3000/v1/dog_walkings/1/start_walk
```

Example Response:

```
HTTP 200 OK
```
obs: this route doesn't have a response body

##### finish_walk
**_([Voltar](#summary))_**

```
# PUT /v1/dog_walkings/:id/finish_walk
```

Sample:

```
curl -X PUT http://0.0.0.0:3000/v1/dog_walkings/1/finish_walk
```

Example Response:

```
HTTP 200 OK
```
obs: this route doesn't have a response body
