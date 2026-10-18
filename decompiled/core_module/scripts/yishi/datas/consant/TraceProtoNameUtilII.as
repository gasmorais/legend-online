package yishi.datas.consant
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.utils.StringUtils;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class TraceProtoNameUtilII
   {
      
      private static var _instance:TraceProtoNameUtilII;
      
      private var acceptLoader:URLLoader;
      
      private var accpetDic:Dictionary;
      
      private var sendLoader:URLLoader;
      
      private var sendDic:Dictionary;
      
      public function TraceProtoNameUtilII()
      {
         super();
         init();
      }
      
      public static function get Instance() : TraceProtoNameUtilII
      {
         if(_instance == null)
         {
            _instance = new TraceProtoNameUtilII();
         }
         return _instance;
      }
      
      private function init() : void
      {
         if(DisplayLoader.isDebug)
         {
            acceptLoader = new URLLoader();
            sendLoader = new URLLoader();
            configureListeners(acceptLoader);
            configureListeners(sendLoader);
            acceptLoader.load(new URLRequest("../../YiShi/src/yishi/datas/consant/AcceptProtocolType.as"));
            sendLoader.load(new URLRequest("../../YiShi/src/yishi/datas/consant/ProtocolType.as"));
         }
      }
      
      public function getAcceptProtoName(param1:String) : String
      {
         if(accpetDic == null)
         {
            return "null";
         }
         return accpetDic[param1] + "";
      }
      
      public function getSendProtoName(param1:String) : String
      {
         if(sendDic == null)
         {
            return "null";
         }
         return sendDic[param1] + "";
      }
      
      private function configureListeners(param1:URLLoader) : void
      {
         param1.addEventListener("complete",completeHandler);
      }
      
      private function findLine(param1:String, param2:String, param3:Array) : int
      {
         var _loc6_:int = 0;
         var _loc5_:int = param1.indexOf(param2);
         var _loc4_:int = int(param3.length);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            if(param3[_loc6_] >= _loc5_)
            {
               return _loc6_;
            }
            _loc6_++;
         }
         return -1;
      }
      
      private function findLine2(param1:String, param2:String, param3:Array, param4:Array) : int
      {
         var _loc8_:int = 0;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc5_:int = param1.indexOf(param2);
         var _loc9_:int = int(param3.length);
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            if(param3[_loc7_] >= _loc5_)
            {
               _loc8_ = _loc7_ + 1;
               while(_loc8_ < _loc9_ - 1)
               {
                  _loc6_ = StringUtils.trimLeft(param4[_loc8_]);
                  if(_loc6_.indexOf("public") == 0)
                  {
                     return _loc8_;
                  }
                  _loc8_++;
               }
               break;
            }
            _loc7_++;
         }
         return -1;
      }
      
      private function completeHandler(param1:Event) : void
      {
         var _loc21_:Dictionary = null;
         var _loc19_:String = null;
         var _loc5_:int = 0;
         var _loc20_:String = null;
         var _loc15_:int = 0;
         var _loc9_:int = 0;
         var _loc18_:Array = null;
         var _loc11_:Number = getTimer();
         var _loc4_:URLLoader = param1.currentTarget as URLLoader;
         _loc4_.removeEventListener("complete",completeHandler);
         if(_loc4_ == acceptLoader)
         {
            accpetDic = new Dictionary();
            _loc21_ = accpetDic;
         }
         else
         {
            sendDic = new Dictionary();
            _loc21_ = sendDic;
         }
         var _loc7_:String = _loc4_.data;
         var _loc13_:RegExp = /(?<!:)\/\/.*|\/\*(\s|.)*?\*\//g;
         var _loc2_:Array = _loc7_.match(_loc13_);
         var _loc17_:Array = _loc7_.split("\n");
         var _loc12_:int = int(_loc17_.length);
         var _loc14_:Array = [];
         var _loc3_:Number = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc12_)
         {
            _loc19_ = _loc17_[_loc5_];
            _loc14_[_loc5_] = _loc7_.indexOf(_loc19_) + _loc19_.length;
            _loc5_++;
         }
         var _loc6_:RegExp = /0x[0-9a-zA-Z]*/;
         var _loc8_:RegExp = /[\r\n\t\s]+/gi;
         var _loc10_:String = "";
         for each(var _loc16_:String in _loc2_)
         {
            _loc15_ = _loc7_.indexOf(_loc16_);
            _loc9_ = -1;
            if(_loc16_.indexOf("/*") == 0)
            {
               _loc9_ = findLine2(_loc7_,_loc16_,_loc14_,_loc17_);
            }
            else
            {
               _loc9_ = findLine(_loc7_,_loc16_,_loc14_);
            }
            if(_loc9_ != -1)
            {
               _loc19_ = _loc17_[_loc9_];
               _loc18_ = _loc19_.match(_loc6_);
               if(_loc18_ != null && _loc18_.length > 0)
               {
                  _loc20_ = _loc18_[0];
                  _loc10_ = _loc16_.replace(_loc8_," ");
                  _loc21_[_loc20_.toLocaleLowerCase()] = _loc10_;
               }
            }
         }
         trace("协议分析运行时间:",getTimer() - _loc11_);
      }
   }
}

