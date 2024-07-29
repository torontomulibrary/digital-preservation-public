# BitCurator for Born-Digital Donations

- [BitCurator for Born-Digital Donations](#bitcurator-for-born-digital-donations)
- [What is BitCurator?](#what-is-bitcurator)
- [TMU BitCurator station](#tmu-bitcurator-station)
- [Future tools to explore](#future-tools-to-explore)
  - [Write blockers and readers](#write-blockers-and-readers)
  - [Disk imaging](#disk-imaging)
    - [Why and when to disk image?](#why-and-when-to-disk-image)
    - [](#)
  - [FTK](#ftk)
    - [Guymager](#guymager)
  - [Treesize](#treesize)
- [Sal Greco Case study](#sal-greco-case-study)


# What is BitCurator?


# TMU BitCurator station

current setup
consider just tools in future
password
clamav connection to the network


# Future tools to explore

There are other tools for born-digital archival materials that have not been tested yet but are worth exploring in the future:

## Write blockers and readers



## Disk imaging

Thus far, everything we've processed has been acquired through _logical transfer_, meaning we have copied the files from the original storage media onto another storage location. In contrast, a disk image creates a bit-for-bit copy of the data on the original storage media including deleted and hidden files.

### Why and when to disk image?

1. In some cases a disk image can allow you to recover corrupted files if the data hasn't been overwritten yet. In digital forensics, this is called data carving (see [this blog post](https://www.apriorit.com/dev-blog/694-windows-how-to-recover-files-with-data-carving) by the cybersecurity company apriorit for more details).
2. If the storage medium is fragile or extremely vulenerable, a disk image is a good way to quickly get that data off that media. For example, if you have a degrading tape that you know can only be read a couple more times.
3. If you want to emulate whatever is on the storage medium later. For example:
   - The interactive menus in a DVD
   - A video game
   - Some kind of legacy software
4. If the operating system of the storage medium / donation is different from the system that you're using to process the materials
   - this is largely only a problem if you're using Windows and working to process materials from a Mac or Linux system
5. If you simply have no idea what's in the donation and don't want to risk losing anything

A disk image is only useful if you are _certain_ that the storage medium is the _original_ storage medium and not just a temporary carrier used for file transfer. Examples include:

- the internal hard drive of the donor's computer
- the CD-ROM that the media was burned onto
- the SD card of the donor's camera
- the external hard drive / floppy disk that the donor was working on for a specific project
- etc.

If it's a temporary transfer source (eg. an archives hard drive we lent the donor) getting a disk image would only give us irrelevant files (eg. files that _we_ have deleted / corrupted).

The disk image vs logical file transfer debate is a hot topic in digital preservation. Best practices usually start with a disk image and then that data gets appraised and pared down. However, disk images are huge (about the same size as the drive they are created from) and it's hard to justify taking up that much space if you know that a donation is largely material you won't be keeping. Furthermore, beyond reasons 1-5, there's disk imaging doesn't provide anything extra that a logical file transfer couldn't do, and a logical file transfer is often easier to appraise. However, a disk image _does_ guarantee that you will get _everything_ on that disk no matter what (even if you might have to work harder to appraise it later) so some insitutions simply create a disk image of every donation, don't process it (beyond bagging / generating a checksum), and then send it to backlog. This is particularly appealing for degrading storage mediums but can quickly generate a huge backlog.

###



## FTK

https://www.exterro.com/digital-forensics-software/forensic-toolkit

https://www.exterro.com/digital-forensics-software/ftk-imager

Originally j

### Guymager

## Treesize

https://www.jam-software.com/treesize

# Sal Greco Case study

See notes file here [sal-greco-notes.md](/docs/sal-greco-notes.md)
