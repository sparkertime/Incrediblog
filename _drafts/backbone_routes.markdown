We learn in the context of what we already know. We pattern match against what we know and look for similarities. Our brains are lazy and efficient devices, and this process minimizes the amount of "new" stuff we need to learn all at once. However, this style of learning trades speed-of-knowledge-acquisition for a substantial risk of "false positives," of carrying valid information from one domain into another where it does not apply. This is dangerous, especially when we use this assumed knowledge in systems building.

# A Case Study in Backbone.js

Backbone.js is a Javascript MVC framework that is gaining in popularity every day. Many learners have backgrounds in server MVC frameworks like Rails and so it makes sense to carry of these paradigms over. Let's dig into carries with it some risk however, and there's no better example than the Backbone.js [Router](http://tbd).

When a Rails developer first sees the Backbone router, the natural reaction is "Oh cool, this is just like Rails routes, awesome!" In concept, this is absolutely true - they both provide addressable endpoints for browsers. However, from there it gets complicated.

## The State of Servers

In the world of web programming, we've had to make some compromises. With each request to the server, we have to answer two questions:

1. What has the user been doing in the past?
2. What is the user trying to do right now?

HTTP is an imperfect mechanism for answering those questions. Ideally we could extend the tendrils of our servers directly into every thread of every browser and hook directly into their computers to manage this. Instead, we rely on HTTP as an imperfect medium for this information, but we're clever chaps and so we make it work.

The first is typically solved by various ways of associating users with sessions. The second is almost always solved by the URL. In other words, we take an HTTP request for something like "POST /users/4/delete" and understand this to mean "I am trying to delete the user called 4"

This is the best we can do in the server, but we should not mistake this for the best we can do in any situation.

## Routes = State

