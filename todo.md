schema
  - users (name, email, admin or no, api token)
  - products (title, price_in_cents)
  - orders (user id, product id, quantity, total, shipping status enum)

features:
  - queries for all for all of this
  - select from the db only the fields the user queries for?
  - mutation to create an order
  - you can't see orders that aren't yours unless you're an admin
  - You can subscribe to shipping status updates on an order
  - Some error handling? Maybe creating an order fails if you try to order more than $N

Products:
  - Pickle juicer
  - Toast mittens
  - Horse paint
  - Smart spoon
  - Bird collar
  - Toilet bling
  - Cat softener
  - Meeting simulator ($$$$)
