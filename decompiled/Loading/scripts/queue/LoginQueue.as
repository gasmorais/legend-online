package queue
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.System;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class LoginQueue
   {
      
      public var backCall:Function;
      
      public var errorCall:Function;
      
      private var _url:String;
      
      private var _variable:URLVariables;
      
      private var _timeId:int;
      
      public function LoginQueue(param1:String, param2:URLVariables)
      {
         super();
         _url = param1;
         _variable = param2;
      }
      
      public function load() : void
      {
         clearInterval(_timeId);
         _timeId = 0;
         _variable["rnd"] = Math.random();
         var _loc1_:URLRequest = new URLRequest(_url);
         _loc1_.method = "POST";
         _loc1_.data = _variable;
         var _loc2_:URLLoader = new URLLoader();
         _loc2_.addEventListener("complete",__onLoginComplete);
         _loc2_.addEventListener("ioError",__onLoginQueueError);
         _loc2_.load(_loc1_);
      }
      
      protected function __onLoginComplete(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc6_:int = 0;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         clearInterval(_timeId);
         _timeId = 0;
         var _loc4_:XML = XML(param1.target.data);
         if(_loc4_.@message)
         {
            _loc2_ = _loc4_.@message;
            if(_loc2_.indexOf("|") != -1)
            {
               _loc3_ = _loc2_.split("|");
               _loc6_ = int(_loc3_[0]);
               if(_loc6_ > 300)
               {
                  _loc6_ = 30000;
               }
               else if(_loc6_ > 200)
               {
                  _loc6_ = 20000;
               }
               else if(_loc6_ > 100)
               {
                  _loc6_ = 10000;
               }
               else
               {
                  _loc6_ = 5000;
               }
               if(int(_loc3_[1]) == -2)
               {
                  _loc5_ = -2;
                  if(errorCall != null)
                  {
                     errorCall("您当前所处列队位置：" + _loc3_[0] + "\n预计等待时间：" + (String(int(_loc5_ / 60) + 1)) + "分钟以内",1,_loc5_,int(_loc3_[0]),int(_loc3_[2]));
                  }
               }
               else
               {
                  _loc5_ = int(_loc3_[1]) / 1000;
                  if(errorCall != null)
                  {
                     errorCall("您当前所处列队位置：" + _loc3_[0] + "\n预计等待时间：" + (String(int(_loc5_ / 60) + 1)) + "分钟以内",1,int(_loc5_ / 60) + 1,int(_loc3_[0]),int(_loc3_[2]));
                  }
               }
               _timeId = setInterval(load,_loc6_);
            }
            else
            {
               _loc7_ = int(_loc4_.@userId);
               _loc8_ = _loc4_.@value;
               if(_loc7_ != 0 && _loc8_ != "false")
               {
                  if(backCall != null)
                  {
                     backCall(_loc4_);
                  }
                  backCall = null;
                  param1.target.removeEventListener("complete",__onLoginComplete);
                  param1.target.removeEventListener("ioError",__onLoginQueueError);
                  errorCall = null;
               }
               else if(errorCall != null)
               {
                  errorCall(_loc4_.@message,0);
               }
            }
         }
         else if(errorCall != null)
         {
            errorCall("error",0);
         }
         System.disposeXML(_loc4_);
         _loc4_ = null;
      }
      
      private function __onLoginQueueError(param1:IOErrorEvent) : void
      {
         throw new ErrorEvent("SELECTLIST_LOAD_ERROR",true,false,"Load selectList fail! please try again later!");
      }
   }
}

