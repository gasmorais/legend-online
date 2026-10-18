package map.internals.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.text.TextField;
   import yishi.datas.ai.AIPhysicsBase;
   
   public class AIPhysicsEightDirection extends AIPhysicsBase
   {
      
      protected var _consortiaTxt:FilterFrameText;
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _movie1:Object;
      
      protected var _movie2:Object;
      
      protected var _movie3:Object;
      
      protected var _movie4:Object;
      
      protected var _movie5:Object;
      
      protected var _stand1:Object;
      
      protected var _stand2:Object;
      
      protected var _stand3:Object;
      
      protected var _stand4:Object;
      
      protected var _stand5:Object;
      
      public function AIPhysicsEightDirection()
      {
         super();
         initNameTxet();
      }
      
      private function initNameTxet() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("outercity.OutercityNameText");
         _nameTxt.mouseEnabled = _nameTxt.mouseWheelEnabled = false;
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("outercity.OutercityConsortiaext");
         _consortiaTxt.mouseEnabled = _consortiaTxt.mouseWheelEnabled = false;
         addChild(_nameTxt);
         addChild(_consortiaTxt);
      }
      
      public function get nameTextFiled() : TextField
      {
         return _nameTxt;
      }
      
      public function set nameValue(param1:String) : void
      {
         _nameTxt.text = param1;
         _nameTxt.x = -_nameTxt.textWidth;
      }
      
      public function get consortiaTxt() : TextField
      {
         return _consortiaTxt;
      }
      
      public function set consortiaValue(param1:String) : void
      {
         _consortiaTxt.text = param1;
         _consortiaTxt.x = -_consortiaTxt.textWidth;
      }
      
      override protected function checkDirection(param1:Point, param2:int = 1) : int
      {
         var _loc3_:Number = twoPointAngle(this.x,this.y,param1.x,param1.y);
         updateDirection(_loc3_);
         return _loc3_;
      }
      
      protected function twoPointAngle(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:int = param1 - param3;
         var _loc6_:int = param2 - param4;
         var _loc7_:Number = Math.atan2(_loc6_,_loc5_);
         _loc7_ = _loc7_ * 180 / 3.141592653589793;
         if(_loc7_ < 0)
         {
            _loc7_ += 360;
         }
         return _loc7_;
      }
      
      protected function updateDirection(param1:Number) : void
      {
         if(param1 >= 260 && param1 < 280)
         {
            movieClip = _movie1 as DisplayObject;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            movieClip = _movie2 as DisplayObject;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            movieClip = _movie3 as DisplayObject;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            movieClip = _movie4 as DisplayObject;
         }
         else if(param1 >= 80 && param1 < 100)
         {
            movieClip = _movie5 as DisplayObject;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            movieClip = _movie4 as DisplayObject;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            movieClip = _movie3 as DisplayObject;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            movieClip = _movie2 as DisplayObject;
         }
         (movieClip as Object).play();
         if(param1 >= 100 && param1 <= 260)
         {
            movieClip.scaleX = -1;
         }
         else
         {
            movieClip.scaleX = 1;
         }
      }
      
      override protected function walkOver() : void
      {
         dispose();
      }
      
      override protected function playMovie() : void
      {
         if(!_prePoint)
         {
            return;
         }
         if(info.currentFrame > info.totalFrame)
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
         clearMovie(_movie1);
         clearMovie(_movie2);
         clearMovie(_movie3);
         clearMovie(_movie4);
         clearMovie(_movie5);
         clearMovie(_stand1);
         clearMovie(_stand2);
         clearMovie(_stand3);
         clearMovie(_stand4);
         clearMovie(_stand5);
         if(_nameTxt && _nameTxt.parent)
         {
            _nameTxt.parent.removeChild(_nameTxt);
         }
         _nameTxt = null;
         super.dispose();
      }
      
      private function clearMovie(param1:Object) : void
      {
         if(param1)
         {
            if((param1 as DisplayObject).parent)
            {
               (param1 as DisplayObject).parent.removeChild(param1 as DisplayObject);
            }
            param1.stop();
         }
         param1 = null;
      }
      
      protected function standImp() : void
      {
         var _loc1_:Number = Number(movieClip ? movieClip.scaleX : 1);
         if(movieClip == _movie1)
         {
            movieClip = _stand1 as DisplayObject;
         }
         else if(movieClip == _movie2)
         {
            movieClip = _stand2 as DisplayObject;
         }
         else if(movieClip == _movie3)
         {
            movieClip = _stand3 as DisplayObject;
         }
         else if(movieClip == _movie4)
         {
            movieClip = _stand4 as DisplayObject;
         }
         else if(movieClip == _movie5)
         {
            movieClip = _stand5 as DisplayObject;
         }
         else if(movieClip == null)
         {
            movieClip = _stand1 as DisplayObject;
         }
         movieClip.scaleX = _loc1_;
      }
   }
}

