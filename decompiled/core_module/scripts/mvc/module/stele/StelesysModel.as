package mvc.module.stele
{
   import yishi.datas.templates.StelaPropertyTemplateInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class StelesysModel
   {
      
      public var operPos:int;
      
      public var lockMainTip:Boolean;
      
      private var _infoDic:SimpleDictionary;
      
      private var _metralDic:SimpleDictionary;
      
      private var _currChoose:StelesysInfo;
      
      private var _currSortAttName:String;
      
      private var _currSwitchStr:String = "1|1|1|1|1|1,1|1|1|1|1|1";
      
      private var _currIntensifyStr:String = "1|1|1|1|1|1,1|1|1|1|1|1";
      
      private var _backStr:String = "1|1|1|1|1|1,1|1|1|1|1|1";
      
      private var _currCampareName:String;
      
      private var _currIntensifyInfo:StelesysInfo;
      
      private var _currIntensifyNeedExp:int;
      
      public var currIntensifyBagList:Array;
      
      public var currInstensifyPreExp:int;
      
      public var currAdvanceInfo:StelesysInfo;
      
      public function StelesysModel()
      {
         super();
         _infoDic = new SimpleDictionary();
         _metralDic = new SimpleDictionary();
      }
      
      public function get equipList() : Array
      {
         var _loc2_:Array = _infoDic.getList();
         var _loc1_:Array = [];
         for each(var _loc3_:StelesysInfo in _loc2_)
         {
            if(_loc3_.isExist && _loc3_.isOnEquip)
            {
               _loc1_.push(_loc3_);
            }
         }
         _loc1_.sortOn("pos",16);
         return _loc1_;
      }
      
      public function get allStelaList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = _infoDic.getList();
         for each(var _loc3_:StelesysInfo in _loc2_)
         {
            if(_loc3_.isExist)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function get noUpStelaList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = _infoDic.getList();
         for each(var _loc3_:StelesysInfo in _loc2_)
         {
            if(!(!_loc3_.isExist || _loc3_.isOnEquip))
            {
               _loc3_.isChoose = false;
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function get backStelaList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = _infoDic.getList();
         for each(var _loc3_:StelesysInfo in _loc2_)
         {
            if(_loc3_.isExist && _loc3_.totalExp > 0)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getSomeStepAndId(param1:StelesysInfo) : Array
      {
         var _loc5_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         if(param1.nextStepTempInfo)
         {
            _loc5_ = _infoDic.getList();
            _loc3_ = param1.nextStepTempInfo.CostItem;
            _loc4_ = param1.nextStepTempInfo.CostItemStep;
            for each(var _loc6_:StelesysInfo in _loc5_)
            {
               if(_loc6_.isExist && _loc6_.id != param1.id && _loc6_.step == _loc4_ && _loc6_.templateId == _loc3_)
               {
                  _loc2_.push(_loc6_);
               }
            }
         }
         return _loc2_;
      }
      
      public function fliterExsit(param1:Array) : void
      {
         var _loc3_:StelesysInfo = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            if(_loc3_ && !_loc3_.isExist)
            {
               param1.splice(_loc2_,1);
               _loc2_--;
            }
            _loc2_++;
         }
      }
      
      public function get metrialStelaList() : Array
      {
         var _loc5_:StelesysInfo = null;
         var _loc3_:int = 0;
         var _loc4_:Array = _metralDic.getList();
         var _loc1_:Array = [];
         _loc4_.sortOn("templateId",16);
         var _loc2_:int = int(_loc4_ ? _loc4_.length : 0);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = _loc4_[_loc3_];
            if(_loc5_.exp > 0)
            {
               _loc1_.push(_loc5_);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function get currChoose() : StelesysInfo
      {
         return _currChoose;
      }
      
      public function set currChoose(param1:StelesysInfo) : void
      {
         if(_currChoose == param1)
         {
            return;
         }
         _currChoose = param1;
         if(_currChoose)
         {
            NotificationManager.instance.sendNotification("STELE_SYS_CHOOSE",_currChoose);
         }
      }
      
      public function set currSwitchStr(param1:String) : void
      {
         if(_currSwitchStr == param1)
         {
            return;
         }
         _currSwitchStr = param1;
         NotificationManager.instance.sendNotification("STELE_SYS_SWITCH");
      }
      
      public function get currSwitchStr() : String
      {
         return _currSwitchStr;
      }
      
      public function changeSwitchStr(param1:String) : void
      {
         _currSwitchStr = param1;
      }
      
      public function set currIntensifyStr(param1:String) : void
      {
         if(_currIntensifyStr == param1)
         {
            return;
         }
         _currIntensifyStr = param1;
         NotificationManager.instance.sendNotification("STELE_SYS_SWITCH");
      }
      
      public function changeIntensifyStr(param1:String) : void
      {
         _currIntensifyStr = param1;
      }
      
      public function get currIntensifyStr() : String
      {
         return _currIntensifyStr;
      }
      
      public function set backStr(param1:String) : void
      {
         if(_backStr == param1)
         {
            return;
         }
         _backStr = param1;
         NotificationManager.instance.sendNotification("STELE_SYS_SWITCH");
      }
      
      public function get backStr() : String
      {
         return _backStr;
      }
      
      public function refreshBackStr(param1:String) : void
      {
         _backStr = param1;
      }
      
      public function doChoose(param1:Array, param2:Array) : void
      {
         var _loc5_:String = null;
         var _loc3_:Array = [];
         loop0:
         for each(var _loc6_:StelesysInfo in param1)
         {
            _loc6_.isChoose = false;
            var _loc8_:int = 0;
            var _loc7_:Array = param2;
            do
            {
               for each(var _loc4_:Array in _loc7_)
               {
                  _loc5_ = _loc4_[0];
               }
               continue loop0;
            }
            while(_loc6_[_loc5_] != _loc4_[1]);
            _loc6_.isChoose = true;
         }
      }
      
      public function doSwitch(param1:Array, param2:Array, param3:Array) : Array
      {
         var _loc7_:Boolean = false;
         var _loc10_:String = null;
         var _loc11_:* = null;
         var _loc4_:Array = [];
         var _loc9_:int = int(param2.length);
         var _loc8_:int = int(param3.length);
         if(!(_loc9_ == 0 || _loc8_ == 0))
         {
            if(_loc9_ != 0 && _loc8_ != 0)
            {
               for each(_loc11_ in param1)
               {
                  if(_loc11_.isExist)
                  {
                     _loc7_ = false;
                     for each(var _loc5_:Array in param2)
                     {
                        _loc10_ = _loc5_[0];
                        if(_loc11_[_loc10_] == _loc5_[1])
                        {
                           for each(var _loc6_:Array in param3)
                           {
                              _loc10_ = _loc6_[0];
                              if(_loc11_[_loc10_] == _loc6_[1])
                              {
                                 _loc7_ = true;
                                 break;
                              }
                           }
                           if(_loc7_)
                           {
                              break;
                           }
                        }
                     }
                     if(_loc7_)
                     {
                        _loc4_.push(_loc11_);
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function doSort(param1:Array, param2:Boolean = false) : void
      {
         var _loc6_:StelesysInfo = null;
         var _loc4_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc5_:Array = [0x10 | 2,0x10 | 2,0x10 | 2];
         if(param2)
         {
            _loc5_ = [16,16,16];
         }
         param1.sortOn(["star","step","level"],_loc5_);
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = param1[_loc4_];
            if(_loc6_ && _loc6_.isOnEquip)
            {
               _loc3_.push(_loc6_);
               param1.splice(_loc4_,1);
               _loc4_--;
            }
            _loc4_++;
         }
         while(_loc3_.length > 0)
         {
            param1.unshift(_loc3_.pop());
         }
      }
      
      private function sortUp(param1:StelesysInfo, param2:StelesysInfo) : int
      {
         var _loc3_:int = param1.stelaAttInfo[_currCampareName] + param1.skillAttInfo[_currCampareName];
         var _loc4_:int = param2.stelaAttInfo[_currCampareName] + param2.skillAttInfo[_currCampareName];
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ == _loc4_)
         {
            return 0;
         }
         return -1;
      }
      
      private function sortDown(param1:StelesysInfo, param2:StelesysInfo) : int
      {
         var _loc3_:int = param1.stelaAttInfo[_currCampareName] + param1.skillAttInfo[_currCampareName];
         var _loc4_:int = param2.stelaAttInfo[_currCampareName] + param2.skillAttInfo[_currCampareName];
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ == _loc4_)
         {
            return 0;
         }
         return 1;
      }
      
      public function get infoDic() : SimpleDictionary
      {
         return _infoDic;
      }
      
      public function get metralDic() : SimpleDictionary
      {
         return _metralDic;
      }
      
      public function get currIntensifyInfo() : StelesysInfo
      {
         return _currIntensifyInfo;
      }
      
      public function set currIntensifyInfo(param1:StelesysInfo) : void
      {
         var _loc3_:StelaPropertyTemplateInfo = null;
         var _loc2_:int = 0;
         _currIntensifyInfo = param1;
         if(_currIntensifyInfo)
         {
            _loc3_ = TempleteManager.instance.stelaPropertyTempCate.getTemplateById(_currIntensifyInfo.templateId,_currIntensifyInfo.stepTempInfo.StrengthLimit);
            _loc2_ = _loc3_.Exp - _currIntensifyInfo.totalExp;
            _currIntensifyNeedExp = _loc2_;
         }
         else
         {
            _currIntensifyNeedExp = 0;
         }
      }
      
      public function get currIntensifyNeedExp() : int
      {
         return _currIntensifyNeedExp;
      }
      
      public function intensifyCheckChoose() : Boolean
      {
         var _loc5_:StelesysInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Array = this.metrialStelaList;
         _loc2_ = int(_loc1_ ? _loc1_.length : 0);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = _loc1_[_loc3_];
            if(_loc5_)
            {
               _loc4_ += _loc5_.tempUse * _loc5_.tempInfo.Exp;
               if(_loc4_ >= currIntensifyNeedExp)
               {
                  currInstensifyPreExp = _loc4_;
                  return false;
               }
            }
            _loc3_++;
         }
         _loc2_ = int(currIntensifyBagList ? currIntensifyBagList.length : 0);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = currIntensifyBagList[_loc3_];
            if(_loc5_.isChoose && _loc5_.isExist)
            {
               _loc4_ += _loc5_.totalExp + _loc5_.tempInfo.Exp;
               if(_loc4_ >= currIntensifyNeedExp)
               {
                  currInstensifyPreExp = _loc4_;
                  return false;
               }
            }
            _loc3_++;
         }
         currInstensifyPreExp = _loc4_;
         return true;
      }
      
      public function autoIntensifyChoose() : void
      {
         var _loc6_:StelesysInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         for each(_loc6_ in currIntensifyBagList)
         {
            if(_loc6_.isChoose && _loc6_.isExist)
            {
               _loc4_ += _loc6_.totalExp + _loc6_.tempInfo.Exp;
               if(_loc4_ >= currIntensifyNeedExp)
               {
                  currInstensifyPreExp = _loc4_;
                  return;
               }
            }
         }
         var _loc1_:Array = this.metrialStelaList;
         _loc2_ = int(_loc1_ ? _loc1_.length : 0);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = _loc1_[_loc3_];
            if(_loc6_)
            {
               _loc5_ = 1;
               while(_loc5_ <= _loc6_.exp)
               {
                  _loc4_ += _loc6_.tempInfo.Exp;
                  if(_loc4_ >= currIntensifyNeedExp)
                  {
                     currInstensifyPreExp = _loc4_;
                     _loc6_.tempUse = _loc5_;
                     return;
                  }
                  _loc5_++;
               }
               _loc6_.tempUse = _loc6_.exp;
            }
            _loc3_++;
         }
         _loc2_ = int(currIntensifyBagList ? currIntensifyBagList.length : 0);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = currIntensifyBagList[_loc3_];
            if(_loc6_.isExist && !_loc6_.isChoose)
            {
               _loc4_ += _loc6_.totalExp + _loc6_.tempInfo.Exp;
               if(_loc4_ >= currIntensifyNeedExp)
               {
                  currInstensifyPreExp = _loc4_;
                  _loc6_.isChoose = true;
                  return;
               }
               _loc6_.isChoose = true;
            }
            _loc3_++;
         }
         currInstensifyPreExp = _loc4_;
      }
      
      public function get instensifyChooseNum() : int
      {
         var _loc4_:StelesysInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc1_ = int(currIntensifyBagList ? currIntensifyBagList.length : 0);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc4_ = currIntensifyBagList[_loc2_];
            if(_loc4_.isExist && _loc4_.isChoose)
            {
               _loc3_++;
            }
            _loc2_++;
         }
         return _loc3_;
      }
   }
}

