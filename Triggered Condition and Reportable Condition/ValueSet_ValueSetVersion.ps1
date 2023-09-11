############################################
## Created by: mikeeschneider
## Created: September 2023
## Description: This code will use an XSL document to pull and sdtc:valueSet and sdtc:valueSetVersion attributes out of 
## eCR code and value elements. In addition, the code will pull the code attribute that is found along with the 
## sdtc:valueSet and sdtc:valueSetVersion attributes in to a new XML document. Then the results of the transformed 
## document are written to a csv file. The hope is that this will allow users to quickly determine what triggered 
## the eCR at the sender, the version of the trigger codes used and the sender's name. The code will also pull information 
## from the RR (via XSL transformation) that was sent along with the eCR and write this data to the same csv.
## Users should update their state code in the RR XSLT file, so they only get the conditions that were found reportable to 
## their state. 
############################################


## Multiple Folders Grab
$compressed = "C:\Users\Downloads\folder with zipped eCRs"

## Things you need to edit
### $expand_folder is where the compressed file will be unzipped
$expand_folder = "C:\Users\Downloads\Folder2"

### $transform_folder is where the XSL transformation of the eCR will land
$transform_folder = "C:\Users\Downloads\Folder7"

### $output_folder is where the csv output file will be saved
$output_folder = "C:\Users\Downloads\Folder8"

### $XSLT_file is the path to the XSL file used
$XSLT_file = "C:\Users\Downloads\xsl\ValueSet_ValueSetVersion.xsl"
$XSLT_file_rr = "C:\Users\Downloads\xsl\RR_XSL_state_location_det_rep.xsl"

### Name of the csv file (need to include the .csv in the name)
$csv_name = "valueset information.csv"

## Things you don't need to edit
$expand_folder_xml = (-join( $expand_folder,"\*.xml"))
$expand_folder_html = (-join( $expand_folder,"\*.html"))
$expand_folder_ecrxml = (-join( $expand_folder,"\*CR.xml"))
$expand_folder_rrxml = (-join( $expand_folder,"\*RR.xml"))



function Get-ValueSet {

param($Trail)

#Unzipping folder
Expand-Archive -Path $Trail -DestinationPath $expand_folder



$Raw = [XML](Get-Content $expand_folder_ecrxml) 
## Get eCR ID number
$FileNameECR = $Raw.ClinicalDocument.id.root
## Create eCR file name
$FileNameECRXml = (-join($FileNameECR, "_ECR", ".xml"))
## Create RR file name
$FileNameRRXml = (-join($FileNameECR, "_RR", ".xml"))
## Path to renamed eCR file
$FileNameECRPath = (-join( $expand_folder, "\", $FileNameECRXml))
## Path to renamed RR file
$FileNameRRPath = (-join( $expand_folder, "\", $FileNameRRXml))
## Raw eCR Name (based off assumption that the file ends in "CR.xml"
$NameRawECR = (Get-Item -Path $expand_folder_ecrxml).FullName
## Raw RR name (based off assumption that the file ends in "RR.xml"
$NameRawRR = (Get-Item -Path $expand_folder_rrxml).FullName

## Rename eCR
Rename-Item -Path $NameRawECR -NewName $FileNameECRPath

## Rename RR
Rename-Item -Path $NameRawRR -NewName $FileNameRRPath

## XSL Transformation of ecR
$xslt = New-Object System.Xml.Xsl.XslCompiledTransform
$xslt.Load($XSLT_file) 
$xslt.Transform((-join( $expand_folder,"\",$FileNameECRXml)),(-join( $transform_folder,"\",$FileNameECRXml)))

## XSL Transformation of RR
$xsltrr = New-Object System.Xml.Xsl.XslCompiledTransform
$xsltrr.Load($XSLT_file_rr) 
$xsltrr.Transform((-join( $expand_folder,"\",$FileNameRRXml)),(-join( $transform_folder,"\",$FileNameRRXml)))

## Remove Items from $expand_folder
Remove-Item $expand_folder_xml
Remove-Item $expand_folder_html

## Transformed eCR XML
$transform_xml = (-join( $transform_folder,"\",$FileNameECRXml))
## Transformed RR XML
$transform_rrxml = (-join( $transform_folder,"\",$FileNameRRXml))

## If the XSL file is changed and new elements are added, then they need to added below so they show up in the csv 
## Format column_header = $object.Xpath.dot.notation

$ECRxml = [XML](Get-Content $transform_xml)
$RRxml = [XML](Get-Content $transform_rrxml)
$custobject = [PSCustomObject]@{
    ReportID = $ECRxml.rootroot.DocInfo.ReportID.value
    ReportDate = $ECRxml.rootroot.DocInfo.ReportDate.value
    ReportDate2 = $ECRxml.rootroot.DocInfo.ReportDate2
    Doc_Version = $ECRxml.rootroot.DocInfo.Doc_Version
    ProviderName = $ECRxml.rootroot.DocInfo.ProviderOrgName.value
    CustodianOrgName = $ECRxml.rootroot.DocInfo.CustodianOrgName.value

    SoftwareName = $ECRxml.rootroot.software.softwareName.value
    ManufactureName = $ECRxml.rootroot.software.manufactureName.value

    CodeValueSet_code = ($ECRxml.rootroot.CodeValueSet.code -join "^")
    CodeValueSet_value = ($ECRxml.rootroot.CodeValueSet.value -join "^")
    CodeValueSet_valueSet = ($ECRxml.rootroot.CodeValueSet.valueSet -join "^")
    CodeValueSet_valueSetVerstion = ($ECRxml.rootroot.CodeValueSet.valueSetVersion -join "^")

    ValueValueSet_code = ($ECRxml.rootroot.ValueValueSet.code -join "^")
    ValueValueSet_value = ($ECRxml.rootroot.ValueValueSet.value -join "^")
    ValueValueSet_valueSet = ($ECRxml.rootroot.ValueValueSet.valueSet -join "^")
    ValueValueSet_valueSetVersion = ($ECRxml.rootroot.ValueValueSet.valueSetVersion -join "^")

    eCRNum = $RRxml.RRxml.documentInfo.eCRNum.value
    setId = $RRxml.RRxml.documentInfo.setId.value
    versionNumber = $RRxml.RRxml.documentInfo.versionNumber.value
    
    ecrReceiptTime = $RRxml.RRxml.documentInfo.ecrReceiptTime.value
    ecrReceiptTime2 = $RRxml.RRxml.documentInfo.ecrReceiptTime2
    
    rrTime = $RRxml.RRxml.documentInfo.rrTime.value
    rrTime2 = $RRxml.RRxml.documentInfo.rrTime2
    
    encompassingEncounterDate = $RRxml.RRxml.documentInfo.encompassingEncounterDate.value
    encompassingEncounterDate2 = $RRxml.RRxml.documentInfo.encompassingEncounterDate2
    
    encompassingEncounterCode = $RRxml.RRxml.documentInfo.encompassingEncounterCode.value

    Firstname = $RRxml.RRxml.documentInfo.FirstName.value
    Lastname = $RRxml.RRxml.documentInfo.LastName.value
    DOB = $RRxml.RRxml.documentInfo.DOB.value
    
    receivedOrgName = $RRxml.RRxml.documentInfo.receivedOrgName.value
    receivedOrgState = $RRxml.RRxml.documentInfo.receivedOrgState.value

    providerOrgName = $RRxml.RRxml.documentInfo.providerOrgName.value
    providerOrgState = $RRxml.RRxml.documentInfo.providerOrgState.value

    serviceProviderName = $RRxml.RRxml.documentInfo.serviceProviderOrgName.value
    serviceProviderState = $RRxml.RRxml.documentInfo.serviceProviderOrgState.value

    healthCareFacilityName = $RRxml.RRxml.documentInfo.healthCareFacilityName.value
    healthCareFacilityState = $RRxml.RRxml.documentInfo.healthCareFacilityState.value

    condition1code = $RRxml.RRxml.conditionCode.condition1state.value
    condition2code = $RRxml.RRxml.conditionCode.condition2state.value
    condition3code = $RRxml.RRxml.conditionCode.condition3state.value
    condition4code = $RRxml.RRxml.conditionCode.condition4state.value
    condition5code = $RRxml.RRxml.conditionCode.condition5state.value
    condition6code = $RRxml.RRxml.conditionCode.condition6state.value
    condition7code = $RRxml.RRxml.conditionCode.condition7state.value
    
    displayName1 = $RRxml.RRxml.conditionCode.displayName1.value
    displayName2 = $RRxml.RRxml.conditionCode.displayName2.value
    displayName3 = $RRxml.RRxml.conditionCode.displayName3.value
    displayName4 = $RRxml.RRxml.conditionCode.displayName4.value
    displayName5 = $RRxml.RRxml.conditionCode.displayName5.value
    displayName6 = $RRxml.RRxml.conditionCode.displayName6.value
    displayName7 = $RRxml.RRxml.conditionCode.displayName7.value
    
    } | Export-Csv (-join( $output_folder,"\",$csv_name)) -Append

    ## Remove Tranformed eCR XML
    Remove-Item $transform_xml
    ## Remove Transformed RR XML
    Remove-Item $transform_rrxml
}




        foreach ($folder in $compressed){

        Get-ChildItem $folder -Recurse -Filter "*.zip" |
        ForEach-Object {Get-ValueSet $_.FullName}
        }

