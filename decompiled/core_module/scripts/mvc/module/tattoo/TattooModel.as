package mvc.module.tattoo
{
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   
   public class TattooModel
   {
      
      public static const NEED_DYE_NUM_ONCE:int = 100;
      
      public var currHoleIndex:int;
      
      public var holes:Array;
      
      public var missionType:int = 0;
      
      public var lastOpType:int = 0;
      
      public var holeInfoIIs:Array;
      
      private var _selectedNewHoleInfo:TattooHoleInfoII;
      
      private var _primaryTattooAddRegion:String = "";
      
      private var _seniorTattooAddRegion:String = "";
      
      private var _primaryTattooReduceRegion:String = "";
      
      private var _seniorTattooReduceRegion:String = "";
      
      public var tattooDyeTempId:int = 208101;
      
      public var seniorTattooDyeTempId:int = 208102;
      
      public function TattooModel()
      {
         super();
         initData();
      }
      
      private function initData() : void
      {
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Hight_Tattoo_Proterty_Gegion");
         if(_loc1_ && _loc1_.ConfigValue)
         {
            _seniorTattooAddRegion = _loc1_.ConfigValue;
         }
      }
      
      public function calculateAddProperty() : Array
      {
         var _loc3_:int = 0;
         var _loc7_:TattooHole = null;
         var _loc10_:* = null;
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:Array = [0,0,0,0,0];
         _loc3_ = 0;
         while(_loc3_ < holes.length)
         {
            switch((_loc7_ = holes[_loc3_] as TattooHole).oldAddProperty)
            {
               case 0:
                  var _loc17_:* = 0;
                  var _loc18_:* = _loc5_[_loc17_] + _loc7_.oldAddingValue;
                  _loc5_[_loc17_] = _loc18_;
                  break;
               case 1:
                  _loc18_ = 1;
                  _loc17_ = _loc5_[_loc18_] + _loc7_.oldAddingValue;
                  _loc5_[_loc18_] = _loc17_;
                  break;
               case 2:
                  _loc17_ = 2;
                  _loc18_ = _loc5_[_loc17_] + _loc7_.oldAddingValue;
                  _loc5_[_loc17_] = _loc18_;
                  break;
               case 3:
                  _loc18_ = 4;
                  _loc17_ = _loc5_[_loc18_] + _loc7_.oldAddingValue;
                  _loc5_[_loc18_] = _loc17_;
                  break;
               case 5:
                  _loc17_ = 3;
                  _loc18_ = _loc5_[_loc17_] + _loc7_.oldAddingValue;
                  _loc5_[_loc17_] = _loc18_;
            }
            switch(_loc7_.oldReduceProperty)
            {
               case 0:
                  _loc18_ = 0;
                  _loc17_ = _loc5_[_loc18_] + _loc7_.oldReduceValue;
                  _loc5_[_loc18_] = _loc17_;
                  break;
               case 1:
                  _loc17_ = 1;
                  _loc18_ = _loc5_[_loc17_] + _loc7_.oldReduceValue;
                  _loc5_[_loc17_] = _loc18_;
                  break;
               case 2:
                  _loc18_ = 2;
                  _loc17_ = _loc5_[_loc18_] + _loc7_.oldReduceValue;
                  _loc5_[_loc18_] = _loc17_;
                  break;
               case 3:
                  _loc17_ = 4;
                  _loc18_ = _loc5_[_loc17_] + _loc7_.oldReduceValue;
                  _loc5_[_loc17_] = _loc18_;
                  break;
               case 5:
                  _loc18_ = 3;
                  _loc17_ = _loc5_[_loc18_] + _loc7_.oldReduceValue;
                  _loc5_[_loc18_] = _loc17_;
            }
            _loc3_++;
         }
         var _loc6_:Boolean = true;
         var _loc11_:Array = _loc6_ ? this.holeInfoIIs : _loc10_.tattooPrintHoles;
         var _loc12_:String = "";
         if(this.getImprintTotalCountByProperity(0,_loc11_) > 0)
         {
            _loc14_ = this.getImprintTotalCountByProperity(0,_loc11_) * _loc5_[0] / 100;
            _loc5_[0] += _loc14_;
         }
         var _loc13_:String = "";
         if(this.getImprintTotalCountByProperity(1,_loc11_) > 0)
         {
            _loc8_ = this.getImprintTotalCountByProperity(1,_loc11_) * _loc5_[1] / 100;
            _loc5_[1] += _loc8_;
         }
         var _loc1_:String = "";
         if(this.getImprintTotalCountByProperity(2,_loc11_) > 0)
         {
            _loc15_ = this.getImprintTotalCountByProperity(2,_loc11_) * _loc5_[2] / 100;
            _loc5_[2] += _loc15_;
         }
         var _loc4_:String = "";
         if(this.getImprintTotalCountByProperity(3,_loc11_) > 0)
         {
            _loc16_ = this.getImprintTotalCountByProperity(3,_loc11_) * _loc5_[4] / 100;
            _loc5_[4] += _loc16_;
         }
         var _loc2_:String = "";
         if(this.getImprintTotalCountByProperity(5,_loc11_) > 0)
         {
            _loc9_ = this.getImprintTotalCountByProperity(5,_loc11_) * _loc5_[3] / 100;
            _loc5_[3] += _loc9_;
         }
         return _loc5_;
      }
      
      public function getPrimaryTattooMaxAddValue() : int
      {
         var _loc4_:ConfigInfosTempInfo = null;
         if(_primaryTattooAddRegion == "")
         {
            _loc4_ = TempleteManager.instance.getConfigInfoByConfigName("Low_Tattoo_Proterty_Gegion");
            if(_loc4_ && _loc4_.ConfigValue)
            {
               _primaryTattooAddRegion = _loc4_.ConfigValue;
            }
         }
         if(!_primaryTattooAddRegion || _primaryTattooAddRegion == "")
         {
            return 2000;
         }
         var _loc1_:Array = _primaryTattooAddRegion.split(",");
         var _loc2_:int = parseInt(_loc1_[0]);
         return int(parseInt(_loc1_[1]));
      }
      
      public function getSeniorTattooMaxAddValue() : int
      {
         var _loc4_:ConfigInfosTempInfo = null;
         if(_seniorTattooAddRegion == "")
         {
            _loc4_ = TempleteManager.instance.getConfigInfoByConfigName("Hight_Tattoo_Proterty_Gegion");
            if(_loc4_ && _loc4_.ConfigValue)
            {
               _seniorTattooAddRegion = _loc4_.ConfigValue;
            }
         }
         if(!_seniorTattooAddRegion || _seniorTattooAddRegion == "")
         {
            return 5000;
         }
         var _loc1_:Array = _seniorTattooAddRegion.split(",");
         var _loc2_:int = parseInt(_loc1_[0]);
         return int(parseInt(_loc1_[1]));
      }
      
      public function getTattooHoleInfoIIById(param1:int) : TattooHoleInfoII
      {
         for each(var _loc2_:TattooHoleInfoII in holeInfoIIs)
         {
            if(_loc2_.holeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get selectedNewHoleInfo() : TattooHoleInfoII
      {
         return _selectedNewHoleInfo;
      }
      
      public function set selectedNewHoleInfo(param1:TattooHoleInfoII) : void
      {
         if(_selectedNewHoleInfo == param1)
         {
            return;
         }
         _selectedNewHoleInfo = param1;
         MsgMan.notifyObserver("TATTOO_NEWHOLE_SELECT");
      }
      
      public function getHasImprintCount(param1:Array) : int
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return _loc2_;
         }
         for each(var _loc3_:TattooHoleInfoII in param1)
         {
            if(_loc3_.property > -1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function getImprintTotalCountByProperity(param1:int, param2:Array) : int
      {
         var _loc4_:UpgradeTemplateInfo = null;
         var _loc3_:int = 0;
         if(!param2)
         {
            return _loc3_;
         }
         for each(var _loc5_:TattooHoleInfoII in param2)
         {
            if(_loc5_.property == param1)
            {
               _loc4_ = TempleteManager.instance.getTemplateByLevelAndType(_loc5_.level,119);
               if(_loc4_)
               {
                  if(_loc4_.Data > 0)
                  {
                     _loc3_ += _loc4_.Data;
                  }
               }
            }
         }
         return _loc3_;
      }
   }
}

