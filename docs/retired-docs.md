# Retired documentation

- [Retired documentation](#retired-documentation)
  - [PDF/A Normalization](#pdfa-normalization)
    - [Software](#software)
    - [PDF (access) to PDF/A (preservation)](#pdf-access-to-pdfa-preservation)
    - [PDF/A conformance (veraPDF)](#pdfa-conformance-verapdf)




## PDF/A Normalization

The following features retired documentation written for PDF/A normalization. Go to [Key Decisions: Not normalizing to PDF/A](/docs/future-work.md#not-normalizing-to-pdfa) to understand why this documentation was retired.

### Software

- [img2pdf](https://gitlab.mister-muffin.de/josch/img2pdf)
  - Only needed if you don't have Adobe Acrobat Pro (Jessica doesn't) or if you want to quickly turn images into PDFs
- [ocrmypdf](https://ocrmypdf.readthedocs.io/en/latest/index.html) & [parallel](https://ocrmypdf.readthedocs.io/en/latest/batch.html#batch-jobs)
  - Only needed if you want to OCR PDFs en masse for access copies, otherwise can just use Adobe Acrobat Pro to OCR one file at a time
- [veraPDF](https://verapdf.org/)
  - Only needed for PDF/A files
  - GUI only lets you check 1 PDF at a time, CLI lets you check multiple
  - Install https://docs.verapdf.org/install/
  - Setting up alias for command https://docs.verapdf.org/cli/terminal/

### PDF (access) to PDF/A (preservation)

Currently we are normalizing PDFs to PDF/A on a case-by-case basis. If normalizing to PDF/A, then the PDFs _should not_ have OCR or a complex colour profile. OCR'd PDFs messes with Archivematica's PDF/A normalization script and PDF/A has certain colour profile and text restrictions which could alter the look of coloured-image heavy PDF. Text-heavy, greyscale / black and white PDFs are safe to normalize to PDF/A for preservation. If you want your access copies to have OCR, you have to add that yourself using manual normalization.

### PDF/A conformance (veraPDF)

If you have PDF/A files in the AIP, you need to check for conformance using veraPDF as Archivematica only validates whether the file is valid as a PDF and not as a PDF/A using JHOVE.

1. cd into verapdf folder and check installation with `verapdf --version`
2. If command is not found then add verapdf to path using `alias verapdf='~/verapdf/verapdf'`
3. Move all the normalized files (files with an appended UUID) from the AIP into a separate folder called `normalized`
4. cd to 1 level above the directory you want to scan and use `verapdf normalized`
5. In `<validationReports>` tag it should say `noncompliant=”0”` if all the files conform to PDF/A, if it doesn't then that's the number of files that failed to conform
6. Manually normalize original to PDF/A using either Adobe or [ocrmypdf](#software), return to the [reorganize folder step](#2-reorganize-folder-to-meet-transfer-requirements)
