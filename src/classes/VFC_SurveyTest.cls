@isTest
private class VFC_SurveyTest {
    static testMethod void testSurvey() {
        PageReference pageRef = Page.VFP_SurveyPageOne;
        Test.setCurrentPage(pageRef);
        VFC_Survey controller = new VFC_Survey();
        controller.newSurvey.Customer_name__c = 'hello';
        controller.newSurvey.address__c = 'hello';
        String nextPage = controller.secondPage().getUrl();
        System.assertEquals('/apex/vfp_surveypagetwo', nextPage);

        pageRef = new PageReference(nextpage);
        Test.setCurrentPage(pageRef);
        nextPage = controller.firstPage().getUrl();
        System.assertEquals('/apex/vfp_surveypageone', nextPage);

        nextPage = controller.lastPage().getUrl();
        System.assertEquals('/apex/vfp_surveypagethree', nextPage);

        pageRef = new PageReference(nextpage);
        Test.setCurrentPage(pageRef);
        nextPage = controller.secondPage().getUrl();
        System.assertEquals('/apex/vfp_surveypagetwo', nextPage);

        nextPage = controller.Submit().getUrl();
        System.assertEquals('/apex/vfp_surveycomplete', nextPage);
    }
    static testMethod void testSurvey1() {
        PageReference pageRef = Page.VFP_SurveyPageThree;
        Test.setCurrentPage(pageRef);
        VFC_Survey controller = new VFC_Survey();
        controller.Submit();
        System.assertEquals(true, controller.showError);
    }
}