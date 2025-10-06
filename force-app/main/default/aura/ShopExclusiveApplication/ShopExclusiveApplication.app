<aura:application extends="force:slds" >
    
    <lightning:layout class="slds-grid slds-grid_vertical">      
        
        <lightning:card title="Search products by vendor" class="slds-m-bottom_xxx-small slds-col slds-size_8-of-12">
            <c:ShopifySearchProductsForm/>
        </lightning:card>
        
        <lightning:card title="Matching Boats" class="slds-col slds-size_8-of-12">
            <c:ShopifySearchPrpducts/>
        </lightning:card>
        
        

    </lightning:layout>
</aura:application>