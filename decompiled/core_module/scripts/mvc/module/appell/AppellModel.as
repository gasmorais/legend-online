package mvc.module.appell
{
   import events.AppellEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.datas.templates.CampaignBufferTemp;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   
   public class AppellModel extends EventDispatcher
   {
      
      public static const TYPE_GET:int = 0;
      
      public static const TYPE_SELF:int = 1;
      
      public static const TYPE_PVP:int = 2;
      
      public static const TYPE_PVE:int = 3;
      
      public static const TYPE_OTHER:int = 4;
      
      public static const COLORS:Array = ["0xfdff56, 0xff7d03","0xff9cf9, 0xce06ff","0xf8f8f8, 0x717171","0xffffff, 0xff3ba5","0x99ffff, 0x0099ff","0xd9ffd1, 0x0c8609","0xfdacac, 0xb30f0f","0xffffff, 0xdfb595","0xf6f7ff, 0xa2a6c0","0xfbf570, 0xdeac2e","0xfee6e3, 0xfee6e3","0xfdff6c, 0xe20000","0xfffc00, 0xff5a00"];
      
      private var _currentPage:int = 0;
      
      private var _infos:Dictionary;
      
      private var _appells:SimpleDictionary;
      
      public function AppellModel()
      {
         super();
      }
      
      public function get currentPage() : int
      {
         return _currentPage;
      }
      
      public function set currentPage(param1:int) : void
      {
         _currentPage = param1;
      }
      
      public function get infos() : Dictionary
      {
         return _infos;
      }
      
      public function set infos(param1:Dictionary) : void
      {
         _infos = param1;
      }
      
      public function get appells() : SimpleDictionary
      {
         return _appells;
      }
      
      public function set appells(param1:SimpleDictionary) : void
      {
         _appells = param1;
         dispatchEvent(new AppellEvent("APPELL_DATA_UPDATA"));
      }
      
      private function sortFun(param1:AppellInfoTemplate, param2:AppellInfoTemplate) : Number
      {
         if(param1.isGet && !param2.isGet)
         {
            return -1;
         }
         if(!param1.isGet && param2.isGet)
         {
            return 1;
         }
         return param2.Sort - param1.Sort;
      }
      
      public function getListByType(param1:int = 0) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc2_:AppellInfoTemplate in appells)
         {
            if(!(param1 != 0 && param1 != _loc2_.Type))
            {
               if(!(_loc2_.IsHide == 1 && _loc2_.isGet == false))
               {
                  _loc3_.push(_loc2_);
               }
            }
         }
         _loc3_.sort(sortFun);
         return _loc3_;
      }
      
      public function getAcquiredList() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:AppellInfoTemplate in appells)
         {
            if(_loc1_.isGet == true)
            {
               _loc2_.push(_loc1_);
            }
         }
         _loc2_.sort(sortFun);
         return _loc2_;
      }
      
      public function getCurrentList() : Array
      {
         if(currentPage == 0)
         {
            return getAcquiredList();
         }
         return getListByType(currentPage);
      }
      
      public function getAppellInfo(param1:int) : AppellInfoTemplate
      {
         if(param1 != 0)
         {
            return TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(param1);
         }
         return new AppellInfoTemplate();
      }
      
      public function needShowProgress(param1:int) : Boolean
      {
         switch(param1)
         {
            case 1:
            case 2:
            case 3:
            case 4:
            case 10:
            case 28:
            case 30:
            case 31:
            case 33:
            case 37:
            case 38:
            case 100:
            case 101:
               break;
            default:
               return false;
         }
         return true;
      }
      
      public function getPerfixStyle(param1:int) : int
      {
         switch(param1)
         {
            case 1:
               return 1;
            case 25:
               return 2;
            case 35:
               return 3;
            case 37:
               return 4;
            case 40:
               return 5;
            case 41:
               return 6;
            case 42:
               return 7;
            case 46:
               return 8;
            case 47:
               return 9;
            case 72:
               return 10;
            case 73:
               return 11;
            case 74:
               return 12;
            default:
               return 9;
         }
      }
      
      public function getAllSkillString() : String
      {
         var _loc1_:Vector.<String> = new Vector.<String>();
         for each(var _loc2_:AppellInfoTemplate in _appells)
         {
            if(_loc2_.isGet && _loc2_.Skills)
            {
               _loc1_.push(_loc2_.Skills);
            }
         }
         return _loc1_.join(",");
      }
      
      public function getAllBufferString() : String
      {
         var _loc1_:Vector.<String> = new Vector.<String>();
         for each(var _loc2_:AppellInfoTemplate in _appells)
         {
            if(_loc2_.isGet && _loc2_.Buffs)
            {
               _loc1_.push(_loc2_.Buffs);
            }
         }
         return _loc1_.join(",");
      }
      
      public function getAdditionFromSkill(... rest) : Array
      {
         var _loc6_:int = 0;
         var _loc3_:String = null;
         var _loc7_:SkillPropertyTempInfo = null;
         var _loc2_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < 16)
         {
            _loc2_[_loc6_] = 0;
            _loc6_++;
         }
         if(!isOpenAppellAddition)
         {
            return _loc2_;
         }
         if(rest.length == 0)
         {
            _loc3_ = getAllSkillString();
         }
         else
         {
            _loc3_ = rest.join(",");
         }
         if(!_loc3_)
         {
            return _loc2_;
         }
         var _loc5_:Array = _loc3_.split(",");
         for each(var _loc4_:String in _loc5_)
         {
            _loc7_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(int(_loc4_));
            if(_loc7_)
            {
               var _loc8_:int = 0;
               var _loc9_:Number = _loc2_[_loc8_] + _loc7_.Power;
               _loc2_[_loc8_] = _loc9_;
               _loc2_[1] += _loc7_.Agility;
               _loc2_[2] += _loc7_.Intellect;
               _loc2_[3] += _loc7_.Physique;
               _loc2_[4] += _loc7_.Captain;
               _loc2_[5] += _loc7_.Attack;
               _loc2_[6] += _loc7_.Defence;
               _loc2_[7] += _loc7_.MagicAttack;
               _loc2_[8] += _loc7_.MagicDefence;
               _loc2_[9] += _loc7_.ForceHit;
               _loc2_[10] += _loc7_.Penetrate;
               _loc2_[11] += _loc7_.Parry;
               _loc2_[12] += _loc7_.Live;
               _loc2_[13] += _loc7_.Conat;
            }
         }
         return _loc2_;
      }
      
      public function getAdditionFromBuffer(... rest) : Array
      {
         var _loc12_:String = null;
         var _loc13_:CampaignBufferTemp = null;
         var _loc11_:Object = null;
         var _loc10_:String = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc4_:int = 0;
         var _loc8_:Array = [];
         if(!isOpenAppellAddition)
         {
            return _loc8_;
         }
         if(rest.length == 0)
         {
            _loc12_ = getAllBufferString();
         }
         else
         {
            _loc12_ = rest.join(",");
         }
         if(!_loc12_)
         {
            return _loc8_;
         }
         var _loc15_:Dictionary = new Dictionary(true);
         var _loc3_:Array = _loc12_.split(",");
         for each(var _loc2_:String in _loc3_)
         {
            _loc13_ = TempleteManager.instance.campaignBufferTemplate.getTemplateByID(int(_loc2_));
            if(_loc13_)
            {
               _loc11_ = _loc15_[_loc13_.Description];
               if(!_loc11_)
               {
                  _loc11_ = {
                     "desc":_loc13_.Description,
                     "data":[]
                  };
                  _loc15_[_loc13_.Description] = _loc11_;
               }
               _loc11_.data.push(_loc13_);
            }
         }
         for(var _loc14_:String in _loc15_)
         {
            _loc10_ = _loc14_;
            _loc6_ = _loc15_[_loc14_].data;
            _loc7_ = StringHelper.getStringsBetweenTwoChar(_loc14_,"{","}");
            for each(var _loc9_:String in _loc7_)
            {
               _loc4_ = 0;
               for each(var _loc5_:CampaignBufferTemp in _loc6_)
               {
                  if(_loc5_.hasOwnProperty(_loc9_))
                  {
                     _loc4_ += _loc5_[_loc9_];
                  }
               }
               _loc10_ = StringHelper.replaceStr(_loc10_,"{" + _loc9_ + "}",Math.abs(_loc4_).toString());
            }
            _loc8_.push(_loc10_);
         }
         return _loc8_;
      }
      
      public function getAppellSummaryTipContent() : String
      {
         var _loc5_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = LanguageMgr.GetTranslation("appellModel.properties");
         var _loc6_:Array = _loc4_.split("|");
         var _loc7_:Array = [];
         var _loc1_:Array = getAdditionFromSkill();
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            if(_loc1_[_loc5_] != 0)
            {
               if(_loc1_[_loc5_] > 0)
               {
                  _loc3_ = "+" + _loc1_[_loc5_];
               }
               else
               {
                  _loc3_ = _loc1_[_loc5_].toString();
               }
               _loc7_.push(LanguageMgr.GetTranslation("public.font","","",12,_loc6_[_loc5_]) + LanguageMgr.GetTranslation("public.font","Arial","",12,_loc3_));
            }
            _loc5_++;
         }
         _loc1_ = getAdditionFromBuffer();
         for each(var _loc2_:String in _loc1_)
         {
            _loc7_.push(_loc2_);
         }
         return _loc7_.join("\n");
      }
      
      public function get isOpenAppellAddition() : Boolean
      {
         return PlayerManager.instance.currentPlayerModel.isOpenAppellAddition;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.army.baseHero;
      }
   }
}

