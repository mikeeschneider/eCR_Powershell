############################################
## Created By: mikeeschneider
## Created: September 2023
## Description: This code will find Reportability Responses (RR) that have a specified SNOMED code ($snomed) used by RCKMS to indicate the reportable condition in the
## electronic case report (eCR). When the specified SNOMED code ($snomed) is found, then the script will copy and rename the zipped eCR folder to the $output_folder.
## The script will also unzip the zipped folder to the $expand_folder, combine the eCR and RR into one document, rename the new file, and save it in the $output_folder.
############################################

## Things you need to edit
### Multiple Folders Grab
$compressed_rr = "Z:\folder_with_zipped_eCRs"

### $expand_folder is where the compressed file will be unzipped
$expand_folder = "C:\Users\Downloads\Folder2"

### $transform_folder is where the XSL transformation of the eCR will land
$transform_folder = "C:\Users\Downloads\Folder7"

### $output_folder is where output files will be saved
$output_folder = "C:\Users\Downloads\Folder8"

### Product or disease name- Should be the plain text version of the $snomed
$product = "COVID"

### RCKMS SNOMED- reportable condition from the RR
$snomed = 840539006


## Things you don't need to edit
$expand_folder_xml = (-join( $expand_folder,"\*.xml"))
$expand_folder_html = (-join( $expand_folder,"\*.html"))
$expand_folder_ecrxml = (-join( $expand_folder,"\*CR.xml"))
$expand_folder_zip = (-join( $expand_folder,"\*.zip"))


function Get-ECRXML {

param($Trail)

## Copying Zipped Folder to $expand_folder
Copy-Item -Path $Trail -Destination $expand_folder
## Unzipping folder in $expand_folder
Expand-Archive -Path $expand_folder_zip -DestinationPath $expand_folder -Force 

## Retrieving content from the RR XML document
$RRinfo = [XML](Get-Content (-join( $expand_folder,"\*RR.xml")))
## eCR ID number
$ecrNum = $RRinfo.ClinicalDocument.component.structuredBody.component.section.entry.act.reference.externalDocument.id.root
## eCR Date
$ecrDate = ($RRinfo.ClinicalDocument.component.structuredBody.component.section.entry.act.effectiveTime.value).Substring(0,8)
## Encounter Date
$EncDate = ($RRinfo.ClinicalDocument.componentOf.encompassingEncounter.effectiveTime.low.value).Substring(0,8)
## Encounter Code
$EncCode = $RRinfo.ClinicalDocument.componentOf.encompassingEncounter.code.code
## Patient Last Name
$family = $RRinfo.ClinicalDocument.recordTarget.patientRole.patient.name | Where-Object {$_.use -eq 'L'} | Select family
## SNOMED for reportable disease (may have issues differentiating diseases reportable to other states)
$disease = $RRinfo.ClinicalDocument.component.structuredBody.component.section.entry.organizer.component.observation.value.code

## Name of the HTML file
$NameHTML = (-join($ecrNum, "_", $ecrDate, "_", $EncDate, "_", $EncCode,"_", $family, "_", $product, ".html"))
## Name of the Zipped Folder
$Namezip = (-join((Get-Item -Path $expand_folder_zip).BaseName,"_",$product,".zip"))
## Folder to copy the HTML from
$Namecopyfrom = (-join($expand_folder,"\", $NameHTML))
## Folder to copy the HTML to
$Namecopyto = (-join($output_folder,"\", $NameHTML))

if ($disease -contains $snomed){

    ## Combines eCR and RR HTML into one document
    (Get-Content (-join($expand_folder,"\*CR.html"))) + 
    (Get-Content (-join($expand_folder,"\*RR.html"))) |
    Set-Content $Namecopyto
    
    ## Will only move the eCR HTML (uncomment code below to use)
    # Rename-Item -Path (-join( $expand_folder,"\*CR.html")) -NewName $Namecopyfrom
    # Move-Item -Path $Namecopyfrom -Destination $Namecopyto
    
    ## Moves Zip folder to $output_folder
    Rename-Item -Path $expand_folder_zip -NewName $Namezip
    Move-Item -Path (-join($expand_folder,"\",$Namezip)) -Destination $output_folder
 }
else { }

Remove-Item $expand_folder_xml
Remove-Item $expand_folder_html
Remove-Item $expand_folder_zip

}



foreach ($folder_rr in $compressed_rr){
Get-ChildItem $folder_rr -Recurse -Filter "*.zip" |
ForEach-Object {Get-ECRXML $_.FullName}
}
