package fashion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class FashionRefreshAttributeItem extends Sprite implements Disposeable
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _addTxt:FilterFrameText;
      
      public function FashionRefreshAttributeItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshAttriTxt");
         _addTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshAddAttriTxt");
         addChild(_nameTxt);
         addChild(_addTxt);
      }
      
      public function gotoFrame(param1:int) : void
      {
         _nameTxt.setFrame(param1);
      }
      
      public function set attributeValue(param1:String) : void
      {
         _nameTxt.htmlText = param1;
      }
      
      public function set addAttributeValue(param1:String) : void
      {
         _addTxt.text = "";
         if(param1)
         {
            _addTxt.text = param1;
            _addTxt.x = _nameTxt.x + _nameTxt.textWidth + 5;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_addTxt);
         _addTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

