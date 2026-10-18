package view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.filter.UIFilter;
   
   public class GoodsItem2 extends GoodsItem
   {
      
      public function GoodsItem2()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _filter = new UIFilter();
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsItemBg2");
         _lookBtn = ComponentFactory.Instance.creatComponentByStylename("core.TryOnButton");
         _lookBtn.x = 10;
         _lookBtn.y = 59;
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.BuyBtn");
         _buyBtn.y = 56;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsNameTextStyle");
         _nameTxt.y = 14;
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsValueTextStyle");
         _valueTxt.y = 36;
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("core.SmallValueIcon");
         _lineImg.y = 36;
         _tips = ComponentFactory.Instance.creatComponentByStylename("shop.ItemShopTipsTextStyle");
         _goods = ComponentFactory.Instance.creatCustomObject("shop.BaseItemView2");
         _bg.setFrame(1);
         _lookBtn.visible = false;
         _lookBtn.text = LanguageMgr.GetTranslation("view.GoodsItem3.tryOnBtn.text");
         addChild(_bg);
         addChild(_lineImg);
         addChild(_nameTxt);
         addChild(_tips);
         addChild(_valueTxt);
         addChild(_buyBtn);
         addChild(_goods);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

