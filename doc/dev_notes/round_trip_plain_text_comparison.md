Round trip testing
==================

The purpose of round-trip testing is to confirm that we didn't change any of the
text contents from the IDML and Folio import sources.

We compare the following two versions of plain text:

* Plain text generated through the repositext pipeline.
* Plain text generated directly from sources (IDML and Folio).

There should be no difference between the two.

We will create rt commands (that live in vgr-scripts) that will run all
comparison tasks:

IDML
====

* generate idml_direct_plain_text
    * iterate over files in vgr-english/initial_idml_import/manual_basefile_txt
    * ..
* generate idml_repositext_plain_text
    * convert all AT files in vgr-english/initial_idml_import/idml/**/*.idml.at to
      plain text
* compare idml_direct_plain_text with idml_repositext_plain_text
    * iterate over each file pair, print out differences to log file

These are the authoritative sources to compare

initial_folio_import
    * manual_records_txt (plan A)
    * manual_without_records_txt (plan B if A generates too much noise)
initial_idml_import
    * manual_basefile_txt


Look at vgr-scripts/bin/compare_... to see how it works
There is also a script in lib


This is how it currently works
==============================

Commands
--------

* `bin`
    * `compare_folio_prepare` - Takes txt files in `initial_folio_import/manual_records_txt`,
      filters them, and writes the updated txt to `initial_folio_import/compare_records/expected`
    * `compare_idml_create` - Takes IDML imported AT files, converts them to plain text and
      saves them to `initial_idml_import/roundtrip_plain`.
    * `compare_idml_prepare` - Takes txt files, filters them and writes them to new location:
        * roundtrip_plain     --> partial_filter(content).gsub("&#x2011;","\u{2011}").gsub("&#x00A0;", "\u{00A0}") --> compare_roundtrip_plain/produced
        * manual_basefile_txt --> partial_filter(content)  --> compare_roundtrip_plain/expected
        * manual_basefile_txt --> base_filter(content)     --> compare_basefile_normalization/produced
        * manual_original_txt --> original_filter(content) --> compare_basefile_normalization/expected
        * manual_icml_txt     --> partial_filter(content)  --> compare_roundtrip_icml_txt/produced
        * manual_basefile_txt --> partial_filter(content)  --> compare_roundtrip_icml_txt/expected
* `lib/vgr/commands/compare.rb`
    * `compare folio_create` - Takes Folio imported AT files, converts them to
      plain text (with and without records) and saves them to
      `initial_folio_import/compare_text/produced` and
      `initial_folio_import/compare_records/produced`.

Directories
-----------

* `vgr-english`
    * `initial_folio_import` - Workspace for importing Folio.
        * `compare_records` - Workspace for comparing documents _with_ records.
            * `expected` - Plain text generated directly from Folio source, prepared for comparison.
            * `produced` - Plain text generated from Folio imported AT via repositext.
        * `compare_text` - Workspace for comparing documents _without_ records.
            * `expected` - Filtered text, generated directly from Folio source.
            * `produced` - Plain text, generated from Folio imported AT via repositext.
        * `folio` - Folio source files and Folio imported AT
        * `manual_records_txt` - Plain text with records, generated directly from Folio
        * `manual_without_records_txt` - Plain text without records, generated directly from Folio
    * `initial_idml_import` - Workspace for importing IDML
        * `compare_basefile_normalization` - ?
            * `expected` - Files from manual_original_txt, run through original_filter
            * `produced` - Files from manual_basefile_txt, run through base_filter
        * `compare_roundtrip_icml_txt` - ?
            * `expected` - Files from manual_basefile_txt, run through partial_filter
            * `produced` - Files from manual_icml_txt, run through partial_filter
        * `compare_roundtrip_plain` - Workspace for comparing IDML source with repositext pipeline
            * `expected` - Files from manual_basefile_txt, run through partial_filter.
              Plain text from IDML source, prepared for comparison
            * `produced` - Files from roundtrip_plain, run through partial_filter
              Plain text from repositext pipeline, prepared for comparison, run through partial_filter
        * `idml` - IDML source files and IDML imported AT
        * `manual_basefile_txt` - Raw plain text generated directly from IDML source (after running normalization scripts in IDML)
        * `manual_icml_txt` - Raw plain text generated from (IDML -> kramdown AT -> ICML -> plain text)
        * `manual_original_txt` - Raw plain text generated directly from IDML source (before running normalization scripts in IDML)
        * `roundtrip_icml` - ICML files that were exported from IDML imported AT via repositext
        * `roundtrip_plain` - Raw plain text from IDML imported AT via repositext pipeline

New setup
=========

Commands
--------

* `bundle exec rt compare prepare_folio_source`
* `bundle exec rt compare prepare_folio_repositext_kramdown`
* `bundle exec rt compare diff_folio`
* `bundle exec rt compare folio`
* `bundle exec rt compare prepare_idml_source`
* `bundle exec rt compare prepare_idml_basefile`
* `bundle exec rt compare prepare_idml_repositext_kramdown`
* `bundle exec rt compare prepare_idml_repositext_icml`
* `bundle exec rt compare diff_idml_source_to_basefile`
* `bundle exec rt compare diff_idml_basefile_to_repositext_kramdown`
* `bundle exec rt compare diff_idml_repositext_kramdown_to_repositext_icml`
* `bundle exec rt compare idml`

Directories
-----------

* `vgr-english`
    * `initial_folio_import`
        * `compare`
            * `source` - Text extracted directly from Folio sources.
                * `raw`
                * `compare_with_repositext_kramdown`
            * `repositext_kramdown` - Text extracted from repositext Folio imported kramdown AT.
                * `compare_with_source`
            `diff_source_to_repositext_kramdown.txt`
        * `folio` - Folio sources and imported kramdown AT.
    * `initial_idml_import`
        * `compare`
            * `source` - Text extracted directly from IDML sources (before running normalization javascripts in InDesign).
                * `raw`
                * `compare_with_basefile`
            * `basefile` - Text extracted directly from IDML sources (after running normalization javascripts in InDesign).
                * `raw`
                * `compare_with_source`
                * `compare_with_repositext_kramdown`
            * `repositext_kramdown` - Text extracted from repositext IDML imported kramdown AT.
                * `compare_with_basefile`
                * `compare_with_repositext_icml`
            * `repositext_icml` - Text extracted from repositext ICML exports.
                * `compare_with_repositext_kramdown`
            `diff_source_to_basefile.txt` - Report with diffs between repositext and source.
            `diff_basefile_to_repositext_krandown.txt` - Report with diffs between repositext and source.
            `diff_repositext_kramdown_to_repositext_icml.txt` - Report with diffs between repositext and source.
        * `idml` -  IDML sources and imported kramdown AT.
    * `content`
        * `compare`
            * `source_records` - Record ids extracted from Folio source.
                * `raw`
                * `compare`
            * `repositext_kramdown_records` - Record ids extracted from repositext Folio imported kramdown AT.
                * `raw`
                * `compare`
            `diff_source_records_to_repositext_kramdown_records.txt`
