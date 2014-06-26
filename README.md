Macys_iOS
=========

An application that features SQLite and JSON

iOS Programming Assignment #2

[DO NOT USE COREDATA FOR THIS]

Requirements

1. Use the latest Xcode and the project is created through File >New.

2. ARC enabled. 

3. Must support iOS 6 or higher.

4. Must support iPhone 4S and iPhone 5 screen sizes.

5. Use Image Assets container for images.

Assignment.

1. Review the Macy’s Objective C Style Guide.

https://github.com/johnnst/objective-c-style-guide

2. Review the following model.

Class = Product

Fields

id

name

description

regular price

sale price

product photo (image)

colors (array)

stores (dictionary)

3. Create a new app that showcases the following.

a. Creation of the model.

b. Create mock data for the models using json. Show case at least 3 mock 

products.

c. Use of sqlite to store the model. Implement the following.

i. INSERT

ii. SELECT

iii. DELETE

iv. UPDATE

d. Provide the main view controller will have a button that is labeled 

“Show Product” and “Create Product”.

i. Start with “Create Product” from the json data. You can either 

create buttons that say “Create Product 1”, “Create Product 

2”, etc, OR show a better way to dynamically create these 

products. This should effective INSERT a row into the products 

table.

ii. Next, “Show Product” should provide the user with a list 

of products in the database and selecting a product brings you 

to a product page. (Hint: Use SELECT statements)

freedom of UX here on how you want the information to be displayed.

e. Create a new view controller that shows the product. You have 

f. Provide buttons to “Update” and “Delete”. 

g. Touching the image thumbnail will show a full size image.

h. Please deliver view controllers and cells as h, m, and nib files. The only 

i. Please use as much as possible, UI objects from the native framework. 

j. Feel free to use any images or crop what’s available in the existing 

k. Please code to the Macy’s Objective C Style Guide. Also provide a 

l. Document any 3rd

m. Unit tests is optional but a big plus (XCTest framework only).

4. After you are done, submit via github or bitbucket.

exception is the first view controller launched from the storyboard.

app. 

summary of your approach and design decisions.

 party libraries used and why.
