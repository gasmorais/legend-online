package map.internals.view.viewport
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import map.campaign.event.CampaignMapEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class ViewPort implements IEnterFrame, Disposeable
   {
      
      private var stage:Stage;
      
      public var mapWidth:int;
      
      public var mapHeight:int;
      
      public var Disobj:DisplayObject;
      
      private var _rect:Rectangle;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _lockAt:Object;
      
      public var isLockAt:Boolean = false;
      
      public var lockArea:Boolean;
      
      public var lockAtObjectArea:Rectangle;
      
      private var _autoChangeSize:Boolean = false;
      
      private var _prePoint:Point = new Point();
      
      public function ViewPort(param1:DisplayObject, param2:int = 0, param3:int = 0, param4:Boolean = true, param5:int = 0, param6:int = 0, param7:Boolean = false)
      {
         super();
         this.lockArea = param4;
         _autoChangeSize = param7;
         _rect = new Rectangle(0,0,param2,param3);
         this.Disobj = param1;
         if(param1.stage)
         {
            stage = param1.stage;
            if(param2 == 0 || param3 == 0)
            {
               resizeToStage();
            }
         }
         else
         {
            param1.addEventListener("addedToStage",addToStage);
         }
         if(param6 != 0)
         {
            this.mapWidth = param5;
            this.mapHeight = param6;
         }
         else if(param1.width != 0 && param1.height != 0)
         {
            this.mapWidth = param1.width;
            this.mapHeight = param1.height;
         }
         else
         {
            this.mapWidth = 2147483647;
            this.mapHeight = 2147483647;
         }
         moveTo(param1.x,param1.y);
      }
      
      private function resizeToStage() : void
      {
         resize();
         if(_autoChangeSize)
         {
            stage.addEventListener("resize",resize);
         }
      }
      
      private function resize(param1:Event = null) : void
      {
         changeSize(stage.stageWidth,stage.stageHeight);
      }
      
      private function addToStage(param1:Event) : void
      {
         stage = disPlayObject.stage;
         Disobj.removeEventListener("addedToStage",addToStage);
         if(getLockAtObject())
         {
            EnterFrameManager.instance.registeEnterFrame(this);
            moveTo(_lockAt.x,_lockAt.y);
         }
         if(width == 0 || height == 0)
         {
            resizeToStage();
         }
      }
      
      public function lockAtObject(param1:Object, param2:Rectangle = null) : void
      {
         _lockAt = param1;
         lockAtObjectArea = param2;
         if(_lockAt != null)
         {
            if(!isLockAt)
            {
               isLockAt = true;
               if(stage)
               {
                  EnterFrameManager.instance.registeEnterFrame(this);
                  moveTo(_lockAt.x,_lockAt.y);
               }
               else
               {
                  Disobj.addEventListener("addedToStage",addToStage);
               }
            }
         }
         else
         {
            isLockAt = false;
            if(stage)
            {
               EnterFrameManager.instance.unRegisteEnterFrame(this);
            }
         }
      }
      
      public function getLockAtObject() : Object
      {
         return _lockAt;
      }
      
      public function enterFrame() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(lockAtObjectArea)
         {
            _loc2_ = _rect.x + lockAtObjectArea.x;
            _loc1_ = _rect.y + lockAtObjectArea.y;
            if(_lockAt.x < _loc2_)
            {
               this.x = _lockAt.x + (this.x - _loc2_);
            }
            else if(_lockAt.x > _loc2_ + lockAtObjectArea.width)
            {
               this.x = _lockAt.x + (this.x - _loc2_ - lockAtObjectArea.width);
            }
            if(_lockAt.y < _loc1_)
            {
               this.y = _lockAt.y + (this.y - _loc1_);
            }
            else if(_lockAt.y > _loc1_ + lockAtObjectArea.height)
            {
               this.y = _lockAt.y + (this.y - _loc1_ - lockAtObjectArea.height);
            }
         }
         else
         {
            moveTo(_lockAt.x,_lockAt.y);
         }
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         var _loc4_:Number = _rect.x;
         var _loc3_:Number = _rect.y;
         if(lockArea)
         {
            if(mapWidth > width)
            {
               if(param1 > mapWidth - width / 2)
               {
                  param1 = mapWidth - width / 2;
               }
               else if(param1 < width / 2)
               {
                  param1 = width / 2;
               }
            }
            else
            {
               param1 = width / 2;
            }
            if(mapHeight > height)
            {
               if(param2 > mapHeight - height / 2)
               {
                  param2 = mapHeight - height / 2;
               }
               else if(param2 < height / 2)
               {
                  param2 = height / 2;
               }
            }
            else
            {
               param2 = height / 2;
            }
         }
         _x = param1;
         _y = param2;
         _rect.x = param1 - width / 2;
         _rect.y = param2 - height / 2;
         if(_loc4_ == _rect.x && _loc3_ == _rect.y)
         {
            return;
         }
         Disobj.scrollRect = _rect;
         if(Math.abs(_prePoint.x - _rect.x >> 0) > 100 || Math.abs(_prePoint.y - _rect.y >> 0) > 100)
         {
            moveOver(this.x,this.y);
         }
      }
      
      private function moveOver(param1:Number, param2:Number) : void
      {
         _prePoint.x = param1;
         _prePoint.y = param2;
         Disobj.dispatchEvent(new CampaignMapEvent("MOVE_SCENET_END",Disobj));
      }
      
      public function set x(param1:Number) : void
      {
         moveTo(param1,y);
      }
      
      public function set y(param1:Number) : void
      {
         moveTo(x,param1);
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get width() : Number
      {
         return _rect.width;
      }
      
      public function get height() : Number
      {
         return _rect.height;
      }
      
      public function changeSize(param1:int, param2:int) : void
      {
         _rect.width = param1;
         _rect.height = param2;
         moveTo(x,y);
      }
      
      public function get mouseX() : Number
      {
         return Disobj.mouseX - _rect.x;
      }
      
      public function get mouseY() : Number
      {
         return Disobj.mouseY - _rect.y;
      }
      
      public function get disPlayObject() : DisplayObject
      {
         return Disobj;
      }
      
      public function dispose() : void
      {
         Disobj && Disobj.removeEventListener("addedToStage",addToStage);
         lockAtObject(null);
         stage = null;
         Disobj = null;
         _rect = null;
         lockAtObjectArea = null;
      }
   }
}

