############################################
## Created By: mikeeschneider
## Created: September 2023
## Description: This code will allow the user to unzip zipped folders, select and transform the eCR XML file using an XSL file, then write the results of 
## the transformed xml to a csv file. Specifically this script looks at some of the elements/attributes in the eCR that are used to populate S3 metadata.
## This could be useful to identify missing information in the eCR or identify the elements that would be useful for diverting senders to a test or prod 
## environment.
############################################


## Folder or folders that contain zipped folders
$compressed_rr = "Z:\eCR_folder1"

## Things you need to edit
### $expand_folder is where the compressed file will be unzipped
$expand_folder = "C:\Users\Downloads\Folder2"

### $transform_folder is where the XSL transformation of the eCR will land
$transform_folder = "C:\Users\Downloads\Folder7"

### $output_folder is where the csv output file will be saved
$output_folder ="C:\Users\Downloads\Folder8"

### $XSLT_file is the path to the XSL file used
$XSLT_file = "C:\Users\Downloads\S3 Data\S3_data.xsl"

### Name of the csv file. Must have .csv at the end
$csv_name = "S3 information.csv"

## Things you don't need to edit
$expand_folder_xml = (-join( $expand_folder,"\*.xml"))
$expand_folder_html = (-join( $expand_folder,"\*.html"))
$expand_folder_ecrxml = (-join( $expand_folder,"\*CR.xml"))



function Get-ECRXML {

param($Trail)

#Unzipping folder
Expand-Archive -Path $Trail -DestinationPath $expand_folder -Force 

$testpath1 = Test-Path $expand_folder_ecrxml

if ($testpath1 -eq "True"){

        $Raw = [XML](Get-Content $expand_folder_ecrxml) 
        $FileName = $Raw.ClinicalDocument.id.root + "_ECR"
        $FileNameXml = $FileName+".xml"
        $FileNamePath = (-join( $expand_folder,"\",$FileNameXml))
        #Rename file
        Rename-Item -NewName $FileNameXml -Path (-join( $expand_folder,"\*CR.xml")) 
        #XSL Transformation
        $xslt = New-Object System.Xml.Xsl.XslCompiledTransform
        $xslt.Load($XSLT_file) 
        $xslt.Transform((-join( $expand_folder,"\",$FileNameXml)),(-join( $transform_folder,"\",$FileNameXml)))
}
 else {
            Remove-Item $expand_folder_xml
            Remove-Item $expand_folder_html
            
        }
            Remove-Item $expand_folder_xml
            Remove-Item $expand_folder_html


$transform_xml = (-join( $transform_folder,"\",$FileNameXml))

## If the XSL file is changed and new elements are added, then they need to added below so they show up in the csv 
## Format column_header = $object.Xpath.dot.notation

# Writes data from $transform_xml to the csv file
$ECRxml = [XML](Get-Content $transform_xml)
$custobject = [PSCustomObject]@{
    reportDate = $ECRxml.rootroot.reportDate
    encounterDate = $ECRxml.rootroot.encounterDate
    ecrNum = $ECRxml.rootroot.ecrNum.value
    setIdRoot = $ECRxml.rootroot.setIdRoot.value
    versionNum = $ECRxml.rootroot.versionNum.value
    author = $ECRxml.rootroot.author.value
    authorIdRoot = $ECRxml.rootroot.authorId.value
    authorIdExtension = $ECRxml.rootroot.authorIdExtension.value
    serviceProviderOrg = $ECRxml.rootroot.serviceProviderOrg.value
    serviceProviderOrgIdRoot = $ECRxml.rootroot.serviceProviderOrgIdRoot.value
    serviceProviderOrgIdExtension = $ECRxml.rootroot.serviceProviderOrgIdExtension.value
    facility = $ECRxml.rootroot.facility.value
    facilityIdRoot = $ECRxml.rootroot.facilityIdRoot.value
    facilityIdExtension = $ECRxml.rootroot.facilityIdExtension.value
    sender = $ECRxml.rootroot.sender.value
    senderIdRoot = $ECRxml.rootroot.senderIdRoot.value
    senderIdExtension = $ECRxml.rootroot.senderIdExtension.value
    custodian = $ECRxml.rootroot.custodian.value
    custodianIdRoot = $ECRxml.rootroot.custodianIdRoot.value
    custodianIdExtension = $ECRxml.rootroot.custodianIdExtension.value

    } | Export-Csv (-join( $output_folder,"\",$csv_name)) -Append

    Remove-Item $transform_xml

}



foreach ($folder_rr in $compressed_rr){

Get-ChildItem $folder_rr -Recurse -Filter "*.zip" |
ForEach-Object {Get-ECRXML $_.FullName}
}

