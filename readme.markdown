#Intro

Similis is the latin word for "resembling" (at least according to Google Translate) and it fits just right, since Similis is a ruby gem that attemps to find similar words, using the most common algorithms.

#What can I do with it?

The main purpose of Similis is to help in the task of word matching. It is meant to be used with one or several dictionaries to help it check for valid options. 

##So, what can you do with it?

Here are some examples:

+ You can use it on your web app to help users correct search terms. Kind of (but not exactly) like the "Did you know?" feature found on most search engines.

+ You can use it on your command line application, to help the user correct attributes. Did you ever try doing _git brnch_? Well, kind of like that.


##What algorithms are used?

The following algorithms are supported or will be supported on future versions of the gem:

+ Levenshtein distance. **Already in**
+ Soundex **Already in**
+ Metaphone **Not supported yet**
+ Needleman-Wunsch  **Not supported yet**
+ Jaro-Winkler distance  **Not supported yet**
+ Your own custom algorithm **Not supported yet**

#How can I use it?

Finding the most similar word (or words) to a given one is pretty simple, all you have to do is:

1. Load your list of valid words into an array. This could be from a file if there are many, or just a list of valid words hardcoded.
2. Do one of the following:

**Use the default method (Levenshtein distance)**
```ruby
  Similis.find_similar(your_word, my_valid_list) 
```
That code will return the most similar word, or a list of them (if they have the same Levenshtein distance).

**Use a specific method**

You can also preprocess your list, if the algorithm allows it to, in order to find quickly search through the list in the future.

Here is how:

```ruby
Similis.preprocess({:my_list => valid_list}).with(:soundex)
Similis.find_similar(my_word, :my_list)
Similis.find_similar(my_other_word, :my_list)
```

Both calls to ```find_similar``` will use the _soundex_ algorithm, since you're referencing the list that was pre-processed using that algorithm.

Please note that you can't do this with the _Levenshtein distance_ algorithm, since it'll always require the input word to calculate the distance.

#Installing the gem

Right now, there is no gem binary, but once I have a tested version of the code, I'll get it up on rubygems.org.

#Questions? Suggestions?

If you have any, just e-mail me at deleteman@gmail.com I'll be glad to hear from you!
