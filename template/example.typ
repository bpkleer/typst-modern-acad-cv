// #import "modern-acad-cv.typ": *
#import "@preview/modern-acad-cv": *

// loading meta data (needs to be ad this directory)
#let metadata = yaml("metadata.yaml") 

// set the language of the document
#let language = "pt"      

// defining variables
#let headerLabs = create-headers(metadata.paths.i18n, lang: language)

#show: modern-acad-cv.with(
  metadata, 
  myself: true, 
  lang: language,   
  font: "Fira Sans",
  show-date: true
)    

= #headerLabs.at("work")

#cv-auto-stc(what: "work", metadata: metadata, lang: language)

= #headerLabs.at("education")

#cv-auto-stp(what: "education", metadata: metadata, lang: language) 

= #headerLabs.at("grants")
 
#cv-auto-stp(what: "grants", metadata: metadata, lang: language)  
 
= #headerLabs.at("pubs")

#cv-cols(
  "",
  for lang in yaml(metadata.paths.i18n).lang.keys() {
    if language == lang [
      #yaml(metadata.paths.i18n).lang.at(lang).pubs-note
    ] 
  }
)  

== #headerLabs.at("pubs-peer")
#cv-cols(
  "",
  cv-refs(what: "refs", metadata: metadata, tag: "peer", me: [Mustermensch, M.], lang: language)
)

== #headerLabs.at("pubs-edited")
#cv-cols(
  "",
  cv-refs(what: "refs", metadata: metadata, tag: "edited", me: [Mustermensch, M.], lang: language)
) 

== #headerLabs.at("pubs-book")
#cv-cols(
  "",
  cv-refs(what: "refs", metadata: metadata, tag: "book", me: [Mustermensch, M.], lang: language)
) 

== #headerLabs.at("pubs-reports")
#cv-cols(
  "",
  cv-refs(what: "refs", metadata: metadata, tag: "other", me: [Kleer, P.], lang: language)
)

== #headerLabs.at("pubs-upcoming")
#cv-cols(
  "",
  cv-refs(what: "refs", metadata: metadata, tag: "planned", me: [Kleer, P.], lang: language) 
)

= #headerLabs.at("confs") 
== #headerLabs.at("confs-conf")
#cv-cols(
  "", 
  headerLabs.at("exp-confs")
)

#cv-auto-list(what: "conferences", metadata: metadata, lang: language)

== #headerLabs.at("confs-talks")
 
#cv-auto(what: "talks", metadata: metadata, lang: language)

= #headerLabs.at("committee")

#cv-auto(what: "committee", metadata: metadata, lang: language)

= #headerLabs.at("teaching")

== #headerLabs.at("teaching-thesis")
#if language == "de" [
  #cv-two-items[Bachelor][9][Master][2]
] else if language == "en" [
  #cv-two-items[Bachelor][9][Master][2]
] else if language == "pt" [
  #cv-two-items[Graduação][9][Pós-Graduação][2]
] else [
  #cv-two-items[Bachelor][9][Master][2]
]

== #headerLabs.at("teaching-courses")

#cv-auto-table(what: "teaching", metadata: metadata, lang: language)

= #headerLabs.at("training")

#cv-subcats-aut(what: "training", metadata: metadata, lang: language)

= #headerLabs.at("others")

#cv-auto-skills(what: "skills", metadata: metadata, lang: language)
