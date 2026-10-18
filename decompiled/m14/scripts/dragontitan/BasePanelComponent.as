package dragontitan
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   
   public class BasePanelComponent extends Component
   {
      
      private var _eventCollection:Vector.<EventInfo> = new Vector.<EventInfo>();
      
      public function BasePanelComponent()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
      }
      
      protected function initEvent() : void
      {
      }
      
      protected function removeEvent() : void
      {
      }
      
      protected function setTempBg(param1:String = "tempViewBg") : void
      {
         var _loc2_:Bitmap = this.creatBitmap(param1);
         this.addChildAt(_loc2_,0);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_eventCollection)
         {
            _eventCollection.forEach(disposeEventInfo);
            _eventCollection.length = 0;
            _eventCollection = null;
         }
         super.dispose();
      }
      
      protected function addEvent(param1:EventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false) : void
      {
         _eventCollection.push(new EventInfo(param1,param2,param3,param4,param5,param6));
         param1.addEventListener(param2,param3,param4,param5,param6);
      }
      
      protected function deleteEvent(param1:EventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false) : void
      {
         removeAppointEventInfo(param1,param2,param3,param4,param5,param6);
      }
      
      private function removeAppointEventInfo(param1:EventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = undefined;
         _loc8_ = _eventCollection.length - 1;
         while(_loc8_ >= 0)
         {
            if(_eventCollection[_loc8_].isAppointInfo(param1,param2,param3,param4,param5,param6))
            {
               _loc7_ = _eventCollection.splice(_loc8_,1);
               _loc7_.forEach(disposeEventInfo);
               _loc7_.length = 0;
               break;
            }
            _loc8_--;
         }
      }
      
      private function disposeEventInfo(param1:EventInfo, param2:int, param3:Vector.<EventInfo>) : void
      {
         param1.dispose();
      }
      
      protected function addCreatBitmap(param1:String) : Bitmap
      {
         var _loc2_:Bitmap = creatBitmap(param1);
         if(_loc2_)
         {
            addChild(_loc2_);
         }
         return _loc2_;
      }
      
      protected function creatBitmap(param1:String) : Bitmap
      {
         return ComponentFactory.Instance.creatBitmap(param1);
      }
      
      protected function creatBitmapData(param1:String) : BitmapData
      {
         return ComponentFactory.Instance.creatBitmapData(param1);
      }
      
      protected function addCreatComponentByStylename(param1:String, param2:Array = null) : *
      {
         var _loc3_:* = creatComponentByStylename(param1,param2);
         if(_loc3_)
         {
            addChild(_loc3_);
         }
         return _loc3_;
      }
      
      protected function addCreatCustomObject(param1:String, param2:Array = null) : *
      {
         var _loc3_:DisplayObject = creatCustomObject(param1,param2);
         if(_loc3_)
         {
            addChild(_loc3_);
         }
         return _loc3_;
      }
      
      protected function creatCustomObject(param1:String, param2:Array = null) : *
      {
         return ComponentFactory.Instance.creatCustomObject(param1,param2);
      }
      
      protected function creatComponentByStylename(param1:String, param2:Array = null) : *
      {
         return ComponentFactory.Instance.creatComponentByStylename(param1,param2);
      }
   }
}

import flash.events.EventDispatcher;

class EventInfo
{
   
   public var dispatcher:EventDispatcher;
   
   public var type:String;
   
   public var listener:Function;
   
   public var useCapture:Boolean;
   
   public var priority:int;
   
   public var useWeakReference:Boolean;
   
   public function EventInfo(param1:EventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false)
   {
      super();
      this.dispatcher = param1;
      this.type = param2;
      this.listener = param3;
      this.useCapture = param4;
      this.priority = param5;
      this.useWeakReference = param6;
   }
   
   public function isAppointInfo(param1:EventDispatcher, param2:String, param3:Function, param4:Boolean = false, param5:int = 0, param6:Boolean = false) : Boolean
   {
      return this.dispatcher == param1 && this.type == param2 && this.listener == param3 && this.useCapture == param4 && this.priority == param5 && this.useWeakReference == param6;
   }
   
   public function dispose() : void
   {
      dispatcher.removeEventListener(type,listener,useCapture);
      this.dispatcher = null;
      this.listener = null;
   }
}
