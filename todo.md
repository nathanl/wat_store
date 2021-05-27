schema
  - [x] users (name, email, admin or no, api token)
  - [x] products (title, price_in_cents)
  - [x] orders (user id, product id, quantity, total, shipping status enum)

features:
  - queries for all for all of this
  - mutation to create an order
  - you can't see orders that aren't yours unless you're an admin
  - You can subscribe to shipping status updates on an order
  - Some error handling? Maybe creating an order fails if you try to order more than $N
