package yishi.ai
{
   import flash.display.MovieClip;
   import flash.geom.Point;
   import flash.text.TextField;
   import yishi.datas.ai.AIPhysicsBase;
   
   public class AIPhysicsFourDirection extends AIPhysicsBase
   {
      
      protected var _nameTxt:TextField;
      
      protected var _walkFontAsset:MovieClip;
      
      protected var _walkBackAsset:MovieClip;
      
      protected var _standFrontAsset:MovieClip;
      
      protected var _standBackAsset:MovieClip;
      
      public function AIPhysicsFourDirection(param1:MovieClip, param2:MovieClip, param3:MovieClip, param4:MovieClip)
      {
         super();
         _walkFontAsset = param1;
         _walkBackAsset = param2;
         _standFrontAsset = param3;
         _standBackAsset = param4;
         initView();
      }
      
      private function initView() : void
      {
         _nameTxt = new TextField();
         _nameTxt.textColor = 16776960;
         _nameTxt.height = 18;
      }
      
      override protected function checkDirection(param1:Point, param2:int = 1) : int
      {
         var _loc3_:int = 20;
         if(int(this.y) < int(param1.y))
         {
            movieClip = _walkFontAsset || _standFrontAsset;
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         else
         {
            movieClip = _walkBackAsset || _standBackAsset;
            if(this.x < param1.x)
            {
               this.scaleX = 1;
            }
            else
            {
               this.scaleX = -1;
            }
         }
         return 0;
      }
      
      override protected function playMovie() : void
      {
         if(!_prePoint)
         {
            return;
         }
         if(info.currentFrame >= info.totalFrame)
         {
            return;
         }
         var _loc1_:Point = Point.interpolate(_nextPoint,_prePoint,info.currentFrame / info.totalFrame);
         this.x = _loc1_.x;
         this.y = _loc1_.y;
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         checkDirection(param1);
         _prePoint = new Point(this.x,this.y);
         _nextPoint = new Point(param1.x,param1.y);
         var _loc2_:int = Point.distance(_prePoint,_nextPoint);
         info.currentFrame = 0;
         info.totalFrame = _loc2_ / _info.speed;
      }
      
      override public function dispose() : void
      {
         if(_walkBackAsset)
         {
            if(_walkBackAsset.parent)
            {
               _walkBackAsset.parent.removeChild(_walkBackAsset);
            }
            _walkBackAsset.stop();
            _walkBackAsset = null;
         }
         if(_walkFontAsset)
         {
            if(_walkFontAsset.parent)
            {
               _walkFontAsset.parent.removeChild(_walkFontAsset);
            }
            _walkFontAsset.stop();
            _walkFontAsset = null;
         }
         if(_nameTxt.parent != null && _nameTxt.parent.contains(_nameTxt))
         {
            _nameTxt.parent.removeChild(_nameTxt);
         }
         super.dispose();
      }
   }
}

