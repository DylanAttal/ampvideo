# AmpVideo demo app

## Getting started

I built this app with Node 17, Ruby 3, VueCli 4, and Rails 6. Also, I built and ran this demo app on a Mac; running the app with different versions of the technologies or on a Windows machine might introduce issues.

In `ampvideo/user-interface` run
`npm i` then `npm run serve`. The UI should be running on localhost:8080 now. It's important to run on this port to avoid CORS issues.

In `ampvideo/api` run `bundle install` then `rails s`. Your API should now be running on localhost:3000. This port is important because the UI will be sending API calls to this specific port.

The database is expected to be running on localhost:5432.

## A note on calculating the `ranking_score` of each video:

In the instructions, the formula given for calculating `ranking_score` is `((estimated_seconds_watched) / (video_length_second)) * (number of views)`, but this does not match up with the sample data in the given table:

```
title                                       | url                                         | thumbnailurl                | owner_name         | category | view_count | video_length_second | ranking_score
--------------------------------------------+---------------------------------------------+-----------------------------+--------------------+----------+------------+---------------------+--------------
My lime Mazda Escalade                      | https://www.youtube.com/watch?v=dQw4w9WgXcQ | http://placeimg.com/200/130 | Hannah_Bergnaum    |   [NULL] |        241 |                4456 |  119.07
Learn the secrets of Awesome Plastic Salad! | https://www.youtube.com/watch?v=M6PZ3aPV91Q | http://placeimg.com/200/130 | Frederique.Emard21 |   [NULL] |        191 |                 645 |  87.32
Fix a Volkswagen Escalade yourself          | https://www.youtube.com/watch?v=dQw4w9WgXcQ | http://placeimg.com/200/130 | Brennan.Rau        |   [NULL] |          0 |                6118 |  0
```

The given `ranking_score` for the video "My lime Mazda Escalade" is `119.07`.

The data for this video (assuming we use whole numbers only) is as follows:

```
	{
		"title": "My lime Mazda Escalade",
		"thumbnail": "http://placeimg.com/200/130",
		"owner": "Hannah_Bergnaum"
		"secondsWatched": 530581,
		"videoLength": 4456,
		"views": 241,
		"rank": 28679,
	}
```

The given `ranking_score` is the `secondsWatched / videoLength` i.e. `530581 / 4456` --> `119`, but according to the given formula we need to multiply this value by `views`, i.e. `119 * 241` --> `28,679`.

I used the full formula for my calculations, taking the number of views into account for the calculation of the rank.
