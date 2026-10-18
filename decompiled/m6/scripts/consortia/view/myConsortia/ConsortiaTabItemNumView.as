package consortia.view.myConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class ConsortiaTabItemNumView extends Sprite implements Disposeable
   {
      
      private var _recruitNumBg:Bitmap;
      
      private var _recruitNumTxt:FilterFrameText;
      
      public function ConsortiaTabItemNumView()
      {
         super();
         initView();
         this.visible = false;
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _recruitNumBg = ComponentFactory.Instance.creatBitmap("asset.consortiaboxNumBg");
         _recruitNumTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.boxNumTxt");
         _recruitNumBg.x = 0;
         _recruitNumBg.y = 0;
         _recruitNumTxt.x = _recruitNumBg.x + 3;
         _recruitNumTxt.y = 5;
         addChild(_recruitNumBg);
         addChild(_recruitNumTxt);
      }
      
      public function set num(param1:int) : void
      {
         this.visible = false;
         if(param1 > 0)
         {
            _recruitNumTxt.text = param1 + "";
            this.visible = true;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_recruitNumBg);
         _recruitNumBg = null;
         ObjectUtils.disposeObject(_recruitNumTxt);
         _recruitNumTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

