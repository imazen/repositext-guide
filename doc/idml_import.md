IDML import
===========

How to
------

From command line:

    bundle exec bin/batch_import_idml_files_to_at_files '../idml_docs/*'

From Ruby script:

    doc = Kramdown::Parser::IDML.new(idml_file_name).parse
    at_doc = doc.to_kramdown

Internals
---------

Kramdown::Parser::IDML parses the _longest IDML story_ in the .idml file. You
can override this by passing an argument to the #parse method.

Once the IDML parser has identified the stories to be parsed, it passes them
to the Kramdown::Parser::IDMLStory.

[show call tree]

Paragraph style mappings
------------------------

Paragraph styles are mapped as shown below:

 Paragraph style                          | kramdown element and style
------------------------------------------|----------------------------
"ParagraphStyle/$ID/[No paragraph style]" | :p
"ParagraphStyle/Horizontal rule"          | :hr
"ParagraphStyle/IDParagraph"              | :p.id_paragraph
"ParagraphStyle/IDTitle1"                 | :p.id_title1
"ParagraphStyle/IDTitle2"                 | :p.id_title2
"ParagraphStyle/Normal"                   | :p.normal
"ParagraphStyle/Question1", "ParagraphStyle/Question2", "ParagraphStyle/Question3" | :p.q
"ParagraphStyle/Reading"                  | :p.reading
"ParagraphStyle/Scripture"                | :p.scr
"ParagraphStyle/Song stanza"              | :p.stanza
"ParagraphStyle/Song"                     | :p.song
"ParagraphStyle/Sub-title"                | :header, :level => 3
"ParagraphStyle/Title of Sermon"          | :header, :level => 1
Any other string                          | :p.lambda { normalize_style_name }
Anything else                             | :p

Character style mappings
------------------------

Character styles are mapped as shown below. Sometimes two nested kramdown
elements are used to represent the original style.

The "[Character style] -> [FontStyle]" denotes a font style applied to a
character style.

The .bold and .italic classes are added to :strong and :em elements only if other
classes are present. This is indicated by an optional class (e.g., [.italic]).
The reason for this is that we use :em elements to represent spans that could be
used for a number of reasons, more than just italic text.

 Character style [-> FontStyle]           | kramdown elements and style
------------------------------------------|----------------------------
'CharacterStyle/$ID/[No character style]'            | no parent element added, just inner text
'CharacterStyle/$ID/[No character style]' -> 'Italic | :em[.italic]
'CharacterStyle/$ID/[No character style]' -> 'Bold   | :strong[.bold]
'CharacterStyle/Bold'                                | :strong[.bold]
'CharacterStyle/Bold' -> 'Italic'                    | :strong.italic -> :em
'CharacterStyle/Bold Italic'                         | :strong.bold.italic -> :em
'CharacterStyle/Italic'                              | :em[.italic]
'CharacterStyle/Italic' -> 'Bold'                    | :strong.italic -> :em
'CharacterStyle/Regular'                             | no parent element added, just inner text
                                                     |
Others:                                              | add these classes or elements:
Any other character style                            | .lambda { normalize_style_name }
'CharacterStyle/Paragraph number'                    | .pn; convert parent paragraph style .normal to .normal-pn
'Underline' == 'true'                                | .underline
'Capitalization' == 'SmallCaps'                      | .smcaps
'FillColor' == 'Color/GAP RED'                       | :gap_mark

Other conversions
-----------------

* `<Br/> -> <p>` - Convert IDML Br tag to kramdown :paragraph element.
* `U+2028 -> <br/>` - Convert IDML Unicode 2028 (line separator) to kramdown :br element.

Discarded elements
------------------

We discard the following IDML story elements:

* HyperlinkTextDestination (used for bookmarks)
* Properties
* CharacterStyleRanges that contain only empty 'Content' children
