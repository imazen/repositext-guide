Hi there,

I think we should have a plan in place for repository layout. We're getting to the point where we have to process lots of files and I think a bit of structure will help.

I've documented a few options below for discussion. My current preference is **Directory layout grouped by workflow then year**, however that's based on thinking about this for 15 minutes, so it's likely to change.

What do you think?

File types
----------

To help with automating processes (e.g., validation policies), it would be helpful to have expressive file names. We've used `.at` for all kinds of different files (idml import, folio import, master document) and I think we need a bit more differentiation. Below is one suggestion where we use name segments separated by dots with the following elements:

1. Language and time code <LTC>(e.g., 'ENG65-0134')
1. Import source <optional>(e.g., docx, folio, idml)
1. Document type <optional>(e.g., deleted_text, editors_notes, warnings)
1. File extension (e.g., at, md, json, txt, idml, xml)

Here is a list of different names I could think of for each tape:

* `<LTC>.at` master kramdown document
* `<LTC>.metadata.json` master tape level metadata


* `<LTC>.docx` docx import source file
* `<LTC>.docx.at` kramdown file imported from docx


* `<LTC>.folio.at` kramdown file imported from folio.xml
* `<LTC>.folio.deleted_text.json` text that was deleted while importing folio.xml
* `<LTC>.folio.editors_notes.json` editors notes that were extracted while importing folio.xml
* `<LTC>.folio.warnings.json` warnings that were raised while importing folio.xml
* `<LTC>.folio.xml` folio.xml import source file


* `<LTC>.idml` idml import source file
* `<LTC>.idml.at` kramdown file imported from idml
* `<LTC>.idml.warnings.json` warnings that were raised while importing idml

Directory layout grouped by workflow then year
----------------------------------------------

We group first by workflow, then by year. The advantage of this approach is that it groups all files that would likely be touched by a script in a single folder. It also maps nicely to the mindset/concept of the person working on the files.

* `/vgr-english`
    * `/content` (this is where master files are located)
        * `/47`
            * `ENG47-0101.at`
            * `ENG47-0101.metadata.json`
        * ...
        * `/65`
            * ...
    * `/export_idml` (do we need folders for export files in repo?)
        * `/47`
        * ...
        * `/65`
            * ...
    * `/import_docx` (all files related to importing from docx)
        * `/47`
            * `ENG47-0101.docx.at`
            * `ENG47-0101.docx`
        * ...
        * `/65`
            * ...
    * `/import_folio` (all files related to importing from folio)
        * `/47`
            * `ENG47-0101.folio.at`
            * `ENG47-0101.folio.deleted_text.json`
            * `ENG47-0101.folio.editors_notes.json`
            * `ENG47-0101.folio.warnings.json`
            * `ENG47-0101.folio.xml`
        * ...
        * `/65`
            * ...
    * `/import_idml` (all files related to importing from idml)
        * `/47`
            * `ENG47-0101.idml.at`
            * `ENG47-0101.idml.warnings.json`
            * `ENG47-0101.idml`
        * ...
        * `/65`
            * ...
    * `readme.md` Instructions for the repo

Directory layout grouped by year then workflow
----------------------------------------------

* `/vgr-english`
    * `/47`
        * `/content`
        * ...
        * `/import_idml`
    * ...
    * `/65`
        * ...

Directory layout grouped by year only
-------------------------------------

* `/vgr-english`
    * `/47`
        * `ENG47-0101.at`
        * `ENG47-0101.docx.at`
        * `ENG47-0101.docx`
        * `ENG47-0101.folio.at`
        * `ENG47-0101.folio.deleted_text.json`
        * `ENG47-0101.folio.editors_notes.json`
        * `ENG47-0101.folio.warnings.json`
        * `ENG47-0101.folio.xml`
        * `ENG47-0101.idml.at`
        * `ENG47-0101.idml.warnings.json`
        * `ENG47-0101.idml`
        * `ENG47-0101.metadata.json`
    * ...
    * `/65`
        * ...

Directory layout flat list
--------------------------

* `/vgr-english`
    * `ENG47-0101.at`
    * `ENG47-0101.docx.at`
    * `ENG47-0101.docx`
    * `ENG47-0101.folio.at`
    * `ENG47-0101.folio.deleted_text.json`
    * `ENG47-0101.folio.editors_notes.json`
    * `ENG47-0101.folio.warnings.json`
    * `ENG47-0101.folio.xml`
    * `ENG47-0101.idml.at`
    * `ENG47-0101.idml.warnings.json`
    * `ENG47-0101.idml`
    * `ENG47-0101.metadata.json`
    * ...

