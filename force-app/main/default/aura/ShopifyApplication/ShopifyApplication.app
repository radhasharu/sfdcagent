<aura:application extends="force:slds">
    <div class="slds-m-around_large">
        <div class="slds-box">
            Shop Exciting
        </div>
        <div class="slds-theme_info">
            <ul class="slds-list_horizontal slds-has-inline-block-links_space slds-text-link_reset">
                <li>
                    <a href="javascript:void(0);" onclick="{!c.callProdComp}">All Products</a>
                </li>
                <li>
                    <a href="javascript:void(0);">New Product</a>
                </li>
            </ul>
        </div>
        
        
    </div>
    <c:ShopifyProductComponent/>
    
</aura:application>