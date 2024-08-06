# Creating Access Links

[Click here to go back to the main Table of Contents](/README.md)

- [Creating Access Links](#creating-access-links)
  - [What is an access link?](#what-is-an-access-link)
  - [How does this work? (technical information and limitations)](#how-does-this-work-technical-information-and-limitations)
  - [Where are access links stored?](#where-are-access-links-stored)
  - [How do I create new access links?](#how-do-i-create-new-access-links)
    - [Official Permafrost documentation](#official-permafrost-documentation)
      - [Limits of the Permafrost documentation](#limits-of-the-permafrost-documentation)
    - [Using the Swift client and CLI](#using-the-swift-client-and-cli)
    - [Using Horizon’s pagination feature](#using-horizons-pagination-feature)
  - [Adding access links to TMU spreadsheet](#adding-access-links-to-tmu-spreadsheet)
- [Navigation](#navigation)

## What is an access link?

Access links are public links to access copies that you can give to patrons in lieu of email attachments or hard drive transfers. They can view the file in their browser or download it to their computer.

Access links are created by attaching the name of the object in the **access** container in Horizon to TMU's static Permafrost URL. For example:

- TMU static Permafrost URL = [REDACTED]

- Name of object in the **access** container = [REDACTED]

- Public access link = [REDACTED]

More examples:

|Description|Link|
|---|---|
|PDF for [RG 4.10.01.01](https://archives.library.torontomu.ca/index.php/fey2-y4w3-aetm): "Forum newsletter: Vol. 1 No. 1 September 12, 1975"|[REDACTED]|
|JPEG for [F 536.20.05.12](https://archives.library.torontomu.ca/index.php/crane-removing-roof-brace-section): "Crane removing roof brace section"|[REDACTED]|
|MP3 from [RG 456.05.06](https://archives.library.torontomu.ca/index.php/women-a-united-nations-radio-show-audiocassettes): "Women - a United Nations Radio Show audiocassettes"|[REDACTED]|

## How does this work? (technical information and limitations)

The end-products of processing in Permafrost are AIPs (Archival Information Packages) and DIPs (Dissemination Information Packages). The AIP has preservation copies of the materials for long-term storage and the DIP has access copies for sharing with patrons. Both AIPs and DIPs are stored in the [Ontario Library Research Cloud](https://cloud.scholarsportal.info/) (OLRC), but the DIPs have been made public by [Scholars Portal](https://scholarsportal.info/) and can be accessed via the [Horizon](https://olrc2.scholarsportal.info/horizon/auth/login/) interface.

Essentially, each access link is a link to a file in the OLRC that we have stored. The OLRC uses non-heirachical storage, meaning there are no folders. In Horizon things will be presented to you as folders, but this is for your benefit to make navigation easier and does not reflect how files are actually stored. **There is no way to create an access link to a folder because there are no folders, it's all just files. Therefore, if you want to share multiple files with a patron, you will have to share multiple access links.**

## Where are access links stored?

Currently all access links are being kept in [this Google spreadsheet][REDACTED]. Search the sheet by reference number to find the link you're looking for. If the item isn't there but you know it has been processed, then you will need to make [a new access link](#how-do-i-create-new-access-links).

## How do I create new access links?

### Official Permafrost documentation

Permafrost documentation for creating access links uses Horizon [5. Accessing DIPs](https://docs.scholarsportal.info/view/Main/SP/PER/Documentation/Permafrost_Processing_Workflow/5._Accessing_DIPs/). Give this a read before continuing on.

#### Limits of the Permafrost documentation

Permafrost documentation only applies to the first 10,000 files TMU processes. This is because the API call used by Horizon only returns the first 10,000 objects in a container to avoid overloading. Once our access container reaches over 10,000 files, new files will not show up by default and you will need to [use Horizon's pagination feature](#using-horizons-pagination-feature).

[Using the swift client and CLI](#using-the-swift-client-and-cli) will give you everything in the access container and is thus the preferred method, but [Using Horizon’s pagination feature](#using-horizons-pagination-feature) is a viable (but slower) option if you want to avoid using command line.

### Using the Swift client and CLI

First see [Technical Setup: Connecting to Openstack](/docs/technical-setup.md#connecting-to-openstack)

`swift list access` will give you a list of everything in the access container

`swift list access > access.csv` will export that list into a csv file called `access.csv`

Follow Permafrost documentation to [Generate links for many items](https://docs.scholarsportal.info/view/Main/SP/PER/Documentation/Permafrost_Processing_Workflow/5._Accessing_DIPs/#HB.Generatelinksformanyitems) and TMU documentation on [adding to the access links spreadsheet](#adding-access-links-to-tmu-spreadsheet).

### Using Horizon’s pagination feature

Follow Permafrost documentation [5. Accessing DIPs](https://docs.scholarsportal.info/view/Main/SP/PER/Documentation/Permafrost_Processing_Workflow/5._Accessing_DIPs/) for the first 10,000 items in the access container. For all the items after that, do the following:

1. Go to Horizon and click on the **access** container
2. Click **Link** next to **Public Access** to open a new page. The URL for this page will follow the structure of `https://olrc2.scholarsportal.info/v1/[project-identifier]/access`
3. For each successive batch of 10,000 objects, you will need to adjust the query by adding a marker parameter, `?marker=[value]`, to the end of the URL. The value for this parameter corresponds to the name of the last object returned in the previous query.
4. For example, if the `<name>` field for the last object in the previous query reads “testing.csv”, the new request URL would be `https://olrc2.scholarsportal.info/v1/[project-identifier]/access/?marker=testing.csv`
5. This new query will return a listing of objects in the next batch of 10,000. Follow [5. Accessing DIPs](https://docs.scholarsportal.info/view/Main/SP/PER/Documentation/Permafrost_Processing_Workflow/5._Accessing_DIPs/) to generate new links for this new batch.

## Adding access links to TMU spreadsheet

1. Make a new sheet in the [A&SC Google spreadsheet][REDACTED]
2. Choose one of the [access link creation methods](#how-do-i-create-new-access-links) and add access links to that new sheet
3. Delete all the links you don't need / are already in the [A&SC Google spreadsheet][REDACTED]
   - **Note:** Keep the METS XML metadata file
4. Include the reference number in the spreadsheet with the URLs to facilitate retrieval.
   - For digitized materials, the file name is its reference number which is the last few digits of the URL, so you can use the excel formula `=right(A2,25)` (e.g. if A2 has the URL, and the reference code is the last 25 digits). Then replace the underscores - to  periods . to get the AtoM reference code, and remove the file extension from the name (e.g. .jpeg).
   - For born-digital materials, the files are not named after the reference number and thus you cannot use the method above. You will have to do some manual copy-pasting.
5. Voila! You have your reference numbers and access links! Copy all of this data into the [access link spreadsheet][REDACTED]
6. Finally, include the URL to the xml metadata file in the spreadsheet.

# Navigation

Click here to go back to the main [Table of Contents](/README.md)

Click here to go back to [Preprocessing / Pre-Ingest Procedures](/docs/workflow-preprocessing.md)

Click here to go back to [Processing in Archivematica](/docs/workflow-archivematica.md)
