package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.view.tips.BaseTip;
   
   public class GroupbuyCheckTips extends BaseTip
   {
      
      private var _describe:FilterFrameText;
      
      public function GroupbuyCheckTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 186;
         _bg.height = 138;
         _describe = ComponentFactory.Instance.creatComponentByStylename("groupbuychecktips.txt");
         addChild(_describe);
      }
      
      override protected function updateTransform() : void
      {
         if(tipData)
         {
            _describe.text = LanguageMgr.GetTranslation("funny.groupbuy.checktips",tipData["checkTime"]);
         }
      }
      
      override public function dispose() : void
      {
         if(_describe)
         {
            _describe.dispose();
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

