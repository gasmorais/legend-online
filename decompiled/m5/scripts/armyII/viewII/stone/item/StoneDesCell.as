package armyII.viewII.stone.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   
   public class StoneDesCell extends Sprite
   {
      
      private var _bit:Bitmap;
      
      private var _dex:FilterFrameText;
      
      private var _xing:int;
      
      public function StoneDesCell()
      {
         super();
         initView();
      }
      
      public function set xing(param1:int) : void
      {
         _xing = param1;
         _bit.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.army.stone.shape" + _xing);
         _dex.text = LanguageMgr.GetTranslation("army.stone.xingName" + _xing);
      }
      
      private function initView() : void
      {
         _bit = new Bitmap();
         _dex = ComponentFactory.Instance.creatComponentByStylename("army.stone.xingDesTxt");
         addChild(_bit);
         addChild(_dex);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bit);
         _bit = null;
         ObjectUtils.disposeObject(_dex);
         _dex = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

