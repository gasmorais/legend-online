package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.view.tips.BaseTip;
   
   public class TmpTips extends BaseTip
   {
      
      private var _title:FilterFrameText;
      
      private var _describe:FilterFrameText;
      
      public function TmpTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.width = 200;
         _title = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText");
         _describe = ComponentFactory.Instance.creatComponentByStylename("tips.GoodDescribeText.Tmptips");
         addChild(_title);
         _title.x = _title.y = 10;
         addChild(_describe);
      }
      
      override protected function updateTransform() : void
      {
         if(tipData)
         {
            _title.text = tipData["itemName"];
            _describe.text = tipData.des;
            _describe.height = _describe.textHeight + 5;
            _bg.height = _describe.y + _describe.textHeight + 10;
         }
      }
      
      override public function dispose() : void
      {
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
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

