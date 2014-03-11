Repositext file system layout
=============================

This document specifies the conventions for a repositext repository's file system
layout.

File types
----------

To help with automating processes (e.g., validation policies), we choose expressive file names:

1. Language and time code, and possibly a product ID <LTC>(e.g., 'ENG65-0134' or 'ENG47-0101_0005')
2. Import source <optional>(e.g., docx, folio_xml, idml)
3. Document type <optional>(e.g., deleted_text, notes, warnings)
4. File extension (e.g., at, md, json, txt, idml, xml)

Here is a list of possible file names:

### Master files

* `<LTC>.at` master kramdown AT document
* `<LTC>.metadata.json` master metadata file
* `<LTC>.notes.at` final notes as AT kramdown file

### Docx related

* `<LTC>.docx` docx import source file
* `<LTC>.docx.at` AT kramdown file imported from docx

### Folio related

* `<LTC>.folio.at` AT kramdown file imported from folio.xml
* `<LTC>.folio.deleted_text.json` text that was deleted while importing folio.xml
* `<LTC>.folio.notes.json` notes that were extracted while importing folio.xml
* `<LTC>.folio.warnings.json` warnings that were raised while importing folio.xml
* `<LTC>.folio.xml` folio.xml import source file

### Idml related

* `<LTC>.idml` idml import source file
* `<LTC>.idml.at` AT kramdown file imported from idml
* `<LTC>.idml.warnings.json` warnings that were raised while importing idml

Directory layout grouped by workflow then year
----------------------------------------------

We group first by workflow, then by year. The advantage of this approach is that it groups all files that would likely be touched by a script in a single folder. It also maps nicely to the mindset/concept of the person working on the files.

* `/vgr-english`
    * `/master` (this is where master files are located)
        * `/47`
            * `ENG47-0101.at`
            * `ENG47-0101.notes.at`
            * `ENG47-0101.metadata.json`
        * ...
    * `/export_icml` (do we need folders for export files in repo?)
        * `/47`
            * `ENG47-0101.icml`
            * `ENG47-0101.icml.warnings.json`
        * ...
    * `/import_docx` (all files related to importing from docx)
        * `/47`
            * `ENG47-0101.docx`
            * `ENG47-0101.docx.at`
        * ...
    * `/import_folio` (all files related to importing from folio xml)
        * `/47`
            * `ENG47-0101.folio.at`
            * `ENG47-0101.folio.deleted_text.json`
            * `ENG47-0101.folio.notes.json`
            * `ENG47-0101.folio.warnings.json`
            * `ENG47-0101.folio.xml`
        * ...
    * `/import_idml` (all files related to importing from idml)
        * `/47`
            * `ENG47-0101.idml.at`
            * `ENG47-0101.idml.warnings.json`
            * `ENG47-0101.idml`
        * ...
    * `readme.md` Instructions for the repo
    * `Rtfile` CLI configuration file
