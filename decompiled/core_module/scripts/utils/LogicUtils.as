package utils
{
   import com.netease.protobuf.Message;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.describeType;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.filter.UIFilter;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   
   public class LogicUtils
   {
      
      private static var _intervalTag:int = -1;
      
      private static var _filterValue:int = 5;
      
      private static var _isIncrease:Boolean = false;
      
      private static var _disFilterDic:SimpleDictionary = new SimpleDictionary();
      
      private static var _callDic:Dictionary = new Dictionary();
      
      public function LogicUtils()
      {
         super();
      }
      
      public static function inputTxtChangeHandler(param1:Event) : void
      {
         var _loc2_:TextField = param1.target as TextField;
         var _loc3_:int = parseInt(_loc2_.text);
         if(_loc3_ <= 0)
         {
            _loc2_.text = "1";
         }
         if(_loc3_ >= 10000)
         {
            _loc2_.text = "9999";
         }
      }
      
      public static function disposeDisplayCollection(param1:*, param2:Function = null) : void
      {
         var _loc4_:Boolean = false;
         if(param1)
         {
            _loc4_ = param1 is Dictionary;
            for(var _loc3_ in param1)
            {
               if(param2 != null)
               {
                  param2(param1[_loc3_]);
               }
               ObjectUtils.disposeObject(param1[_loc3_]);
               if(_loc4_)
               {
                  delete param1[_loc3_];
               }
            }
            param1.length = 0;
            param1 = null;
         }
      }
      
      public static function judgePointEnoughToShowPay(param1:int, param2:Boolean) : Boolean
      {
         var _loc3_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         var _loc4_:int = int(param2 ? _loc3_.point + _loc3_.giftToken : _loc3_.point);
         if(_loc4_ >= param1)
         {
            return true;
         }
         RechargeAlertMannager.show();
         return false;
      }
      
      public static function getBtnEnabledTip(param1:BaseButton) : Component
      {
         var _loc2_:Component = new Component();
         _loc2_.tipStyle = param1.tipStyle;
         _loc2_.tipData = param1.tipData;
         _loc2_.filters = [UIFilter.getGrayFilter()];
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc3_.draw(param1);
         var _loc4_:Bitmap = new Bitmap(_loc3_);
         _loc2_.addChild(_loc4_);
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         return _loc2_;
      }
      
      public static function copyMsgValueToInfo(param1:Message, param2:Object) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         var _loc4_:* = null;
         var _loc8_:XML = describeType(param1);
         var _loc7_:XMLList = _loc8_.child("accessor");
         for each(_loc4_ in _loc7_)
         {
            _loc3_ = _loc4_.@type;
            if(_loc3_ == "Boolean")
            {
               _loc6_ = _loc4_.@name;
               if(param1[_loc6_] == true)
               {
                  _loc5_ = _loc6_.charAt(3).toLocaleLowerCase() + _loc6_.substr(4);
                  if(param2.hasOwnProperty(_loc5_))
                  {
                     param2[_loc5_] = param1[_loc5_];
                  }
               }
            }
         }
         _loc7_ = _loc8_.child("variable");
         for each(_loc4_ in _loc7_)
         {
            _loc3_ = _loc4_.@type;
            if(_loc3_ == "Array")
            {
               _loc5_ = _loc4_.@name;
               if(param2.hasOwnProperty(_loc5_))
               {
                  param2[_loc5_] = param1[_loc5_];
               }
            }
         }
      }
      
      public static function alert(param1:String, param2:String, param3:Function, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc6_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc7_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc8_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [param3];
         SimpleAlertHelper.instance.popAlerFrame(_loc8_,param1,_loc6_,_loc7_,true,param4,param5,2,param2,0,"",null,"SimpleAlert");
      }
      
      public static function addTweenFilter(param1:DisplayObject, param2:int = 12) : void
      {
         if(_intervalTag == -1)
         {
            _intervalTag = setInterval(changeFilter,50,param2);
         }
         _disFilterDic.add(param1,param1);
         changeFilter(param2);
      }
      
      public static function removeTweenFilter(param1:DisplayObject) : void
      {
         if(_disFilterDic[param1])
         {
            _disFilterDic.del(param1);
            param1.filters = null;
            if(_disFilterDic.getList().length == 0)
            {
               clearInterval(_intervalTag);
               _intervalTag = -1;
            }
         }
      }
      
      private static function changeFilter(param1:int) : void
      {
         if(_isIncrease)
         {
            _filterValue += 1;
            if(_filterValue >= param1)
            {
               _isIncrease = false;
            }
         }
         else
         {
            _filterValue -= 1;
            if(_filterValue <= 2)
            {
               _isIncrease = true;
            }
         }
         for each(var _loc2_:DisplayObject in _disFilterDic)
         {
            _loc2_.filters = [UIFilter.getGlowFilter(16776960,_filterValue,_filterValue)];
         }
      }
      
      public static function addToRender(param1:DisplayObject, param2:Function, param3:Array = null) : void
      {
         if(_callDic[param1])
         {
            return;
         }
         _callDic[param1] = {
            "fun":param2,
            "param":param3
         };
         if(param1.stage)
         {
            if(!param1.hasEventListener("render"))
            {
               param1.addEventListener("render",__render);
               param1.stage.invalidate();
            }
         }
         else if(!param1.hasEventListener("addedToStage"))
         {
            param1.addEventListener("addedToStage",__addToStageHandler);
         }
      }
      
      private static function __addToStageHandler(param1:Event) : void
      {
         param1.target.removeEventListener("addedToStage",__addToStageHandler);
         __render(param1);
      }
      
      private static function __render(param1:Event) : void
      {
         if(param1.target.hasEventListener("render"))
         {
            param1.target.removeEventListener("render",__render);
         }
         var _loc2_:Object = _callDic[param1.target];
         if(_loc2_)
         {
            if(_loc2_.param)
            {
               _loc2_.fun(_loc2_.param);
            }
            else
            {
               _loc2_.fun();
            }
            delete _callDic[param1.target];
         }
      }
      
      public static function configPartTime(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc6_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc7_:Array = [];
         var _loc2_:Date = new Date(playerModel.sysCurtime.fullYear,playerModel.sysCurtime.month,playerModel.sysCurtime.day);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc6_ = [];
            _loc4_ = param1[_loc3_].split(",");
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc2_.hours = int(_loc4_[_loc5_].split(":")[0]);
               _loc2_.minutes = int(_loc4_[_loc5_].split(":")[1]);
               _loc6_.push(_loc2_.time / 1000);
               _loc5_++;
            }
            _loc7_.push(_loc6_);
            _loc3_++;
         }
         _loc7_.sort(sortByStartTime);
         return _loc7_;
      }
      
      private static function sortByStartTime(param1:Array, param2:Array) : int
      {
         var _loc6_:Number = Number(param1[0]);
         var _loc5_:Number = Number(param2[0]);
         var _loc3_:Number = Number(param1[1]);
         var _loc4_:Number = Number(param2[1]);
         if(_loc6_ < _loc5_)
         {
            return -1;
         }
         if(_loc6_ > _loc5_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 1;
      }
      
      private static function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

