/**
 * @author Shashank Shastri
 * @description The VFC_Survey class implements an apex controller that
 * creates Customer Survey record through a 3 page wizard.
 */
public class VFC_Survey {
    /**  
    * Declaration and Getter-Setter method for boolean showError.
    * showError is used to render Error Messages on the UI.
    */
    public boolean showError {
        get;
        set;
    }
    /**  
    * Declaration and Getter-Setter method for Survey__c Object.
    * newSurvey is used to create the Customer Survey record.
    */
    public Survey__c newSurvey {
        get;
        set;
    }
    /**  
    * Constructor for class VFC_Survey, Checks for valid page access by the user and creates a new instanciates newSurvey object
    * @param none
    * @return none
    */
    public VFC_Survey() {
        String strurl = ApexPages.currentPage().getUrl();    // Get current URL
        strurl = strurl.split('apex/')[1];    // Get the Vf page name by splitting across '/apex'. 
        if (strurl.equals('VFP_SurveyPageOne?sfdc.tabName=01r280000005fah')||strurl.equals('VFP_SurveyPageOne')) {
            //User should only open the first page directly and Others via buttons on the wizard.
            showError = false;    //Set error as false. 
        } else {
            //User should skips the first page and directly opens the 2nd or the 3rd page then prompt the user to fill up the first page
            showError = true;
        }
        newSurvey = new Survey__c();
    }
    /**  
    * Returns the User to the first page of the wizard
    * @param none
    * @return PageReference
    * etc
    */
    public PageReference firstPage() {
        PageReference Page1 = Page.VFP_SurveyPageOne;    //First page of the Wizard
        return Page1;
    }
    /**  
    * Returns the User to the second page of the wizard
    * @param none
    * @return PageReference
    * etc
    */
    public PageReference secondPage() {
        PageReference Page2 = Page.VFP_SurveyPageTwo;    //Second page of the Wizard
        return Page2;
    }
    /**  
    * Returns the User to the third page of the wizard
    * @param none
    * @return PageReference
    * etc
    */
    public PageReference lastPage() {
        PageReference Page3 = Page.VFP_SurveyPageThree;    //Third page of the Wizard
        return Page3;
    }
    /**  
    * Saves the Customer Survey record and redirects the user to Success page.
    * if any failures occure the user remains on the same page and a Erro message displays
    * @param none
    * @return PageReference
    * etc
    */
    public PageReference Submit() {
        Pagereference Surveycomplete;
        try {
            database.insert(newSurvey);    // inserting the Survey Record
            Surveycomplete = Page.VFP_SurveyComplete;    //Redirect user to Succes page
        } catch (Exception e) {
            showError = true;    //Renders the Error message section on UI
            Surveycomplete = null;    //User remains on the same Page
        }
        return Surveycomplete;    //If success then redirect user to last page else remain on the same page.
    }
}