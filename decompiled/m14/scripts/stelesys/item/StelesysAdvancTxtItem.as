package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class StelesysAdvancTxtItem extends Sprite
   {
      
      private var _title:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _arrowTxt:FilterFrameText;
      
      private var _retTxt:FilterFrameText;
      
      public function StelesysAdvancTxtItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.advanceTitleTxt");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.advanceCurrLvTxt");
         _arrowTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.advanceUpFlgTxt");
         _retTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.advanceTargetLvTxt");
         addChild(_title);
         addChild(_gradeTxt);
         addChild(_arrowTxt);
         addChild(_retTxt);
         _gradeTxt.text = "-";
         _retTxt.text = "-";
         _arrowTxt.text = LanguageMgr.GetTranslation("stela.advance.arrow");
      }
      
      public function set type(param1:int) : void
      {
         _title.text = LanguageMgr.GetTranslation("stela.advance.title" + param1);
      }
      
      public function set nameTxt(param1:String) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("PropertyName." + param1) + LanguageMgr.GetTranslation("PropertyName.dot");
         _title.text = "" + _loc2_;
      }
      
      public function refreshView(param1:int, param2:int) : void
      {
         _gradeTxt.text = "" + param1;
         _retTxt.text = "" + param2;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_arrowTxt);
         _arrowTxt = null;
         ObjectUtils.disposeObject(_retTxt);
         _retTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

