# Key Decisions and Future Work

- [Key Decisions and Future Work](#key-decisions-and-future-work)
  - [Key Decisions](#key-decisions)
    - [Not normalizing to PDF/A](#not-normalizing-to-pdfa)
    - [No rights metadata](#no-rights-metadata)
    - [Using CSV instead of XML for metadata imports](#using-csv-instead-of-xml-for-metadata-imports)
    - [Using Bagger to bag transfers](#using-bagger-to-bag-transfers)
      - [Why bag transfers?](#why-bag-transfers)
      - [Why use Bagger and not bagit.py?](#why-use-bagger-and-not-bagitpy)
  - [Future Work](#future-work)
    - [Clearing out Wasabi and re-organizing Google Drive](#clearing-out-wasabi-and-re-organizing-google-drive)
    - [Easier way of tracking normalization choices](#easier-way-of-tracking-normalization-choices)
    - [Born-digital](#born-digital)
    - [More file formats](#more-file-formats)
    - [Script for metadata](#script-for-metadata)
    - [Script for generating access links](#script-for-generating-access-links)
    - [Archivematica API](#archivematica-api)
    - [Archivematica-to-AtoM API vs full connection](#archivematica-to-atom-api-vs-full-connection)

## Key Decisions

### Not normalizing to PDF/A

Initally TMU normalized PDF files to PDF/A for preservation purposes. After implementing this for several transfers, this practice was abandoned and the relevant normalization rules disabled because:

1. Archivematica by default normalizes to PDF/A using [Ghostscript](https://www.ghostscript.com/), but checks for conformance to PDF and not PDF/A. Because PDF/A is a self-declared flag, checking for conformance is critical. Checking for conformance requires an external software such as [veraPDF](https://verapdf.org/) which adds additional steps to our workflow. (Scholars Portal has reached out to Artefactual regarding incorporating veraPDF into Archivematica, but as of writing in June 2024, this has not been implemented.)
2. [VeraPDF](https://verapdf.org/) can only check 1 PDF at a time if using the GUI which is extremely time-consuming. The only way to check batches of PDFs is through the command line which introduces a technological barrier in our procedures and processes.
3. Checking with VeraPDF is absolutely necessary as testing has discovered that out of 600 PDFs at least 1 will fail to conform to PDF/A if normalized by Archivematica.
4. Archivematica has trouble normalizing certain OCR'd PDFs into PDF/A due to the strict constraints of PDF/A. (See [Library of Congress' page on PDF/A for more info](https://www.loc.gov/preservation/digital/formats/fdd/fdd000318.shtml).) This means preservation copies of PDFs will not have OCR, but access copies for those PDFs will. This can be confusing to keep track of.
5. In 2023, the Digital Preservation Alliance re-adjusted their evaluation of PDF/A and merged it into the same category as other PDFs stating: "Due to the level of commercial, open-source tools that are available to assist preservation, the risk of loss is less persistent than previously suggested. Therefore a Vulnerable classification is appropriate for all PDF formats as whole ([source](https://www.dpconline.org/digipres/champion-digital-preservation/bit-list/vulnerable/bitlist-pdf))." Library and Archives Canada lists PDF/A as a preferred format, but PDF is an acceptable format ([source](https://library-archives.canada.ca/eng/services/government-canada/information-disposition/managing-government-records/guidelines-information-management/Pages/guidelines-file-formats-enduring-value.aspx)).

Taking all the above into account, TMU made the decision to not normalize to PDF/A. If any of the above changes, TMU will revisit that decision.

Documentation created from when TMU still normalized to PDF/A and has been saved in [Retired Documentation](/docs/retired-docs.md#pdfa-normalization) for reference purposes.

### No rights metadata

TMU does not currently include any rights metadata in its AIPS for the following reasons:

1. TMU has a variety of materials with various levels of rights / access that are all constantly in flux. What is ingested into the AIP might end up being incorrect in the very near future and would need to be updated (which is a hassle).
2. In some cases, the rights status of the materials is unknown and it would take a tremendous amount of work to figure this out while dealing with the current backlog.
3. In cases where we do know the exact rights metadata, that's already captured in AtoM (and can be updated more easily in AtoM than Archivematica) so that's a better source of truth than the AIP

TMU might consider including rights metadata in the future, but right now there is no clear advantage to doing so and would only add extra steps in the workflow.

### Using CSV instead of XML for metadata imports

A lot of the key RAD metadata has already been crosswalked to DC in TMU's AtoM instance. However, TMU ultimately decided not to upload metadata via the XML option because:

1. Not all of the metadata has been crosswalked and the supplementary metadata (eg. mods.dateCaptured) would have to be added manually. This is problematic as not all of the team is comfortable reading XML.
2. Furthermore, AtoM's DC crosswalk is not as specific as TMU would like. The fonds number and reference number are both crosswalked as dc.identifier but TMU is using dcterms.isPartOf for the fonds number as that better reflects the nature of the metadata.
3. Accessing the DC XML is cumbersome if downloading from the AtoM web interface as it requires you to open each page for each series, file, item, etc. in order to download the XML
4. The only way to download XMLs en masse is via the AtoM CLI, which not everyone on the team is comfortable using.
5. Even if team members are comfortable with the CLI, ASC only has access to a copy of the AtoM server via CLI and must ask TMU Lib IT in order to sync it (this is not practical or time-efficient in the long-run)
6. Furthermore, the cloned server does not have all the DC XML pre-loaded and loading all the XML files at once might crash the server (this has not been tested yet but based on how sensitive the main AtoM server is, this is very likely)
7. Finally, for metadata imported via CSV and JSON, Archivematica will label "DC" as such and all other metadata would be identified as "OTHER/CUSTOM". With the XML metadata option, the value in MDTYPE is always "OTHER", even if you're importing DC XML. 

### Using Bagger to bag transfers

#### Why bag transfers?

- multiple team members are processing materials at the same time so...
  - bagging is a shared final step in the workflow that lets other team members know that the transfer is ready for ingest
  - bagging acts as a safeguard against team members accidentally altering their ready-for-ingest transfers or other team members' transfers
    - Archivematica will fail the transfer if the bag is invalid or incomplete

#### Why use Bagger and not bagit<nolink>.py?

[bagit.py](https://github.com/LibraryOfCongress/bagit-python) is a Python library and command line utility for working with BagIt style packages.

[Bagger](https://github.com/LibraryOfCongress/bagger) is built on bagit<nolink>.py but has a graphical user interface. It also makes it easier to create customized bag-info.txt through templates called "profiles" with set fields that the user fills in.

- bagit<nolink>.py requires users to be comfortable with the command line and requires Library IT to install [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install) on library Windows computers
- multiple team members are processing materials at the same time so having that additional processing info available in the bag-info.txt file (eg. who bagged the transfer) is useful supplementary metadata
- Bagger is built on bagit<nolink>.py with a very light GUI so there is no difference in terms of bag creation speed
- the main benefit of using bagit<nolink>.py in terms of speed would be bypassing all the bag-info.txt data and simply generating checksums and file listings, however as previously stated the bag-info.txt does matter to TMU's workflows so it cannot be excluded

## Future Work

### Clearing out Wasabi and re-organizing Google Drive

After the backlog of materials in Wasabi has been processed and put through Permafrost as AIPs...

1. The Google Drive can be reorganized and processed materials can be deleted
   - Ideally no future materials will be stored in gdrive in the long-term as gdrive is terrible for preserving metadata when downloading files from the interface and access to the Google API has been disabled by TMU Central IT
2. All the relevant A&SC files in Wasabi should be deleted as Wasabi is a temporary cloud storage solution that does not meet preservation standards.
   - Deletion can be done through the CyberDuck interface, but if the goal is to purge everything then it would likely be easier / faster to get MJ to delete everything in the asc bucket using rclone

### Easier way of tracking normalization choices

Currently normalization choices are being tracked via:

1. [TMU-NormalizationRules.xlsx][REDACTED]: official spreadsheet of all the rules which have been en/disabled for TMU's Archivematica instance
2. [Processing in Archivematica: Normalization options](/docs/workflow-archivematica.md#normalization-options): informal more general list of the various file formats which have been encountered and tested thus far

Problems with this:

1. The spreadsheet is so large that it can be confusing to look at
2. The spreadsheet also needs to be regularly updated manually as there is no automatic way for TMU to extract the rule info (the original xlsx was provided by Permafrost upon TMU's request)
3. The informal list is so informal that it doesn't capture all the nauces of the choices (eg. PDFs are _not_ considered preservation formats but we are nonetheless not normalizing them) but acts as a quick guide that is easier to update

Currently, no nice in-between, easy to update solution exists. [The CCA uses a Word Doc with a table](https://github.com/CCA-Public/digital-archives-manual/blob/master/guides/CCA%20Format%20Policy%20Registry%20v2%20201804.pdf). It might be worth replicating their format in the future as a new Google sheet (NOT a word doc as that is both not AODA-compliant and still difficult to update).

### Born-digital

TMU has not processed any born-digital donations as of yet since we are prioritizing our current backlog of largely digitized materials. Occasionally, some born-digital materials have been processed from the backlog, but no appraisal, virus-checking, arrangement, etc. typical of born-digital donations work has been undertaken. After the backlog has been processed, this will be TMU's next hurdle as this would require new and unique workflows. 

### More file formats

Because TMU has not finished processing our backlog, there are still many file formats left that we have not encountered and future normalization desicions must be made for these as they get processed.

### Script for metadata

Currently, creating the metadata.csv file takes a lot of time as it is a lot of manual copy-pasting and checking. Ideally, there would be a script in the future to convert the relevant parts of the RAD csv from AtoM into the proper metadata.csv format. However, the RAD csv might not always be up to date and processing the transfer is also a good opportunity to update the AtoM record. An autonatic script might not catch that and might in fact accidentally include out-of-date metadata.

### Script for generating access links

Currently, the process for generating access links for the TMU access links spreadsheet can be tedious because it can include a lot of copy-pasting from the AtoM RAD csv / complicated spreadsheet formulas. In theory, a script could be made to automatically run those formulas, though the copy-pasting would be harder to script for the same reasons that writing a script for the metadata might be problematic.

### Archivematica API

UofA has used this API to ingest thousands of small transfers from a large collection thus bypassing the slowness of the Archivematica graphic user interface and turning a 6 month project to a 2 month project. TMU has opted not to do this as we don't currently have any materials that would apply to this use case, but if anything similar comes up it would be worth looking into.

### Archivematica-to-AtoM API vs full connection

A full connection would not benefit TMU as the main benefit of that is to export the access copies directly into the AtoM server. Our server is already small and costly, so we should continue to push access copies to the OLRC.

However, the API connection might be useful for future born-digital donations as that pushes the technical metadata of items straight to AtoM the main benefit of this is that donors can then see that their donation has been processed. This just requires TMU Library IT to conncect via an API key. Worth looking into once born-digital donations come along.
