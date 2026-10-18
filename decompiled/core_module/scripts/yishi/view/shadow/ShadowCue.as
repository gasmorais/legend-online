package yishi.view.shadow
{
   import battle.view.utils.DepthSprite;
   import com.greensock.TweenLite;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ShadowCue extends DepthSprite
   {
      
      public var master:DisplayObject;
      
      private var _bm:Bitmap;
      
      public function ShadowCue(param1:DisplayObject, param2:DisplayObject)
      {
         super();
         this.master = param1;
         var _loc3_:Rectangle = param2.getBounds(param2.parent);
         var _loc4_:BitmapData = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc4_.draw(param1,new Matrix(1,0,0,1,param2.x - _loc3_.x,param2.y - _loc3_.y),null,null,new Rectangle(0,0,_loc3_.width,_loc3_.height));
         _bm = new Bitmap(_loc4_);
         addChild(_bm);
         _loc3_ = param2.getBounds(param2.parent);
         this.x = _loc3_.x;
         this.y = _loc3_.y;
         TweenLite.to(this,0.5,{
            "alpha":0,
            "onComplete":die,
            "delay":0.05
         });
      }
      
      public static function addOne(param1:DisplayObject, param2:ColorTransform = null, param3:DisplayObjectContainer = null) : void
      {
         if(!param3.parent)
         {
            ShadowEffectMaker.stopPhantom(param1);
            return;
         }
         var _loc4_:ShadowCue = new ShadowCue(param1,param3);
         _loc4_.alpha = 0.7;
         if(param2)
         {
            _loc4_.transform.colorTransform = param2;
         }
         var _loc5_:int = param3.parent.getChildIndex(param3);
         if(--_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         param3.parent.addChildAt(_loc4_,_loc5_);
      }
      
      private function die() : void
      {
         _bm.bitmapData.dispose();
         TweenLite.killTweensOf(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

