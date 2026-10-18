package mvc.module.gloryroad
{
   import com.netease.protobuf.Int64;
   import com.road.yishi.proto.gloryroad.GloryRoadConfigMsg;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.GloryroadManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.children.ChildData;
   import mvc.module.pet.PetData;
   import utils.LogicUtils;
   import yishi.datas.templates.GloryRoadBufferTemplateInfo;
   import yishi.datas.templates.GloryRoadDropTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class GloryRoadModel
   {
      
      public const MAX_COUNT:int = 15;
      
      public var userId:int;
      
      public var layer:int = 0;
      
      public var jumpLayer:int = 0;
      
      public var resetTimes:int;
      
      public var resurgenceTimes:int;
      
      public var remainHp:Int64;
      
      public var childId:int = -1;
      
      public var childPetId:int = -1;
      
      public var childRemainHp:Int64;
      
      public var score:int;
      
      public var totalScore:int;
      
      public var gloryScore:int;
      
      public var buffStar:int;
      
      public var allBuffers:Array;
      
      public var canBuyBuffers:Array;
      
      public var buyBufferTimes:int;
      
      public var hasBuyBuffers:Array;
      
      public var scoreRewards:Array;
      
      public var canGetBox:Boolean;
      
      public var boxTimes:String = "";
      
      public var difficulty:int = 0;
      
      private var _mirrorInfo:GloryRoadMirrorInfo = new GloryRoadMirrorInfo();
      
      private var _gloryRoadConfig:GloryRoadConfig = new GloryRoadConfig();
      
      private var _buffTag:int;
      
      private var _viewSate:int = 0;
      
      public var beforeEnter:int = 0;
      
      public var afterEnter:int = 0;
      
      public var showAfterJumper:Boolean = false;
      
      public var isBuffJumper:Boolean = false;
      
      public var treasureAllOpenCount:int = 0;
      
      private var _buffAtts:Dictionary;
      
      private var _shopData:Array = [];
      
      private var _socreData:SimpleDictionary;
      
      private var _buffDic:Dictionary;
      
      private var _treasureData:SimpleDictionary;
      
      public function GloryRoadModel()
      {
         super();
      }
      
      public function set buffTag(param1:int) : void
      {
         _viewSate = param1;
         _buffTag = param1;
      }
      
      public function set viewSate(param1:int) : void
      {
         _viewSate = param1;
         GloryroadManager.instance.opTag(param1);
      }
      
      public function get viewSate() : int
      {
         return _viewSate;
      }
      
      public function get leftAmount() : int
      {
         return 15 - layer;
      }
      
      public function updateBeforeLayer() : void
      {
         beforeEnter = layer;
      }
      
      private function checkState() : void
      {
         if(layer > beforeEnter)
         {
            viewSate = 1;
            beforeEnter = layer;
            if(canGetBox)
            {
               isBuffJumper = true;
            }
         }
         if(viewSate == 1)
         {
            if(getBuffListData().length == 0)
            {
               if(layer % 2 == 0)
               {
                  viewSate = 0;
               }
            }
         }
      }
      
      public function get mirrorInfo() : GloryRoadMirrorInfo
      {
         return _mirrorInfo;
      }
      
      public function set config(param1:GloryRoadConfigMsg) : void
      {
         LogicUtils.copyMsgValueToInfo(param1,_gloryRoadConfig);
      }
      
      public function getMirrorInfo() : GloryRoadMirrorInfo
      {
         return _mirrorInfo;
      }
      
      public function getConfig() : GloryRoadConfig
      {
         return _gloryRoadConfig;
      }
      
      public function updateView() : void
      {
         checkState();
      }
      
      public function get isTopLayer() : Boolean
      {
         return layer == 15;
      }
      
      public function getChildData() : ChildData
      {
         if(childId == -1)
         {
            return null;
         }
         return ChildManager.instance.model.getChildById(childId);
      }
      
      public function getChildPet() : PetData
      {
         if(childPetId == -1)
         {
            return null;
         }
         var _loc1_:Array = PlayerManager.instance.currentPlayerModel.playerInfo.petList;
         for each(var _loc2_:PetData in _loc1_)
         {
            if(_loc2_.petId == childPetId)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getBuffAtts() : Dictionary
      {
         var _loc2_:int = 0;
         var _loc3_:Dictionary = null;
         var _loc1_:int = 0;
         var _loc4_:GloryRoadBufferTemplateInfo = null;
         var _loc5_:Object = null;
         if(!_buffAtts)
         {
            _buffAtts = new Dictionary();
         }
         _loc2_ = 1;
         while(_loc2_ <= 4)
         {
            _buffAtts[_loc2_] = {
               "per":0,
               "value":0
            };
            _loc2_++;
         }
         if(allBuffers)
         {
            _loc3_ = getBuffDic();
            _loc1_ = 0;
            while(_loc1_ < allBuffers.length)
            {
               _loc4_ = _loc3_[allBuffers[_loc1_]];
               if(_loc4_ && _loc4_.isBuffShowView)
               {
                  _loc5_ = _buffAtts[_loc4_.Type];
                  _loc5_.per = _loc5_.per + _loc4_.Percent;
                  _loc5_.value += _loc4_.Value;
               }
               _loc1_++;
            }
         }
         return _buffAtts;
      }
      
      public function getGloryCoinAmount() : int
      {
         return PlayerCurrencyManager.instance.currencyInfo.gloryCoin.amount;
      }
      
      public function getDiffectyData() : Array
      {
         var _loc4_:int = 0;
         var _loc6_:Number = NaN;
         var _loc1_:Array = [];
         var _loc2_:Array = getConfig().getBaseDifficultyValues();
         var _loc5_:Array = [1,2,3];
         var _loc3_:int = layer + 1;
         _loc3_ = _loc3_ > 15 ? 15 : _loc3_;
         _loc3_ = int(_loc3_ < 1 ? 1 : _loc3_);
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = Number(_loc5_[_loc4_]);
            _loc1_[_loc4_] = [];
            _loc1_[_loc4_][0] = Number(_loc2_[_loc4_]);
            _loc1_[_loc4_][1] = 15 * _loc6_ + _loc3_ * _loc6_;
            _loc1_[_loc4_][2] = 10 * _loc6_ * _loc6_;
            _loc1_[_loc4_][3] = 5 * _loc6_;
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function getShopData() : Array
      {
         return _shopData;
      }
      
      public function getScoreListData() : Array
      {
         var _loc1_:Array = null;
         var _loc4_:UpgradeTemplateInfo = null;
         if(!_socreData)
         {
            _socreData = new SimpleDictionary();
            _loc1_ = TempleteManager.instance.getTemplatesByType(125);
            for each(_loc4_ in _loc1_)
            {
               _socreData.add(_loc4_.Grades,_loc4_);
            }
         }
         for each(var _loc2_:int in scoreRewards)
         {
            _loc4_ = _socreData[_loc2_];
            if(_loc4_)
            {
               _loc4_.ActiveObject = -1;
            }
         }
         var _loc3_:Array = _socreData.getList();
         _loc3_.sortOn(["ActiveObject","Grades"],[2,16]);
         return _loc3_;
      }
      
      private function getBuffDic() : Dictionary
      {
         if(!_buffDic)
         {
            _buffDic = TempleteManager.instance.getGloryRoadBufferTemplateCate().getTemplates();
         }
         return _buffDic;
      }
      
      public function getBuffListData() : Array
      {
         var _loc5_:GloryRoadBufferTemplateInfo = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         getBuffDic();
         var _loc1_:Array = [];
         if(canBuyBuffers)
         {
            _loc2_ = 0;
            while(_loc2_ < canBuyBuffers.length)
            {
               _loc5_ = _buffDic[canBuyBuffers[_loc2_]];
               _loc5_.isPurchased = false;
               _loc1_[_loc2_] = _loc5_;
               _loc2_++;
            }
            _loc1_.sortOn("Pos",16);
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               GloryRoadBufferTemplateInfo(_loc1_[_loc4_]).index = _loc4_;
               _loc4_++;
            }
         }
         if(hasBuyBuffers)
         {
            _loc3_ = 0;
            while(_loc3_ < hasBuyBuffers.length)
            {
               _loc5_ = _buffDic[hasBuyBuffers[_loc3_]];
               if(_loc5_)
               {
                  _loc5_.isPurchased = true;
               }
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      public function getTreasureListData() : Array
      {
         var _loc14_:GloryRoadRewarCellInfo = null;
         var _loc9_:Array = null;
         var _loc6_:Array = null;
         var _loc2_:GloryRoadRewarCellInfo = null;
         var _loc8_:int = 0;
         var _loc16_:GloryRoadDropTemplateInfo = null;
         var _loc15_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc13_:Array = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         if(!_treasureData)
         {
            _loc9_ = TempleteManager.instance.getGloryRoadDropTemplateCate().getTemplates().getList();
            _loc9_.sortOn("id",16);
            _treasureData = new SimpleDictionary();
            _loc8_ = 0;
            while(_loc8_ < _loc9_.length)
            {
               _loc16_ = _loc9_[_loc8_];
               _loc6_ = _loc16_.getPassInfo();
               if(_loc6_)
               {
                  _loc15_ = 0;
                  for each(var _loc3_:int in _loc6_)
                  {
                     _loc15_ = _loc3_ - 1;
                     if(!_treasureData[_loc3_])
                     {
                        _loc14_ = new GloryRoadRewarCellInfo();
                        _loc14_.grade = _loc3_;
                        _treasureData.add(_loc3_,_loc14_);
                     }
                     _loc2_ = _treasureData[_loc3_];
                     _loc2_.items.push(_loc16_.getItemStr());
                  }
               }
               _loc8_++;
            }
            _treasureData.getList().sortOn("grade",16);
         }
         var _loc12_:Array = boxTimes.split(",");
         _loc5_ = 0;
         while(_loc5_ < _loc12_.length)
         {
            _loc14_ = _treasureData[_loc5_ + 1];
            if(_loc14_)
            {
               _loc14_.haveOpenAmount = int(_loc12_[_loc5_]);
            }
            _loc5_++;
         }
         var _loc10_:Array = [];
         var _loc11_:int = 10;
         if(showAfterJumper)
         {
            _loc1_ = Math.abs(jumpLayer);
            _loc13_ = _treasureData.getList();
            _loc4_ = Math.abs(jumpLayer);
            _loc7_ = 0;
            while(_loc7_ < _loc13_.length)
            {
               _loc14_ = _loc13_[_loc7_];
               if(_loc14_.grade <= _loc1_)
               {
                  _loc10_.push(_loc14_);
                  _loc11_ = _loc14_.haveOpenAmount < _loc11_ ? _loc14_.haveOpenAmount : _loc11_;
               }
               _loc7_++;
            }
         }
         else
         {
            _loc14_ = _treasureData[layer];
            if(_loc14_)
            {
               _loc10_.push(_loc14_);
               _loc11_ = _loc14_.haveOpenAmount;
            }
         }
         treasureAllOpenCount = _loc11_;
         return _loc10_;
      }
      
      public function getAllResurgenceInfo() : Object
      {
         var _loc1_:String = LanguageMgr.GetTranslation("GloryroadModel.getAllResurgenceInfo.txt");
         return {
            "pay":_gloryRoadConfig.resurgencePoint,
            "txt":_loc1_ + resurgenceTimes + "/" + _gloryRoadConfig.resurgenceTimes
         };
      }
      
      public function getOneResurgencePay() : int
      {
         return _gloryRoadConfig.resurgenceChildPoint;
      }
   }
}

