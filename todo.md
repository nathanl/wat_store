schema
  - [x] users (name, email, admin or no, api token)
  - [x] products (title, price_in_cents)
  - [x] orders (user id, product id, quantity, total, shipping status enum)

features:
  - [x] queries for all for all of this
  - [x] token auth
  - [x] mutation to create an order
  - [x] Some error handling? Creating an order fails if the product id doesn't exist
  - [ ] You can subscribe to shipping status updates on an order
  - [ ] you can't see orders that aren't yours unless you're an admin

maybe try fragments (only on user query side - user builds a custom object that doesn't really exist?), interfaces, unions
