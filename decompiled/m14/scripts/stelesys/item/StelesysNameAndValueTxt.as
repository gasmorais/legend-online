package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class StelesysNameAndValueTxt extends Sprite
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _valueTxt:FilterFrameText;
      
      private var _nStyle:String;
      
      private var _vStyle:String;
      
      public function StelesysNameAndValueTxt(param1:String, param2:String)
      {
         super();
         _nStyle = param1;
         _vStyle = param2;
         initView();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename(_nStyle);
         _valueTxt = ComponentFactory.Instance.creatComponentByStylename(_vStyle);
         addChild(_nameTxt);
         addChild(_valueTxt);
      }
      
      public function set nameTxt(param1:String) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("PropertyName." + param1) + LanguageMgr.GetTranslation("PropertyName.dot");
         _nameTxt.text = "" + _loc2_;
      }
      
      public function set valueTxt(param1:int) : void
      {
         if(param1 == -1)
         {
            _valueTxt.text = "?";
         }
         else
         {
            _valueTxt.text = "" + param1;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_valueTxt);
         _valueTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

