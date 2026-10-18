package consortiachess.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class ChesspvpRewardBgView extends Sprite
   {
      
      private var _bit:Bitmap;
      
      private var _colors:Array = [];
      
      private var _gType:int;
      
      public function ChesspvpRewardBgView(param1:int)
      {
         super();
         _gType = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:ColorTransform = null;
         _bit = ComponentFactory.Instance.creatBitmap("asset.chesspvp.rd.bg");
         addChild(_bit);
         switch(_gType)
         {
            case 0:
               _loc1_ = new ColorTransform(0.42,0.92,1,1,-7,42,50);
               break;
            case 1:
               break;
            case 2:
               _loc1_ = new ColorTransform(0.22,1,1,1,17,30,16);
               break;
            case 3:
               _loc1_ = new ColorTransform(0.61,0.46,0.53,1,21,32,18);
         }
         if(_loc1_)
         {
            this.transform.colorTransform = _loc1_;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bit);
         _bit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

