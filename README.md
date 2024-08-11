# moderner-acad-cv

This template for an academic CV serves the peculiarities of academic CVs. If you are not an academic, this template is not useful. Most of the times in academics, applicants need to show everything they have done. This makes it a bit cumbersome doing it by single entries. In addition, academics might apply to institutions around the globe, making it necessary to send translated CVs or at least translations of some parts (i.e., title of papers in different languages). 

This template serves these special needs in introducting automated sections based on indicated `yaml`-files. Furthermore, it has a simplified i18n-support by setting different headers, title etc. for different languages (by the user in the `yaml`-fields). With this template, it might be more handy to keep your CV easier on track, especially when you need in different languages, since managing a `yaml`-file is easier than checking typesetting files against each other. 

This template is influenced by LaTeX's [moderncv](https://github.com/moderncv/moderncv) and its typst translation [moderner-cv](https://github.com/DeveloperPaul123/modern-cv).

## Fonts

In this template, the use of FontAwesome icons via the [fontawesome typst package](https://typst.app/universe/package/fontawesome) is possible, as well as the icons from Academicons [use-academicons typst package](https://typst.app/universe/package/use-academicons). To use these icons properly, you need to install each fonts on your system. You can download [fontawesome here](https://fontawesome.com/download) and [academicons here](https://jpswalsh.github.io/academicons/). Both typst packages will be load by the template itself.

Furthermore, I included my favorite font [Fira Sans](https://fonts.google.com/specimen/Fira+Sans). You can download it here [here](https://fonts.google.com/specimen/Fira+Sans), or just change the font argument in `modern-acad-cv()`. 

## Usage

The main function to load the construct of the academic CV is `modern-acad-cv()`. After importing the template, you can call it right away. If you don't have [Fira Sans](https://fonts.google.com/specimen/Fira+Sans) installed, choose a different font.

```typst
#import "@preview/modern-acad-cv:0.1.0": *

#show: modern-acad-cv.with(
  metadata, 
  myself: true, 
  lang: "en",   
  font: "Fira Sans", 
  show-date: true
)    

// ...
```
In the remainder, I show basic settings and how to use the automated functions with the corresponding `yaml`-file.

### Setting up the main file and the access to the `yaml`-files
A first step in your document is to invoke the template. Second, since this template works with `yaml`-files in the background you need to specify paths to each `yaml`-file you want to use throughout the document. 

The template comes along with the `metadata.yaml`. In the beginning of this yaml-file you set colors and paths to the other `yaml` files:
```yaml
colors:
  main_color: "#579D90"
  lightgray_color: "#d5d5d5"
  gray_color: "#737373"
paths: 
  i18n: "dbs/i18n.yaml"
  refs: "dbs/refs.yaml"
  committee: "dbs/committee.yaml"
  ...
```

At the beginning of your document, you just set then set the metadata-object:
```typst
#import "@preview/modern-acad-cv": *

#let metadata = yaml("metadata.yaml")
```

Initially, the `metadata.yaml` is located on the same level as the `example.typ`. All other `yaml`-files are saved in the folder `dbs`. You have to transfer this object to most functions, so that the paths defined in `metadata` will be found by the other functions.

### Language setting & headers
In order to support changing headers, you need to specify the language and the different content for each header in each language in the `i18n.yaml` in the folder `dbs`. 

The structure of the yaml is simple:
```yaml
lang:
  de:
    subtitle: Short CV
    education: Hochschulbildung
    work: Akademische Berufserfahrung (Auswahl)
    grants: Fördermittel, Stipendien & Preise
    ...
  en:
    subtitle: Short CV
    education: Higher education
    work: Academic work experience (selection)
    grants: Scholarships & awards
    ...
  pt:
    subtitle: Currículo
    education: Formação acadêmica
    work: Atuação profissional (seleção)
    grants: Bolsas de estudo e prémios
    ...
```

For each language, you want to use later, you have to define all the entries. Reminder, don't change the entry names, since the functions won't find it under different names without changing the functions.

First you have to set up a variable that inherits the ISO-language code:
```typst
// set the language of the document
#let language = "pt"      

// defining variables
#let headerLabs = create-headers(metadata.paths.i18n, lang: language)
```

Second you create an object headerLabs that uses the function `create-headers()` which will define the headers as you provided in the yaml. Then by switching the language object, all headers (if used accordingly to the naming in the yaml) will change directly.

Throughout the document you then reference the created `headerLabs` object. If you change language, and values are provided, these automatically change. 

```typst
= #headerLabs.at("work")

...

= #headerLabs.at("education")

...

= #headerLabs.at("grants")
```

### socials
Contact details are important. In this CV template, you have the possibility to use fontawesome icons and academicons. To use socials, you just need to specify in `metadata.yaml`, the wanted entries. 

As you can see below, you set a category, i.e. email or lattes and then you have to define four arguments: `username`, `prefix`, `icon`, and `set`. The `username` will be used for constructing the link and will be shown next to the logo. The `prefix` is needed to build the valid link. The `icon` is the name of the icon in the respective set, which is chosen in `set`. 

```yaml
personal:
  name: ["Mustermensch, Momo"]
  socials:
    email:
      username: momo@mustermensch.com
      prefix: "mailto:"
      icon: paper-plane
      set: fa
    homepage:
      username: momo.github.io
      prefix: https://
      icon: globe
      set: fa
    orcid:
      username: 0000-0000-0000-0000
      prefix: https://orcid.org
      icon: orcid
      set: ai
    lattes:
      username: "1234567891234567"
      prefix: http://lattes.cnpq.br/
      icon: lattes
      set: ai
```

### Automated functions
All of the following functions share common arguments: `what`, `metadata`, and `lang`. In `what`, you always declare the part of the name that is referenced in the `metadata.yaml` under `paths`.

For example, to get the path to your work entries, you choose `work`, for your participation at conferencs, `conferences`. In language, you will always define the language of the document; just refer to your created object at the beginning.

In the `metadata` argument, you just pass the `metadata` object. In lang you pass your `language` object. 

```yaml
paths: 
  work: "dbs/work.yaml"
  conferences: "dbs/conferences.yaml"
  ....
```

### Sorting publications and referencing your own name or correpsonding
Since `typst` so far does not support multiple bibliographies or subsetting these, this function let you choose specific entries via the `entries` argument or group of entries by the `tag` argument. Furthermore, you can indicate a string in `me` that can be highlighted in every output entry (i.e., your formatted name). So far, this function leads to another function that create APA-style format, if you want to use any other, you need to download the template on [github](https://github.com/bpkleer/modern-acad-cv), introduce your own styling and then add it in the `cv-refs()` function. 

```typst
let cv-refs(
  what: "",
  metadata: (:),  
  entries: (), 
  tag: none,
  me: none,
  lang: "de"
)
```

You see in the example that I used this function to built five different subheaders, i.e. for peer reviewed articles and chapters in edited books. Both functions are wrapped within `cv-cols` to adhere to the separation of columns troughout the document. 

```typst
#cv-cols(
  "",
  cv-refs(what: "refs", metadata: metadata, tag: "peer", me: [Mustermensch, M.], lang: language)
)

...

#cv-cols(
  "",
  cv-refs(what: "refs", metadata: metadata, tag: "edited", me: [Mustermensch, M.], lang: language)
) 

```

Sometimes, it is not only necessary to highlight your own name, you might also want to indicate yourself as corresponding author. This can be done through the `refs.yaml` which adhere to [Hayagriva](https://github.com/typst/hayagriva). By adding an argument `corresponding` in the yaml and setting the value to `true`, a small `C` will appear next to your name. 

```yaml
Mustermensch2023:
  type: "article"
  date: 2023
  page-range: 55-78
  title: "Populism and Social Media: A Comparative Study of Political Mobilization"
  tags: "peer"
  author: [ "Mustermensch, Momo", "Rivera, Casey" ]
  corresponding: true
  parent:
    title: "Journal of Political Communication"
    volume: 41
    issue: 3
  serial-number:
    doi: "10.1016/j.jpolcom.2023.102865"
```

### cv-auto-skills()
Instead of just enumerating your skills or your knowledge of specific software, you can build a skill-matrix with this function. In this skill-matrix, you can have sections, i.e. *Computer Languages*, *Programs* and *Languages*. These sections are the highest level in the corresponding `skills.yaml`:

```yaml
computer:
  ...
programs:
  ...
languages:
  ...

```

You can then define in each categories specific skills, i.e. German and Portuguese in `languages`:

```yaml
computer:
  ...
programs:
  ...
languages:
  german:
    ...
  portugues:
   ...

```

For each entry, you have to define `name`, `level` and `description`.

```yaml
languages: 
  ...
  pt: 
    name:
      de: Portugiesisch
      en: Portuguese
      pt: Português
    level: 3
    description:
      de: fortgeschritten
      en: advanced
      pt: avançado
```

As you can see, you can again define language-dependent names in `name` and descriptions in `description`. `level` is a numeric value and indicates how many of the four boxes are filled to indicate you level of proficiency. If you don't have the need for a CV of different languages, you can directly define `name` or `description`.

You get this function with the three standard arguments `what`, `metadata`, and `lang`:

```typst
#cv-auto-skills(
  what: "skills",
  metadata: metadata,          
  lang: "de"    
)
``` 

### cv-subcats-aut()

- cv-subcats-aut(
  what: "",
  metadata: (:),   
  lang: "de"
)



### cv-auto-stc()
- #let cv-auto-stc(
  what: "",
  metadata: (:),    
  lang: "de" 
)

### cv-auto-stp()
-#let cv-auto-stp(
  what: "", 
  metadata: (:),    
  lang: ""
)

### cv-auto-table()
- #let cv-auto-table(
  what: "", 
  metadata: (:),          
  lang: ""  
)

### cv-auto-list()
- #let cv-auto-list(
  what: "",
  metadata: (:),        
  lang: "de"   
)

### cv-auto()
-#let cv-auto(
  what: "",
  metadata: (:),
  lang: "de"
)

### Special cases: long names

## Examples

![Momo Mustermensch's CV](assets/example1.png)
![Momo Mustermensch's CV](assets/example2.png)
![Momo Mustermensch's CV](assets/example3.png)
![Momo Mustermensch's CV](assets/example4.png)

