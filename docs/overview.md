# Getting Starte

[Click here to go back to the main Table of Contents](/README.md)

- [Getting Started](#getting-started)
  - [What is Digital Preservation?](#what-is-digital-preservation)
  - [What is Permafrost?](#what-is-permafrost)
    - [Permafrost Terminology](#permafrost-terminology)
  - [OAIS - SIPs, AIPs, DIPs](#oais---sips-aips-dips)
    - [Archivematica Terminology](#archivematica-terminology)
  - [How does TMU conduct digital preservation?](#how-does-tmu-conduct-digital-preservation)
  - [Useful Permafrost Documentation](#useful-permafrost-documentation)
  - [Documentation from other Permafrost members](#documentation-from-other-permafrost-members)

This page includes:

- some foundational knowledge about digital preservation required for using Permafrost
- additional context for understanding official Permafrost documentation
- overview of TMU's Digital Preservation Program
- list of revelant / useful Permafrost documentation

## What is Digital Preservation?

"Digital Preservation refers to the series of managed activities necessary to ensure continued access to digital materials for as long as necessary." (from the [Digital Preservation Coalition](https://www.dpconline.org/digipres/what-is-digipres))

These actvities are technology-agnostic. It doesn't matter what software is used in these activities as long as it contributes to the ultimate goal of ensuring long-term access to digital materials. [How does TMU conduct digital preservation?](#how-does-tmu-conduct-digital-preservation) outlines TMU's current tools and protocols, but these are subject to change as new tools get released and best practices shift.

## What is Permafrost?

Scholars Portal Page for Permafrost: https://permafrost.scholarsportal.info/

Permafrost isn't a specific software or application. It's a package of different software and services provided by Scholars Portal as a subscription-based system with a base annual fee and additional charges for additional storage (by terabytes).

![](/img/permafrost-ecosystem.png)

Clicking on the above diagram will take you to the image file where you can then download it and zoom in. You can edit this diagram in the Google Drive here: [REDACTED]

**Note:** Though DuraCloud is part of Permafrost, TMU does not actively use it in our workflows

For more info about the differences outlined in the diagram, see the Scholars Portal page on Preservation Service Comparison: https://learn.scholarsportal.info/all-guides/cloud/service-comparison/

### Permafrost Terminology

Permafrost = digital preservation service provided by Scholars Portal that includes Archivematica and technical support for it

Archivematica = open source software which processes files into packages that conform to [OAIS](#oais---sips-aips-dips) (_not_ storage for packages)

OLRC = cloud storage used by Permafrost and paid for by TMU as a separate subscription (this is where packages are stored)

Horizon = access point for the OLRC, manages data as projects > containers > files

Permafrost project = specific project in Horizon set up by Scholars Portal for the Permafrost service

transfersource = name of specific container in Horizon (in the Permafrost project) which is connected to Archivematica

Globus = temporary storage service for tranferring files, also connected to Archivematica, _not_ connected to the OLRC

## OAIS - SIPs, AIPs, DIPs

The Reference Model for an Open Archival Information System (OAIS) is an ISO standard high-level conceptual model for creating and maintaining a digital repository / archive over a long period of time. The driving principle behind OAIS is that information objects (the material being archived) needs to remain "independently understandable" to your "designated community." In other words, whoever looks at these materials in the future should be able to use these materials without assistance from the original creators or the original archivists.

OAIS facilitates this using packages:

- SIP (Submission Information Package): the package submitted by the creator to the archive
- AIP (Archival Information Package): the package of digital object(s) and metadata that is meant for long-term storage
- DIP (Dissemination Information Package): derived from the AIP, the package that archives give to in response to a request, can contain things like access copies

These are really the key concepts you need to know for Permafrost purposes. To learn more about OAIS, see this article by the Canadian Heritage Information Network (CHIN): https://www.canada.ca/en/heritage-information-network/services/digital-preservation/open-archival-information-systems.html

### Archivematica Terminology

OAIS is a high-level model and the specific way Archivematica applies OAIS can be confusing. This is a review of the terminology used by Archivematica and Permafrost documentation.

transfer = the package / directory of files you want to ingest / are ingesting via Archivematica

SIP = the package that appears in the **Ingest** tab in Archivematica

AIP = the package you can search for in the **Archival storage** tab in Archivematica

DIP = the package that gets sent to either the **access** container or the **dip** container in Horizon depending on which option you choose, from the **access** container you can grant access to specific files

## How does TMU conduct digital preservation?

|Example of a Digital Preservation Activity|How TMU Carries Out That Activity|
|---|---|
|Developing policy and process to guide the acquisition, preservation and provision of access to digital content| This guide and other TMU documentation are outputs of this activity. These outputs are created using a mix of Google Suite and Github tools.|
|Maintaining multiple copies of digital content to provide insurance against loss|The [OLRC](https://cloud.scholarsportal.info/) stores 3 copies of each file across 5 geographically distributed data centres (York University, University of Guelph, Queen’s University, University of Ottawa, and University of Toronto). TMU is also considering secondary storage through Permafrost's tape library pilot program.|
|Frequently checking the integrity of digital content to ensure it has not decayed or become damaged| OLRC:<ul><li>Overall health: dispersion reports run cluster health checks that confirm the fixity of a distributed sample of containers and objects in a storage node</li><li>Individual objects: auditors run constantly in the background and if an object is found to be corrupted, it will be automatically quarantined and replication of an uncorrupted copy will be scheduled to replace it</li></ul>DuraCloud <ul><li>Health checks occur on a monthly basis and run on 1000 objects per space per day</li><li>If there are 1000s objects in a space, a health check may take longer than a month to complete, the next health check for the account will not run until the previous check is completed|
|Examining digital content to understand it's characteristics, assessing it for preservation risks and taking action to mitigate those risks| Working with Permafrost's Digital Preservation Librarian, TMU analyzes each new file format it encounters and documents the various normalizations choices made in Archivematica (eg. which normalization rules have been reviewed / disabled).|

This is not a comprehensive table and practices will change as TMU's Digital Preservation Program develops further.

## Useful Permafrost Documentation

[TMU's SPOTDocs Page](https://docs.scholarsportal.info/view/Main/SP/PER/Participant_Pages/TMU/?srid=f5jtnOQr#HDocumentation)

- main page for our Permafrost instance, includes stats, logins, links to training materials, and changes to normalization rules
- requires SPOTDocs login to access

["Documentation" SPOTDocs Page](https://docs.scholarsportal.info/view/Main/SP/PER/Documentation/)

- list of links for all the Permafrost documentation available on SPOTDocs
- requires SPOTDocs login to access

[Handling Digital Archives Before Ingest](https://learn.scholarsportal.info/all-guides/handling-digital-archives/)

- introduction to processing born-digital donations before ingest into Permafrost (written by Scholars Portal)
- good overview of key concepts, but not immediately relevant for dealing with TMU's Wasabi backlog
- publicly accessible

[A Guide to User-Submitted Metadata in Archivematica](https://learn.scholarsportal.info/all-guides/a-guide-to-user-submitted-metadata-in-archivematica/)

- overview of all the metadata options available in Archivematica
- useful as review and reference for if we ever decide to change our metadata workflow, but currently TMU uses the CSV import option for metadata uploads and does not have any immediate plans to change that
- publicly accessible

[Ontario Library Research Cloud Guide](https://learn.scholarsportal.info/all-guides/cloud/)

- explains what the OLRC is and how it functions along with all its associated tools
- important context because Permafrost uses the OLRC, but not a necessary read unless you're working with OLRC projects other than Permafrost
- publicly accessible

## Documentation from other Permafrost members

[2022: Workflow documentation from Emily Sommers (Digital Records Archivist, UTARMS)](https://permafrost.groups.io/g/main/message/84)

- features PDF documentation for small size accessions (<50 GB) on a Dell desktop computer running Ubuntu with BitCurator tools installed
- includes python script for generating SIP structure and blank CSV, not immediately useful for TMU Wasabi backlog and would require tweaking to meet TMU's needs
- requires groups.io / Permafrost Forum login to access

[2024: Bagger and Exiftool use from Jeremy Heil (Digital and Private Records Archivist, Queen's University)](https://permafrost.groups.io/g/main/files)

- Bagger instructions and Exiftool use instructions
- TMU Bagger profile is an edited version of Queen's Bagger profile (fewer fields and new fields)
- convert.py converts output from Exiftool into CSV format that can be used in Archivematica CSV import, not immediately useful for TMU metadata workflows because
  - Exiftool extracts technical metadata but TMU's metadata CSVs feature largely descriptive metadata
  - Archivematica also runs Exiftool on the transfer and extracts technical metadata as one of its jobs so that metadata is still being captured in the METS XML
  - TMU does not currently have our AtoM and Archivematica instances connected so the technical metadata does not appear in AtoM and thus does not need to be cleaned with a script to be more human-readable
- requires groups.io / Permafrost Forum login to access
