# Analyzing normalization rules for new file format

- [Analyzing normalization rules for new file format](#analyzing-normalization-rules-for-new-file-format)
- [Obtain the normalization report](#obtain-the-normalization-report)
- [WAV analysis](#wav-analysis)
  - [WAV preservation normalization rule](#wav-preservation-normalization-rule)
  - [WAV access normalization rule](#wav-access-normalization-rule)
  - [WAV normalization rules conclusion](#wav-normalization-rules-conclusion)
- [MP3 analysis](#mp3-analysis)
  - [MP3 preservation normalization rule](#mp3-preservation-normalization-rule)
  - [MP3 access normalization rule](#mp3-access-normalization-rule)
  - [MP3 normalization rules conclusion](#mp3-normalization-rules-conclusion)
  - [Setting MP3 as a preservation standard](#setting-mp3-as-a-preservation-standard)
- [Checking other WAV and MP3 rules](#checking-other-wav-and-mp3-rules)
- [Navigation](#navigation)

Archivematica comes with a default set of normalization rules that do not always make sense for our insitutional context and might take up unnecessary processing power or storage space, hence why it's important to analyze normalization rules when new formats appear.

You will be working with the Digital Preservation Libarian at Permafrost to make normalization decisions since only Permafrost can enable / disable rules (and they are a very knowledgable resource), but you still need to be able to decipher what rules do and know which rules are relevant for our files. To do this, you must partially process the transfer until you can access the normalization report and analyze the normalization rules.

Instructions below uses MP3 and WAV as examples for normalization rule analysis and walks through how Jessica evaluated these (at the time) untested file formats.

# Obtain the normalization report

1. Choose **Normalize for preservation and access** and wait until **Job: Approve normalization** appears
2. Access the normalization report by clicking on the report icon next to the gear icon (see Permafrost documentation for screenshot)

![Default normalization report for WAV and MP3 files](/img/norm-report-default.PNG)

- For Waveform Audio (PCMWAVEFORMAT) files, access normalization was attempted but preservation normalization was not
- For MPEG 1/2 Audio Layer 3 files, access _and_ preservation normalization was attempted

# WAV analysis

## WAV preservation normalization rule

1. Click on **No** under **Preservation normalization attempted** for one of the Waveform Audio (PCMWAVEFORMAT) files, this will open the preservation task that Archivematica ran on the file

![Task fcabcb5c-c0cc-48e4-8052-2cbaef9de5fe](/img/task-fcabcb5c-c0cc-48e4-8052-2cbaef9de5fe.PNG)

- The **Standard output (stdout)** explains that Archivematica:
  - Looked for a "manually normalized file" but did not find one
  - Identified the file as Waveform Audio (PCMWAVEFORMAT) which is [fmt/141](https://www.nationalarchives.gov.uk/pronom/fmt/141) from the [PRONOM](https://www.nationalarchives.gov.uk/PRONOM/Default.aspx) registry
    - Sometimes the file format name and category provided by Archivematica will match the name in PRONOM, but sometimes it will be a grouping of multiple formats like it is with [Acrobat PDF/A - Portable Document Format](https://archtorontomu.scholarsportal.info/fpr/format/acrobat-pdf-a/) which is actually multiple versions of PDF/A grouped together (and thus have multiple PRONOM IDs).
  - Did not normalize for preservation because there isn't a preservation for Waveform Audio (PCMWAVEFORMAT) files

**Now you know...**

- There is no preservation normalization rule for WAV files
- **This is in line with best practices as WAV files are considered to be a preservation format already.**

## WAV access normalization rule

1. Click on **Yes** under **Access normalization attempted** for one of the Waveform Audio (PCMWAVEFORMAT) files, this will open the access task that Archivematica ran on the file

![Task 2dab0b27-5ae6-4fa3-8e2d-cbe92a4a6a24](/img/task-2dab0b27-5ae6-4fa3-8e2d-cbe92a4a6a24.PNG)

- The **Standard output (stdout)** explains that Archivematica:
  - Looked for a "manually normalized file" but did not find one
  - Identified the file as Waveform Audio (PCMWAVEFORMAT) which is [fmt/141](https://www.nationalarchives.gov.uk/pronom/fmt/141) from the [PRONOM](https://www.nationalarchives.gov.uk/PRONOM/Default.aspx) registry
  - Normalization rule for this file format is 45b486af-48f7-46cb-98b6-5e09750e1a30: Transcoding to mp3 with ffmpeg
  - [FFmpeg](https://ffmpeg.org/) is being used to implement this normalization rule

2. Check the details of the normalization rule on its page by attaching its UUID (45b486af-48f7-46cb-98b6-5e09750e1a30) to the end of this URL: https://archtorontomu.scholarsportal.info/fpr/fprule/. This can be done with any rule to check its page.

![Page for access normalization rule 45b486af-48f7-46cb-98b6-5e09750e1a30](/img/rule-access-45b486af-48f7-46cb-98b6-5e09750e1a30.JPG)
Above: Screenshot of https://archtorontomu.scholarsportal.info/fpr/fprule/45b486af-48f7-46cb-98b6-5e09750e1a30/

3. Click on **Transcoding to mp3 with ffmpeg** under **Command** to see the name of the file format it gets transcoded (normalized) to. In this case, it gets normalized to MPEG 1/2 Audio Layer 3.
4. Click on **Formats** at the side menu above **Groups** and search for "MPEG 1/2 Audio Layer 3" in the search box.

![Search results for MPEG 1/2 Audio Layer 3 in Archivematica format identification](/img/am-formats-mp3-search.JPG)

5. Click on **MPEG 1/2 Audio Layer 3 (fmt/134, fmt/134)**. This will open up the format list for that category in Archivematica. In this case, the only format is fmt/134, but sometimes there will be multiple formats that Archivematica categorizes as one format category as in the case of [Acrobat PDF/A](https://archtorontomu.scholarsportal.info/fpr/format/acrobat-pdf-a/).

![Archivematica page for MPEG 1/2 Audio Layer 3 format](/img/am-formats-mp3-page.JPG)

6. Click on **fmt/134** under **Pronom ID** to open up the PRONOM page for this format and read more about it.

**Now you know...**

- fmt/141 (Waveform Audio (PCMWAVEFORMAT)) files are normalized to fmt/134 (MPEG 1/2 Audio Layer 3) files for access purposes.
- **Normalizing from fmt/141 to fmt/134 is acceptable for our use case as MP3s work well as access copies due to their smaller size.** If a researcher wants the full WAV file we will have to provide that separately by downloading the AIP instead of providing them [an access link](#creating-access-links-for-the-dip).

## WAV normalization rules conclusion

There is no need to change the access and preservation normalization rules for Waveform Audio (PCMWAVEFORMAT) (fmt/141) files.

# MP3 analysis

## MP3 preservation normalization rule

1. Click on **Yes** under **Preservation normalization attempted** for one of the MPEG 1/2 Audio Layer 3 files, this will open the preservation task that Archivematica ran on the file

![Task 016f1498-5abd-4d4d-87bc-cef21ffc9d3e](/img/task-016f1498-5abd-4d4d-87bc-cef21ffc9d3e.PNG)

- The **Standard output (stdout)** explains that Archivematica:
  - Looked for a "manually normalized file" but did not find one
  - Identified the file as MPEG 1/2 Audio Layer 3 which is [fmt/134](https://www.nationalarchives.gov.uk/pronom/fmt/134) from the [PRONOM](https://www.nationalarchives.gov.uk/PRONOM/Default.aspx) registry
  - Normalization rule for this file format is 714fde9c-aa92-4af8-a713-c459559eeadd: Transcoding to wav with ffmpeg
  - [FFmpeg](https://ffmpeg.org/) is being used to implement this normalization rule
- **Normalizing from MP3 to WAV is not beneficial as MP3 is a compressed lossy format so quality will not improve with normalization. Normalization will just create unnecessary files that take up additional storage space.** Review the preservation normalization rule before contacting Permafrost to disable it.

2. Check the details of the normalization rule on its page by attaching its UUID (714fde9c-aa92-4af8-a713-c459559eeadd) to the end of this URL: https://archtorontomu.scholarsportal.info/fpr/fprule/. This can be done with any rule to check its page. In this case, the resulting link is https://archtorontomu.scholarsportal.info/fpr/fprule/714fde9c-aa92-4af8-a713-c459559eeadd.
3. Click on **Transcoding to wav with ffmpeg** under **Command** to see the name of the file format it gets transcoded (normalized) to. In this case, it gets normalized to Waveform Audio.
4. Click on **Formats** at the side menu above **Groups** and search for "Waveform Audio" in the search box.

![Search results for Waveform Audio](/img/am-formats-waveform-audio-search.PNG)

- None of these search results are actually the file format you're looking for as none of them say only "Waveform Audio" in their title

5. Search instead for "WAV"
6. Click on **WAV (fmt/6)**

![Archivematica page for format WAV](/img/format-2e4c63c5-4549-4d27-9f90-91dfe87c4438.PNG)

- Here is the actual file format you're looking for: Waveform Audio (fmt/6). The reason it wasn't showing up in the inital search is because it's been grouped under "WAV" alongside "Generic WAV"

7. Click on **fmt/6** under **Pronom ID** to open up the PRONOM page for this format and read more about it.

**Now you know...**

Archivematica by default normalizes [fmt/134](https://www.nationalarchives.gov.uk/pronom/fmt/134) (MPEG 1/2 Audio Layer 3) to [fmt/6](https://www.nationalarchives.gov.uk/PRONOM/fmt/6) (Waveform Audio) for preservation using the preservation normalization rule UUID:[714fde9c-aa92-4af8-a713-c459559eeadd](https://archtorontomu.scholarsportal.info/fpr/fprule/714fde9c-aa92-4af8-a713-c459559eeadd). This is not ideal as MP3 is a compressed lossy format so normalizing to WAV doesn't improve quality and just creates an additional unnecessary file.

## MP3 access normalization rule

1. Click on **Yes** under **Access normalization attempted** for one of the MPEG 1/2 Audio Layer 3 files, this will open the preservation task that Archivematica ran on the file

![Task 03ad4ca4-f16e-4afe-91b2-5ae79204d92f](/img/task-03ad4ca4-f16e-4afe-91b2-5ae79204d92f.PNG)

- The **Standard output (stdout)** explains that Archivematica:
  - Looked for a "manually normalized file" but did not find one
  - Identified the file as MPEG 1/2 Audio Layer 3 which is [fmt/134](https://www.nationalarchives.gov.uk/pronom/fmt/134) from the [PRONOM](https://www.nationalarchives.gov.uk/PRONOM/Default.aspx) registry
  - Normalization rule for this file format is e0d9f4bd-b35d-44e9-9cfd-fc7806a2f38d: Transcoding to mp3 with ffmpeg
  - [FFmpeg](https://ffmpeg.org/) is being used to implement this normalization rule

- **As the original file is already MP3, normalizing it to MP3 is redundant.** Review the access normalization rule to check whether this redundancy is actually occuring.

2. Check the details of the normalization rule on its page by attaching its UUID (e0d9f4bd-b35d-44e9-9cfd-fc7806a2f38d) to the end of this URL: https://archtorontomu.scholarsportal.info/fpr/fprule/. This can be done with any rule to check its page. In this case, the resulting link is https://archtorontomu.scholarsportal.info/fpr/fprule/e0d9f4bd-b35d-44e9-9cfd-fc7806a2f38d.
3. Click on **Transcoding to mp3 with ffmpeg** under **Command** to see the name of the file format it gets transcoded (normalized) to. In this case, it gets normalized to MPEG 1/2 Audio Layer 3.

**Now you know...**

Archivematica by default redundantly normalizes fmt/134 (MPEG 1/2 Audio Layer 3) to fmt/134 (MPEG 1/2 Audio Layer 3) for access using the access normalization rule UUID: [e0d9f4bd-b35d-44e9-9cfd-fc7806a2f38d](https://archtorontomu.scholarsportal.info/fpr/fprule/e0d9f4bd-b35d-44e9-9cfd-fc7806a2f38d). This is not beneficial as it essentially creates a duplicate file.

## MP3 normalization rules conclusion

Both the access and preservation normalization rules for MPEG 1/2 Audio Layer 3 (fmt/134) files should be disabled because:

- The preservation rule normalizes MP3 to WAV which produces a larger file that is not any higher quality than the original MP3
- The access rule unnecessarily normalizes MP3 to MP3 thus creating duplicate files

Both rules bloat our storage space by creating excess files. Jessica reached out to Permafrost and they are now disabled in our current Archivematica instance.

## Setting MP3 as a preservation standard

As well as disabling the MP3 rules, Jessica also requested that MP3 be set as a preservation standard within our Archivematica instance because otherwise it shows up in the normalization report as red cells which can make the report confusing to read:

![Normalization report where MP3 is not a preservation standard](/img/mp3-not-preservation-format.png)

When digitizing our audio materials, we only ever digitize to WAV (and occasionally provide MP3 as access copies), so if we have MP3s as the sole copy for an item, then they are going to be born-digital materials and thus meet our preservation standard.

# Checking other WAV and MP3 rules

The transfer used in the example above had very specific MP3 and WAV file formats. It is important to check all other possible MP3 and WAV formats and evaluate their normalization rules.

Searching for "wav" shows that the `Transcoding to wav with ffmpeg` rule is enabled for two other MPEG file formats.

![Search results for wav in Format policy rules](/img/mp3-preservation-rules.PNG)

Clicking on these rules and then clicking on the format reveals that MPEG 1/2 Audio Layer I ([fmt/347](https://www.nationalarchives.gov.uk/pronom/fmt/347)) is a subtype of MPEG Audio Stream Layer II ([fmt/198](https://www.nationalarchives.gov.uk/PRONOM/fmt/198)) which is a predecessor to MP3. This format would also not benefit from being normalized to WAV for the same reasons MP3 would not benefit from being normalized to WAV. Permafrost was emailed and these rules were disabled.

Next search for "mp3". The main goal here is to ensure there isn't any redunancy as there was with the disabled rule that normalized MP3 to MP3 for access.

![](/img/am-norm-mp3-access-1.PNG)

These 2 MP2 formats get normalized to MP3 for access. This is good and desirable as MP2 might have playability or access issues for users.

![](/img/am-norm-mp3-access-2.PNG)

At first glance, it might seem like redundancy is occuring. However, if you click into the actual rules it becomes clear that these MPEG formats are actually part of the [Broadcast WAVE](https://archtorontomu.scholarsportal.info/fpr/format/broadcast-wave/) category and thus normalizing to MP3 for access makes sense. None of the MP3 rules need to be disabled.

# Navigation

Click here to go back to the main [Table of Contents](/README.md)
