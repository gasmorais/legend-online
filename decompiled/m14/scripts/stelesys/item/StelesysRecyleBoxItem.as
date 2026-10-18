package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.stele.StelesysInfo;
   
   public class StelesysRecyleBoxItem extends StelesysBaseBoxItem
   {
      
      private var _colorBg:Bitmap;
      
      private var _numTxt:FilterFrameText;
      
      public function StelesysRecyleBoxItem()
      {
         super();
      }
      
      override protected function addEvent() : void
      {
      }
      
      override protected function initView() : void
      {
         super.initView();
         _scaleSp.scaleX = _scaleSp.scaleY = 0.8;
         _colorBg = ComponentFactory.Instance.creatBitmap("asset.stelesys.back1");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.recyleMTxt");
         addChild(_colorBg);
         addChild(_numTxt);
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         super.data = param1;
         _numTxt.text = "" + param1.exp;
         if(_data)
         {
            this.tipData = _data.tempInfo.Description;
         }
      }
      
      public function set num(param1:int) : void
      {
         _numTxt.text = "" + param1;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_colorBg);
         _colorBg = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         super.dispose();
      }
   }
}

