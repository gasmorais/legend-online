package year2023.ui.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class YearActiveXUI extends Sprite
   {
      
      protected var _typebg:Bitmap;
      
      protected var _actNameTxt:FilterFrameText;
      
      protected var _actTimeTxt:FilterFrameText;
      
      protected var _actTime2Txt:FilterFrameText;
      
      public function YearActiveXUI()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _typebg = ComponentFactory.Instance.creatBitmap("asset.yearactive.enter.typebg");
         _actNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.actNameTxt");
         _actTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.actTimeTxt");
         _actTime2Txt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.actTime2Txt");
         addChild(_typebg);
         addChild(_actNameTxt);
         addChild(_actTimeTxt);
         addChild(_actTime2Txt);
      }
      
      public function set actName(param1:String) : void
      {
         this._actNameTxt.text = param1;
      }
      
      public function set actStartTime(param1:String) : void
      {
         this._actTimeTxt.text = param1;
      }
      
      public function set actStopTime(param1:String) : void
      {
         this._actTime2Txt.text = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_typebg);
         _typebg = null;
         ObjectUtils.disposeObject(_actNameTxt);
         _actNameTxt = null;
         ObjectUtils.disposeObject(_actTimeTxt);
         _actTimeTxt = null;
         ObjectUtils.disposeObject(_actTime2Txt);
         _actTime2Txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

