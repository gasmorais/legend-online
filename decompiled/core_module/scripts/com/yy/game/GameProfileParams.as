package com.yy.game
{
   import flash.net.URLVariables;
   
   public class GameProfileParams
   {
      
      private var _fightPower:int = -1;
      
      private var _sex:String;
      
      private var _job:String;
      
      private var _partner:String;
      
      private var _equip:String;
      
      private var _iversion:String;
      
      private var _updateVersion:String;
      
      private var _runResource:String;
      
      private var _referrer:String;
      
      public function GameProfileParams(param1:Object = null)
      {
         var _loc3_:Object = null;
         var _loc2_:String = null;
         super();
         if(param1)
         {
            _loc3_ = {
               "equip":"equip",
               "fight_cap":"fightPower",
               "ive":"iversion",
               "job":"job",
               "partner":"partner",
               "ref":"referrer",
               "rso":"runResource",
               "sex":"sex",
               "uve":"updateVersion"
            };
            for(var _loc4_:String in param1)
            {
               _loc2_ = _loc3_[_loc4_];
               this[_loc2_] = param1[_loc4_];
            }
         }
      }
      
      public function get fightPower() : int
      {
         return _fightPower;
      }
      
      public function set fightPower(param1:int) : void
      {
         _fightPower = param1;
      }
      
      public function get sex() : String
      {
         return _sex;
      }
      
      public function set sex(param1:String) : void
      {
         if(param1 != "m" && param1 != "f")
         {
            throw new ArgumentError("性别必须是Gender类的常量值");
         }
         _sex = param1;
      }
      
      public function get job() : String
      {
         return _job;
      }
      
      public function set job(param1:String) : void
      {
         if(param1 == null || param1.length <= 0)
         {
            throw new ArgumentError("job参数不能是null或空字符串");
         }
         _job = param1;
      }
      
      public function get partner() : String
      {
         return _partner;
      }
      
      public function set partner(param1:String) : void
      {
         if(param1 == null || param1.length <= 0)
         {
            throw new ArgumentError("partner参数不能是null或空字符串");
         }
         _partner = param1;
      }
      
      public function get equip() : String
      {
         return _equip;
      }
      
      public function set equip(param1:String) : void
      {
         if(param1 == null || param1.length <= 0)
         {
            throw new ArgumentError("equip参数不能是null或空字符串");
         }
         _equip = param1;
      }
      
      public function get iversion() : String
      {
         return _iversion;
      }
      
      public function set iversion(param1:String) : void
      {
         if(param1 == null || param1.length <= 0)
         {
            throw new ArgumentError("iversion参数不能是null或空字符串");
         }
         _iversion = param1;
      }
      
      public function get updateVersion() : String
      {
         if(_updateVersion == null)
         {
            return _iversion;
         }
         return _updateVersion;
      }
      
      public function set updateVersion(param1:String) : void
      {
         if(param1 == null || param1.length <= 0)
         {
            throw new ArgumentError("updateVersion参数不能是null或空字符串");
         }
         _updateVersion = param1;
      }
      
      public function get runResource() : String
      {
         return _runResource;
      }
      
      public function set runResource(param1:String) : void
      {
         if(param1 == null || param1.length <= 0)
         {
            throw new ArgumentError("runResource参数不能是null或空字符串");
         }
         _runResource = param1;
      }
      
      public function get referrer() : String
      {
         return _referrer;
      }
      
      public function set referrer(param1:String) : void
      {
         if(param1 == null || param1.length <= 0)
         {
            throw new ArgumentError("referrer参数不能是null或空字符串");
         }
         _referrer = param1;
      }
      
      internal function setVariable(param1:URLVariables) : void
      {
         if(_iversion)
         {
            param1.ive = _iversion;
         }
         if(_updateVersion)
         {
            param1.uve = _updateVersion;
         }
         if(_runResource)
         {
            param1.rso = _runResource;
         }
         if(_referrer)
         {
            param1.ref = _referrer;
         }
      }
      
      private function getVal(param1:String, param2:Object) : String
      {
         if(param2.hasOwnProperty(param1))
         {
            return param2[param1];
         }
         return null;
      }
   }
}

