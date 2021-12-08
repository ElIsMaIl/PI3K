# Local directory to test
d="."

# url represents the SODAR project link as copied from SODAR UI
url="https://sodar-davrods.bihealth.org/sodarZone/projects/77/7730eded-bd35-4a55-b085-ca8dad6ac300/sample_data/study_003c0f8a-12ed-449d-948a-9eedded409fd/assay_dae3553f-581a-4e89-80c1-2e0acc761a51" 

# Select the URL's project part
sodar=$(echo "$url" | sed -e "s/^https:\/\/sodar-davrods\.bihealth\.org//" | sed -re "s/\/assay_[0-9a-z-]+$//")

# Show the files which md5 checksums are not in SODAR
join -j1 1 -j2 2 -v 1 \
    <(find $d -name '*.md5' -exec cat {} \; | sed -e "s/  */\t/" | sort -k 1b,1) \
    <(iquest --no-page '%s/%s %s' "select COLL_NAME, DATA_NAME, DATA_CHECKSUM where COLL_NAME like '"${sodar}"%'" | grep -v "\.md5$" | sed -e "s/  */\t/" | sort -k 2b,2)
