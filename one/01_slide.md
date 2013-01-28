!SLIDE
in the trenches

!SLIDE
# real web applications
- iContact
- Reverbnation

.notes  - from 2 to 300 employees
.notes  - scaled from 100k emails per day over to 75 million
.notes - 2 million artists

!SLIDE
# being just a DBA sucks
.notes photo of nerd guy with lots of pc parts or wires or something
.notes who here is a "dba"?
.notes photo of folks looking down at mysql?

!SLIDE
# this is most every web app
.notes upside down pyramid, DB at the bottom
.notes tendency toward disorder, ends up in the DB
.notes query cache?!

!SLIDE
# find a rock (something to push uphill)
.notes dumbest method possible, show processlist
.notes do AB on "web app" loading things, like a count of comments, from active users, show "out of
connections errors"

!SLIDE
# push the rock
.notes add caching, run test again
.notes WHAT?!

!SLIDE
# quit running this query, cache it!
.notes how do we prevent stuff from coming downhill?

