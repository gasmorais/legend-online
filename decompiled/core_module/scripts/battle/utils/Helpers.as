package battle.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   
   public class Helpers
   {
      
      private static var _stage:Stage;
      
      public static const STAGE_UP_EVENT:String = "STAGE_UP_EVENT";
      
      public static const MOUSE_DOWN_AND_DRAGING_EVENT:String = "MOUSE_DOWN_AND_DRAGING_EVENT";
      
      private static var enterFrameDispatcher:Sprite = new Sprite();
      
      private static const code_arr:Array = [["\\[","[[","\\[\\[","["],["]","]]"]];
      
      public function Helpers()
      {
         super();
      }
      
      public static function setTextfieldFormat(param1:TextField, param2:Object, param3:Boolean = true) : void
      {
         var _loc4_:TextFormat = param1.getTextFormat();
         for(var _loc5_:String in param2)
         {
            _loc4_[_loc5_] = param2[_loc5_] || _loc4_[_loc5_];
         }
         if(param3)
         {
            param1.setTextFormat(_loc4_);
         }
         param1.defaultTextFormat = _loc4_;
      }
      
      public static function hidePosMc(param1:DisplayObjectContainer) : void
      {
         var _loc4_:DisplayObject = null;
         var _loc3_:int = 0;
         var _loc2_:RegExp = /_pos$/;
         _loc3_ = 0;
         while(_loc3_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc3_);
            if(_loc2_.test(_loc4_.name))
            {
               _loc4_.visible = false;
            }
            _loc3_++;
         }
      }
      
      public static function registExtendMouseEvent(param1:InteractiveObject) : void
      {
         param1.addEventListener("mouseDown",__dobjDown);
      }
      
      private static function __dobjDown(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var dobj:InteractiveObject = e.currentTarget as InteractiveObject;
         var fun_up:Function = function(param1:MouseEvent):void
         {
            dobj.dispatchEvent(new Event("STAGE_UP_EVENT"));
            dobj.stage.removeEventListener("mouseUp",fun_up);
            dobj.stage.removeEventListener("mouseMove",fun_move);
         };
         var fun_move:Function = function(param1:MouseEvent):void
         {
            dobj.dispatchEvent(new Event("MOUSE_DOWN_AND_DRAGING_EVENT"));
         };
         dobj.stage.addEventListener("mouseUp",fun_up);
         dobj.stage.addEventListener("mouseMove",fun_move);
      }
      
      public static function delayCall(param1:Function, param2:int = 1) : DelayCalling
      {
         var fun:Function = param1;
         var delay_frame:int = param2;
         var fun_new:Function = function(param1:Event):void
         {
            if(--delay_frame <= 0)
            {
               enterFrameDispatcher.removeEventListener("enterFrame",fun_new);
               fun();
               fun = null;
            }
         };
         var delayCall:DelayCalling = new DelayCalling(fun_new,enterFrameDispatcher);
         enterFrameDispatcher.addEventListener("enterFrame",fun_new);
         return delayCall;
      }
      
      public static function copyProperty(param1:Object, param2:Object, param3:Array = null) : void
      {
         for each(var _loc4_:String in param3)
         {
            param2[_loc4_] = param1[_loc4_];
         }
      }
      
      public static function cloneObject(param1:Object) : Object
      {
         var _loc2_:Object = {};
         for(var _loc3_:Object in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      public static function delayExcuteAfterAddToStage(param1:DisplayObject, param2:Function, param3:Boolean = true) : void
      {
         var new_function:Function;
         var obj:DisplayObject = param1;
         var add_to_stage_function:Function = param2;
         var remove_after_excute:Boolean = param3;
         if(obj.stage == null)
         {
            new_function = function(param1:Event):void
            {
               add_to_stage_function();
               obj.removeEventListener("addedToStage",new_function);
            };
            if(remove_after_excute)
            {
               obj.addEventListener("addedToStage",new_function);
            }
         }
         else
         {
            add_to_stage_function();
         }
      }
      
      public static function enCodeString(param1:String) : String
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < code_arr.length)
         {
            param1 = param1.replace(new RegExp(code_arr[_loc2_][0],"g"),code_arr[_loc2_][1]);
            _loc2_++;
         }
         return param1;
      }
      
      public static function deCodeString(param1:String) : String
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < code_arr.length)
         {
            if(code_arr[_loc2_].length > 2)
            {
               param1 = param1.replace(new RegExp(code_arr[_loc2_][2],"g"),code_arr[_loc2_][3]);
            }
            else
            {
               param1 = param1.replace(new RegExp(code_arr[_loc2_][1],"g"),code_arr[_loc2_][0]);
            }
            _loc2_++;
         }
         return param1;
      }
      
      public static function objectParamCheck(param1:Object, param2:Array) : void
      {
         if(param1 == null)
         {
            return;
         }
         for(var _loc3_:String in param1)
         {
            if(param2.indexOf(_loc3_) < 0)
            {
               throw new Error("参数 \"" + _loc3_ + "\"不存在！请检查拼写！");
            }
         }
      }
      
      public static function setChildPos(param1:DisplayObject, param2:DisplayObject, param3:Boolean = false) : void
      {
         param1.x = param2.x;
         param1.y = param2.y;
         param2.visible = false;
         if(param3)
         {
            param1.width = param2.width;
            param1.height = param2.height;
         }
      }
      
      public static function addOneTimeScript(param1:MovieClip, param2:int, param3:Function) : void
      {
         var mc:MovieClip = param1;
         var frame:int = param2;
         var frameFun:Function = param3;
         var newFun:Function = function():void
         {
            frameFun();
            mc.addFrameScript(frame,null);
         };
         mc.addFrameScript(frame,newFun);
      }
      
      public static function setChildrenPos(param1:DisplayObjectContainer, param2:Array) : void
      {
         for each(var _loc3_:Array in param2)
         {
            param1.addChildAt(_loc3_[0],param1.getChildIndex(_loc3_[1]));
            setChildPos(_loc3_[0],_loc3_[1],_loc3_[2]);
         }
      }
      
      public static function setup(param1:Stage) : void
      {
         _stage = param1;
      }
      
      public static function limitRange(param1:Number, param2:Number = 0, param3:Number = 1) : Number
      {
         if(param1 < param2)
         {
            return param2;
         }
         if(param1 > param3)
         {
            return param3;
         }
         return param1;
      }
      
      public static function removeAllChildren(param1:DisplayObjectContainer, param2:Boolean = true) : void
      {
         var _loc3_:DisplayObject = null;
         while(param1.numChildren)
         {
            _loc3_ = param1.getChildAt(0);
            if(param2)
            {
               if(_loc3_ is DisplayObjectContainer)
               {
                  if(!(_loc3_ is Loader))
                  {
                     removeAllChildren(DisplayObjectContainer(_loc3_));
                  }
               }
            }
            try
            {
               param1.removeChild(_loc3_);
               continue;
            }
            catch(e:Error)
            {
            }
            return;
         }
      }
      
      public static function getPos(param1:Point, param2:DisplayObject, param3:String) : Point
      {
         if(param1 && param2 && param3 && param2.hasOwnProperty(param3) && param2[param3] != null)
         {
            param1.x = param2[param3].x;
            param1.y = param2[param3].y;
         }
         return param1;
      }
      
      public static function getKeyList(param1:Dictionary) : Array
      {
         var _loc2_:Array = [];
         for(var _loc3_:String in param1)
         {
            _loc2_.push(int(_loc3_));
         }
         _loc2_.sort(16);
         return _loc2_;
      }
   }
}

