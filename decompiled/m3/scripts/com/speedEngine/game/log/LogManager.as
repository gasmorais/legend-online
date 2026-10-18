package com.speedEngine.game.log
{
   import com.debug.ObjectManager;
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.view.BaseSprite;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.events.KeyboardEvent;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   use namespace basegame_internal;
   
   public class LogManager
   {
      
      public static const ERROR:int = 0;
      
      public static const WARNING:int = 1;
      
      public static const SOCKET:int = 2;
      
      public static const TEMP:int = 3;
      
      public static const INFO:int = 4;
      
      public static const EVENT:int = 5;
      
      public static const LOADER:int = 6;
      
      public static var IsCreateFile:Boolean = true;
      
      private static var _instance:LogManager;
      
      private var _showLogType:int = 5;
      
      private var _text:TextField;
      
      private var _shape:Shape;
      
      private var _cmdText:TextField;
      
      private var _isDebug:Boolean = true;
      
      private var _isWriteFile:Boolean = false;
      
      private var _scorllLen:int;
      
      private var _objectMangerInstance:Object;
      
      private var _printState:Array = [0,1,2,4];
      
      private var _modelState:Array = [];
      
      private var _locking:Boolean = false;
      
      private var _objectContainer:BaseSprite;
      
      private var _printModel:Array = [];
      
      private var _cmdDetailed:Object = {
         "HELP":{
            "text":"help",
            "detail":"帮助 {invalid_utf8=230}{invalid_utf8=137}?有的命令可以用空格分隔连{invalid_utf8=231}{invalid_utf8=148}? 类似于dos命令"
         },
         "OBJECTS":{
            "text":"objects",
            "detail":"当前{invalid_utf8=230}{invalid_utf8=137}?有的组件{invalid_utf8=230}{invalid_utf8=149}?"
         },
         "MEMORY":{
            "text":"memory",
            "detail":"当前的程序所用的内存"
         },
         "OBJECTMEMORY":{
            "text":"objectmemory",
            "detail":"{invalid_utf8=230}{invalid_utf8=137}?有组件类{invalid_utf8=230}{invalid_utf8=137}?占内{invalid_utf8=229}{invalid_utf8=173}?"
         },
         "PRINTOBJECT":{
            "text":"printobject",
            "detail":"打印当前{invalid_utf8=230}{invalid_utf8=137}?有组件所占的个数和内{invalid_utf8=229}{invalid_utf8=173}?"
         },
         "CLEAR":{
            "text":"clear",
            "detail":"清理当前界面的内{invalid_utf8=229}{invalid_utf8=174}?"
         },
         "LOCK":{
            "text":"lock",
            "detail":"锁定或解锁当前页面的滚动"
         },
         "ADDOBJECT":{
            "text":"addobject",
            "detail":"添加未释放的显示对象到舞{invalid_utf8=229}{invalid_utf8=143}?"
         },
         "REMOVEOBJECT":{
            "text":"removeobject",
            "detail":"删除舞台上未释放的对{invalid_utf8=232}{invalid_utf8=177}?"
         },
         "DISPOSEOBJECT":{
            "text":"disposeobject",
            "detail":"强制释放未释放干{invalid_utf8=229}{invalid_utf8=135}?的对{invalid_utf8=232}{invalid_utf8=177}?"
         },
         "LOG":{
            "text":"log",
            "detail":"设置打印日志  0 error 1 waring 2 socket 3 temp 4 info 5 event 6 loader 用法(log 0,1,2)"
         },
         "LINETO":{
            "text":"lineto",
            "detail":"跳转到目标行 用法 (lineto 299)"
         },
         "PRINT":{
            "text":"print",
            "detail":"打印当前内存中的对象"
         }
      };
      
      private var _regExp:RegExp;
      
      public function LogManager(param1:singleHelper)
      {
         super();
         initialization();
      }
      
      public static function get instance() : LogManager
      {
         if(_instance == null)
         {
            _instance = new LogManager(new singleHelper());
         }
         return _instance;
      }
      
      public function initialization() : void
      {
         _shape = new Shape();
         _shape.graphics.beginFill(0,0.5);
         _shape.graphics.drawRect(0,0,Director.instance.stage2d.stageWidth,Director.instance.stage2d.stageHeight);
         _text = new TextField();
         var _loc1_:TextFormat = new TextFormat("Arial",14,13421772);
         _loc1_.align = "left";
         _text.width = Director.instance.stage2d.stageWidth;
         _text.height = Director.instance.stage2d.stageHeight - 80;
         _text.defaultTextFormat = _loc1_;
         _text.text = "\nWelcome to use DiceGame Debuger 0.0.\nEnjoy it. Thanks.\n";
         _text.mouseEnabled = false;
         _cmdText = new TextField();
         _cmdText.defaultTextFormat = new TextFormat("Arial",14,13421772);
         _cmdText.width = Director.instance.stage2d.stageWidth;
         _cmdText.height = 24;
         _cmdText.type = "input";
         _cmdText.y = _text.height + 20;
         _cmdText.addEventListener("keyUp",__onkeyUp);
         _cmdText.border = true;
         _cmdText.borderColor = 16711680;
         _objectContainer = new BaseSprite();
         _regExp = /\\\S+.as:\d+/g;
      }
      
      protected function __onkeyUp(param1:KeyboardEvent) : void
      {
         switch(int(param1.charCode) - 13)
         {
            case 0:
               enterFunction(_cmdText.text.split(" "));
         }
      }
      
      protected function enterFunction(param1:Array) : void
      {
         var _loc5_:Function = null;
         var _loc2_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc6_:Array = param1;
         var _loc3_:String = _loc6_[0];
         _loc6_.splice(0,1);
         var _loc4_:Array = _loc6_;
         switch(_loc3_.toLocaleLowerCase())
         {
            case _cmdDetailed.HELP.text:
               _loc5_ = helpFunction;
               break;
            case _cmdDetailed.OBJECTS.text:
               _loc5_ = printObjectLen;
               break;
            case _cmdDetailed.MEMORY.text:
               _loc5_ = printMemory;
               break;
            case _cmdDetailed.OBJECTMEMORY.text:
               _loc5_ = printObjectMemory;
               break;
            case _cmdDetailed.PRINTOBJECT.text:
               _loc5_ = printObject;
               break;
            case _cmdDetailed.CLEAR.text:
               _loc5_ = clear;
               break;
            case _cmdDetailed.LOCK.text:
               _loc5_ = lock;
               break;
            case _cmdDetailed.ADDOBJECT.text:
               _loc5_ = addObject;
               break;
            case _cmdDetailed.REMOVEOBJECT.text:
               _loc5_ = removeObject;
               break;
            case _cmdDetailed.DISPOSEOBJECT.text:
               _loc5_ = disposeObject;
               break;
            case _cmdDetailed.LOG.text:
               _loc5_ = logPrint;
               break;
            case _cmdDetailed.LINETO.text:
               _loc5_ = lineTo;
               break;
            case _cmdDetailed.PRINT.text:
               _loc5_ = print;
               break;
            default:
               traceLog("你可以输{invalid_utf8=229}{invalid_utf8=133}? help 查看当前的所有命{invalid_utf8=228}{invalid_utf8=187}?");
         }
         if(_loc5_ != null)
         {
            _loc2_ = _loc5_.length;
            if(_loc4_.length >= _loc2_)
            {
               _loc5_.apply(null,_loc4_.slice(0,_loc2_));
            }
            enterFunction(_loc4_.slice(_loc2_));
         }
         _cmdText.text = "";
      }
      
      public function print() : void
      {
         traceLog("debug Print===================================================================== Time" + new Date());
         var _loc2_:Object = ObjectManager.instance.getNames();
         traceLog("\n当前内存中存在的对象================================================================\n");
         for(var _loc1_:String in _loc2_)
         {
            Director.instance.trace(0,"TEST","[" + _loc1_ + "] " + _loc2_[_loc1_]["count"] + " " + _loc2_[_loc1_]["size"]);
         }
      }
      
      private function lock() : void
      {
         _locking = !_locking;
      }
      
      private function lineTo(param1:int) : void
      {
         var _loc2_:int = param1;
         _loc2_ = _loc2_ < 0 ? 0 : (_loc2_ > _scorllLen ? _scorllLen : _loc2_);
         _text.scrollV = _loc2_;
      }
      
      private function logPrint(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = param1.split(",");
         if(_loc2_.length == 0)
         {
            return;
         }
         _printState = [];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _printState[_loc3_] = int(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      protected function removeObject() : void
      {
         _objectContainer.removeChildren();
      }
      
      protected function disposeObject() : void
      {
         var _loc1_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc4_:Object = _objectMangerInstance["objects"];
         for(var _loc2_:String in _loc4_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_[_loc2_].length)
            {
               _loc3_ = _loc4_[_loc2_][_loc5_] as DisplayObject;
               if(_loc3_.stage == null)
               {
                  _loc4_[_loc2_][_loc5_].dispose();
                  _loc5_--;
               }
               _loc5_++;
            }
         }
      }
      
      protected function addObject() : void
      {
         var _loc1_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc4_:Object = _objectMangerInstance["objects"];
         for(var _loc2_:String in _loc4_)
         {
            _loc1_ = int(_loc4_[_loc2_].length);
            _loc5_ = 0;
            while(_loc5_ < _loc1_)
            {
               _loc3_ = _loc4_[_loc2_][_loc5_] as DisplayObject;
               if(_loc3_.stage == null)
               {
                  _objectContainer.addChild(_loc3_);
               }
               _loc5_++;
            }
         }
      }
      
      protected function helpFunction() : void
      {
         var _loc1_:String = "[SYSTEM] ";
         traceLog(_loc1_);
         for each(var _loc2_:Object in _cmdDetailed)
         {
            _loc1_ = _loc2_["text"] + "  " + _loc2_["detail"];
            traceLog(_loc1_);
         }
      }
      
      protected function printObjectLen() : void
      {
         var _loc1_:String = "[SYSTEM] 当前组件的共个数{invalid_utf8=228}{invalid_utf8=184}?" + _objectMangerInstance["objectLen"];
         traceLog(_loc1_);
      }
      
      protected function printMemory() : void
      {
         var _loc1_:String = "[SYSTEM] 当前系统{invalid_utf8=230}{invalid_utf8=137}?用内存为" + System.totalMemory;
         traceLog(_loc1_);
      }
      
      protected function printObjectMemory() : void
      {
         var _loc1_:String = "[SYSTEM] 当前系统组件{invalid_utf8=230}{invalid_utf8=137}?用内存为" + _objectMangerInstance["objectMemory"] + "(new 出每个类{invalid_utf8=230}{invalid_utf8=137}?占用的内{invalid_utf8=229}{invalid_utf8=173}?.不是具体对象{invalid_utf8=230}{invalid_utf8=137}?占用的内{invalid_utf8=229}{invalid_utf8=173}?)";
         traceLog(_loc1_);
      }
      
      protected function printObject() : void
      {
         var _loc1_:int = 0;
         var _loc3_:String = "[SYSTEM] 当前具体对象 具体类内{invalid_utf8=229}{invalid_utf8=173}?(不是具体对象{invalid_utf8=230}{invalid_utf8=137}?占的内存 而是new {invalid_utf8=228}{invalid_utf8=184}?个类{invalid_utf8=230}{invalid_utf8=137}?{invalid_utf8=233}{invalid_utf8=156}?的内{invalid_utf8=229}{invalid_utf8=173}?)";
         traceLog(_loc3_);
         var _loc4_:Object = _objectMangerInstance["objects"];
         for(var _loc2_:String in _loc4_)
         {
            _loc1_ = int(_loc4_[_loc2_].length);
            _loc3_ = _loc2_ + " 个数:" + _loc1_ + " 占用类内{invalid_utf8=229}{invalid_utf8=173}?:" + _objectMangerInstance["objectsMemory"][_loc2_] * _loc1_;
            traceLog(_loc3_);
         }
      }
      
      public function show(param1:String) : void
      {
         Director.instance.addToLayer(param1,_shape);
         Director.instance.addToLayer(param1,_text);
         Director.instance.addToLayer(param1,_cmdText);
         Director.instance.addToLayer(param1,_objectContainer);
      }
      
      public function hide(param1:String) : void
      {
         Director.instance.removeToLayer(param1,_shape);
         Director.instance.removeToLayer(param1,_text);
         Director.instance.removeToLayer(param1,_cmdText);
         Director.instance.removeToLayer(param1,_objectContainer);
      }
      
      public function set showLogType(param1:int) : void
      {
         _showLogType = param1;
      }
      
      public function clear() : void
      {
         _text.text = "";
         _scorllLen = 0;
      }
      
      private function traceLog(param1:String) : void
      {
         trace(param1);
         if(_text == null)
         {
            return;
         }
         _text.appendText(param1 + "\n");
         _scorllLen = _scorllLen + 1;
         if(!_locking)
         {
            _text.scrollV = _scorllLen;
         }
      }
      
      private function printLog(param1:String) : void
      {
      }
      
      basegame_internal function writeLog(param1:int, param2:String, ... rest) : void
      {
         write(param1,param2,3,rest);
      }
      
      basegame_internal function write(param1:int, param2:String, param3:int, ... rest) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc10_:String = null;
         var _loc9_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         if(Capabilities.isDebugger)
         {
            _loc10_ = new Error().getStackTrace();
            _loc9_ = _loc10_.match(_regExp);
            if(_loc9_.length > 0)
            {
               _loc10_ = _loc9_[param3];
               _loc9_ = _loc10_.split(":");
               _loc5_ = _loc9_[0];
               _loc5_ = _loc5_.substring(_loc5_.lastIndexOf("\\") + 1);
               _loc6_ = _loc9_[1];
            }
         }
         if(!isDebug && !isWriteFile)
         {
            return;
         }
         if(_printState.indexOf(param1) == -1)
         {
            return;
         }
         switch(param1)
         {
            case 0:
               _loc8_ = "ERROR[" + param2 + "]: ";
               break;
            case 1:
               _loc8_ = "WARNING[" + param2 + "]: ";
               break;
            case 2:
               _loc8_ = "SOCKET[" + param2 + "]: ";
               break;
            case 3:
               _loc8_ = "TEMP[" + param2 + "]: ";
               break;
            case 4:
               if(modelState.length > 0)
               {
                  if(modelState.indexOf(param2) < 0)
                  {
                     break;
                  }
               }
               _loc8_ = "INFO[" + param2 + "]: ";
               break;
            case 5:
               _loc8_ = "EVENT[" + param2 + "]: ";
               break;
            case 6:
               _loc8_ = "LOADER[" + param2 + "]: ";
         }
         if(_loc8_)
         {
            _loc7_ = 0;
            while(_loc7_ < rest.length)
            {
               _loc8_ = _loc8_ + String(rest[_loc7_]) + " ";
               _loc7_++;
            }
         }
         if(!_loc8_)
         {
            return;
         }
         if(_isDebug)
         {
            if(Capabilities.isDebugger)
            {
               _loc8_ += "======= AT: [FILE:" + _loc5_ + " LINE:" + _loc6_ + "]";
            }
            traceLog(_loc8_);
         }
         if(_isWriteFile)
         {
            printLog(_loc8_);
         }
      }
      
      public function dispose() : void
      {
         if(_text)
         {
            _text = null;
         }
         if(_shape)
         {
            _shape = null;
         }
      }
      
      public function get isDebug() : Boolean
      {
         return _isDebug;
      }
      
      public function get isWriteFile() : Boolean
      {
         return _isWriteFile;
      }
      
      public function set isDebug(param1:Boolean) : void
      {
         _isDebug = param1;
      }
      
      public function get printState() : Array
      {
         return _printState;
      }
      
      public function set printState(param1:Array) : void
      {
         _printState = param1;
      }
      
      public function get objectMangerInstance() : Object
      {
         return _objectMangerInstance;
      }
      
      public function set objectMangerInstance(param1:Object) : void
      {
         _objectMangerInstance = param1;
      }
      
      public function get modelState() : Array
      {
         return _modelState;
      }
      
      public function set modelState(param1:Array) : void
      {
         _modelState = param1;
      }
   }
}

class singleHelper
{
   
   public function singleHelper()
   {
      super();
   }
}
