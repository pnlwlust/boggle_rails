# README

## System dependencies

* Ruby
* Rails 
* Nodejs  and npm
*yarn

## Configuration

### Running app

#####Install all dependencies
Clone the project
`git clone  https://github.com/pnlwlust/boggle_rails.git`

Go to the root directory
`cd boggle_rails`

Install the dependencies 

```
bundle install (Installs dependencies from Gem file)

yarn install (Installs dependencies from package.json)

rails server
```

App should be running on **localhost:3000** (or check the console for address)


####Game Page Ux
![Game Page](/public/boggle_game_page.png)


###Game Rules

*Search for words that can be constructed from the letters of sequentially adjacent cubes,
where "adjacent" cubes are those horizontally, vertically, and diagonally neighboring.
Words must be at least three letters long, may include singular and plural (or other derived forms) separately,
but may not use the same letter cube more than once per word. Enter each word and click on validate.
After three minutes have elapsed, timer will stop and you will get you final result.*

**Score**

Length | Points
------- | -------
<3      |  0
3,4      | 1
5        | 2
6         | 3
7         | 5
8+        | 11
