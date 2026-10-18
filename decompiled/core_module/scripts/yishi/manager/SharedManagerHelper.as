package yishi.manager
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class SharedManagerHelper
   {
      
      private static var _ins:SharedManagerHelper;
      
      private static var dateDic:Dictionary;
      
      private static var boolDic:Dictionary;
      
      private var key:String;
      
      private var callBack:Function;
      
      private var type:String;
      
      public function SharedManagerHelper()
      {
         super();
      }
      
      public static function get ins() : SharedManagerHelper
      {
         if(_ins == null)
         {
            _ins = new SharedManagerHelper();
            dateDic = new Dictionary();
            boolDic = new Dictionary();
         }
         return _ins;
      }
      
      public function isNeedAlert(param1:String) : Boolean
      {
         var _loc4_:Date = null;
         key = param1;
         var _loc6_:SharedObject = SharedObject.getLocal("7road/files");
         var _loc3_:Date = dateDic[key + SharedManager.instance.userId];
         var _loc2_:Boolean = Boolean(boolDic[key + "Bool" + SharedManager.instance.userId]);
         if(_loc6_ && _loc6_.data)
         {
            if(_loc6_.data[key + SharedManager.instance.userId] != undefined)
            {
               _loc3_ = _loc6_.data[key + SharedManager.instance.userId];
               dateDic[key + SharedManager.instance.userId] = _loc3_;
            }
            if(_loc6_.data[key + "Bool" + SharedManager.instance.userId] != undefined)
            {
               _loc2_ = Boolean(_loc6_.data[key + "Bool" + SharedManager.instance.userId]);
               boolDic[key + "Bool" + SharedManager.instance.userId] = _loc2_;
            }
         }
         var _loc5_:Boolean = true;
         if(_loc3_)
         {
            _loc4_ = new Date();
            if(_loc4_.fullYear == _loc3_.fullYear && _loc4_.month == _loc3_.month && _loc4_.date == _loc3_.date)
            {
               _loc5_ = false;
            }
         }
         return _loc5_;
      }
      
      public function needAlert(param1:String, param2:Function, param3:String, param4:String, param5:String = "2") : void
      {
         var _loc8_:Date = null;
         var _loc11_:TodayNotAlertFrame = null;
         key = param1;
         callBack = param2;
         type = param5;
         var _loc10_:SharedObject = SharedObject.getLocal("7road/files");
         var _loc7_:Date = dateDic[key + SharedManager.instance.userId];
         var _loc6_:Boolean = Boolean(boolDic[key + "Bool" + SharedManager.instance.userId]);
         if(_loc10_ && _loc10_.data)
         {
            if(_loc10_.data[key + SharedManager.instance.userId] != undefined)
            {
               _loc7_ = _loc10_.data[key + SharedManager.instance.userId];
               dateDic[key + SharedManager.instance.userId] = _loc7_;
            }
            if(_loc10_.data[key + "Bool" + SharedManager.instance.userId] != undefined)
            {
               _loc6_ = Boolean(_loc10_.data[key + "Bool" + SharedManager.instance.userId]);
               boolDic[key + "Bool" + SharedManager.instance.userId] = _loc6_;
            }
         }
         var _loc9_:Boolean = true;
         if(_loc7_)
         {
            _loc8_ = new Date();
            if(_loc8_.fullYear == _loc7_.fullYear && _loc8_.month == _loc7_.month && _loc8_.date == _loc7_.date)
            {
               _loc9_ = false;
            }
         }
         if(_loc9_)
         {
            _loc11_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert" + type);
            _loc11_.show(param4,param3,showTipResult,null,"center",2,true);
         }
         else if(type == "2")
         {
            callBack();
         }
         else if(type == "")
         {
            callBack(_loc6_);
         }
         else if(type == "remotepet")
         {
            callBack();
         }
      }
      
      private function showTipResult(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc3_:SharedObject = null;
         if(param1)
         {
            try
            {
               if(dateDic == null)
               {
                  dateDic = new Dictionary();
               }
               dateDic[key + SharedManager.instance.userId] = new Date();
               boolDic[key + "Bool" + SharedManager.instance.userId] = param2;
               _loc3_ = SharedObject.getLocal("7road/files");
               _loc3_.data[key + SharedManager.instance.userId] = dateDic[key + SharedManager.instance.userId];
               if(type == "")
               {
                  _loc3_.data[key + "Bool" + SharedManager.instance.userId] = param2;
               }
               _loc3_.flush();
            }
            catch(e:Error)
            {
            }
         }
         if(type == "2")
         {
            callBack();
         }
         else if(type == "")
         {
            callBack(param2);
         }
         else if(type == "remotepet")
         {
            callBack();
         }
      }
   }
}

