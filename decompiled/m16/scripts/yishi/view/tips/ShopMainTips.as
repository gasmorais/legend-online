package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class ShopMainTips extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      public function ShopMainTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 240;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.GoodDescribeText");
         addChild(_title);
         addChild(_describe);
         _title.x = 10;
         _title.y = 10;
         _describe.x = 10;
         _describe.y = 34;
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.tips.ShopMainTips.InnerContain");
         if(tipData)
         {
            _title.text = tipData.name;
            _describe.htmlText = LanguageMgr.GetTranslation("public.colon",_loc1_) + tipData.content;
            _describe.height = _describe.textHeight + 5;
            _bg.height = _describe.y + _describe.textHeight + 12;
         }
      }
      
      override public function dispose() : void
      {
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_describe)
         {
            ObjectUtils.disposeObject(_describe);
         }
         _describe = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

