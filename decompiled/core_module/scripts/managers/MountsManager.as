package managers
{
   import com.road.yishi.proto.campaign.AvatarInfoMsg;
   import com.road.yishi.proto.campaign.MountAvatarMsg;
   import com.road.yishi.proto.campaign.MountEditMsg;
   import com.road.yishi.proto.campaign.MountInfoMsg;
   import com.road.yishi.proto.campaign.MountKingInfoMsg;
   import com.road.yishi.proto.campaign.MountKingListMsg;
   import com.road.yishi.proto.campaign.MountShopItemMsg;
   import com.road.yishi.proto.campaign.MountShopMsg;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.mounts.MountInfo;
   import mvc.module.mounts.MountKingInfo;
   import mvc.module.mounts.MountRefiningSoulInfo;
   import mvc.module.mounts.MountShopInfo;
   import mvc.module.mounts.PropertyInfo;
   import mvc.module.mounts.WildSoulCollection;
   import mvc.module.mounts.WildSoulInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.comm.ByteSocket;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class MountsManager
   {
      
      public static const GOLDEN_HORSE_SHOE:int = 208035;
      
      public static const MOUNT_TRAIN_COIN:int = 208017;
      
      public static const MOUNTKING_ADDPRECENT:Number = 0.01;
      
      private static var _instance:MountsManager;
      
      public static var STONE_TEMPID:int = 208131;
      
      private var _mountInfo:MountInfo;
      
      private var _avatarList:WildSoulCollection;
      
      private var _mountShopList:Array;
      
      private var _previewMountsList:Array;
      
      private var _selfRefiningSoulInfo:MountRefiningSoulInfo;
      
      private var _isSetup:Boolean = false;
      
      public var vipMountActivity:Boolean = false;
      
      private var _flashPromotBtn:Boolean = true;
      
      public var isShineArray:Array = [0,0,0,0];
      
      private var _cmdKeyPool:Dictionary = new Dictionary();
      
      private var _cmdKeyCount:Dictionary = new Dictionary();
      
      public function MountsManager()
      {
         super();
         _mountInfo = new MountInfo();
         _avatarList = new WildSoulCollection();
         _mountShopList = [];
         _selfRefiningSoulInfo = new MountRefiningSoulInfo();
      }
      
      public static function get instance() : MountsManager
      {
         if(_instance == null)
         {
            _instance = new MountsManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         if(_isSetup)
         {
            return;
         }
         _isSetup = true;
         requestWildSoulList();
         SocketManager.instance.listener(4426,__onMountInfoUpdate);
         SocketManager.instance.listener(4427,__onMountListUpdate);
         SocketManager.instance.listener(4679,__onMountStarUpdate);
         SocketManager.instance.listener(4973,__onMountKingListUpdate);
         SocketManager.instance.listener(4974,__onMountKingInfoUpdate);
         SocketManager.instance.listener(4975,__onMountShopListHandler);
         SocketManager.instance.listener(305,__mountPreviewShopListHandler);
      }
      
      private function __onMountInfoUpdate(param1:SLGSocketEvent) : void
      {
         var _loc3_:PropertyInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:MountInfoMsg = new MountInfoMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as MountInfoMsg;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(_mountInfo && _mountInfo.upgradeTemplate)
         {
            _loc5_ = _mountInfo.upgradeTemplate.Grades;
         }
         _mountInfo.templateId = _loc2_.mountTempId;
         _mountInfo.growExp = _loc2_.mountTotalGp;
         _mountInfo.propertyGradeMax = _loc2_.levelMax;
         _mountInfo.discount = _loc2_.discount;
         if(_loc2_.hasAddPointCount)
         {
            _mountInfo.addPointCount = _loc2_.addPointCount;
         }
         _loc3_ = _mountInfo.getProperty("Strength");
         _loc3_.addition = _loc2_.power;
         _loc3_.propGp = _loc2_.powerGp;
         _loc3_ = _mountInfo.getProperty("Intellect");
         _loc3_.addition = _loc2_.intellect;
         _loc3_.propGp = _loc2_.intellectGp;
         _loc3_ = _mountInfo.getProperty("Stamina");
         _loc3_.addition = _loc2_.physique;
         _loc3_.propGp = _loc2_.physiqueGp;
         _loc3_ = _mountInfo.getProperty("Armor");
         _loc3_.addition = _loc2_.agility;
         _loc3_.propGp = _loc2_.agilityGp;
         if(_mountInfo && _mountInfo.upgradeTemplate)
         {
            _loc4_ = _mountInfo.upgradeTemplate.Grades;
         }
         if(_loc5_ != _loc4_)
         {
            MountActSocketOutManager.sendGetMountActInfo();
         }
         _mountInfo.dispatchChangeEvent();
         _selfRefiningSoulInfo.strengthGrade = _loc2_.refiningSoulPowerGrade;
         _selfRefiningSoulInfo.intellectGrade = _loc2_.refiningSoulIntellectGrade;
         _selfRefiningSoulInfo.staminaGrade = _loc2_.refiningSoulPhysiqueGrade;
         _selfRefiningSoulInfo.armorGrade = _loc2_.refiningSoulAgilityGrade;
         _selfRefiningSoulInfo.curExp = _loc2_.refiningSoulExp;
         MsgMan.notifyObserver("MOUNT_REFINING_SOUL_CHANGE");
      }
      
      private function __onMountListUpdate(param1:SLGSocketEvent) : void
      {
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc4_:MountAvatarMsg = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:MountAvatarMsg = new MountAvatarMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as MountAvatarMsg;
         if(_loc2_.totalPage > 1)
         {
            _loc6_ = "4427_" + _loc2_.stamp;
            _loc3_ = int(_cmdKeyCount[_loc6_]);
            _loc3_++;
            _cmdKeyCount[_loc6_] = _loc3_;
            if(_loc6_ in _cmdKeyPool)
            {
               _loc4_ = _cmdKeyPool[_loc6_];
               _loc4_.avatarInfo = _loc4_.avatarInfo.concat(_loc2_.avatarInfo);
               if(_loc3_ >= _loc2_.totalPage)
               {
                  __readMountList(_loc4_);
                  delete _cmdKeyPool[_loc6_];
                  delete _cmdKeyCount[_loc6_];
               }
            }
            else
            {
               _cmdKeyPool[_loc6_] = _loc2_;
            }
         }
         else
         {
            __readMountList(_loc2_);
         }
      }
      
      private function __readMountList(param1:MountAvatarMsg) : void
      {
         var _loc3_:WildSoulInfo = null;
         var _loc4_:MountTemplate = null;
         param1.hasSoulScore && (_mountInfo.soulScore = param1.soulScore);
         _avatarList.clearWildSoulList();
         for each(var _loc2_:AvatarInfoMsg in param1.avatarInfo)
         {
            _loc3_ = new WildSoulInfo();
            _loc3_.templateId = _loc2_.mountTempId;
            _loc3_.activeDate = DateFormatter.parse(_loc2_.activeDate,"YYYY-MM-DD hh:mm:ss");
            _loc3_.expairDate = DateFormatter.parse(_loc2_.expairDate,"YYYY-MM-DD hh:mm:ss");
            _loc3_.isExist = _loc2_.isExist;
            _loc3_.star = _loc2_.starLevel;
            _loc3_.bless = _loc2_.blessing;
            _loc3_.param1 = _loc2_.param1;
            _loc3_.param2 = _loc2_.param2;
            if(_loc2_.hasIsBuyFly)
            {
               _loc3_.isBuyFly = _loc2_.isBuyFly;
            }
            if(_loc2_.isBuyFly)
            {
               _loc4_ = TempleteManager.instance.mountTemplateDic[_loc2_.mountTempId];
               _loc4_.isBuyFly = true;
            }
            if(_loc3_.star > 0)
            {
               flashPromotBtn = false;
            }
            _avatarList.addWildSoul(_loc3_);
         }
         _avatarList.dispatchChangeEvent();
      }
      
      private function __onMountKingListUpdate(param1:SLGSocketEvent) : void
      {
         var _loc4_:MountKingInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:MountKingListMsg = new MountKingListMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as MountKingListMsg;
         _avatarList.clearKingList();
         for each(var _loc3_:MountKingInfoMsg in _loc2_.kingList)
         {
            _loc4_ = new MountKingInfo();
            _loc4_.templateId = _loc3_.templateId;
            _loc4_.grade = _loc3_.level;
            _loc4_.extraStar = _loc3_.extraStar;
            _loc4_.exp = _loc3_.gp;
            _avatarList.addKingMount(_loc4_);
         }
         _avatarList.dispatchChangeEvent();
      }
      
      private function __onMountKingInfoUpdate(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MountKingInfoMsg = new MountKingInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MountKingInfoMsg;
         var _loc3_:MountKingInfo = _avatarList.getMountKingInfo(_loc2_.templateId);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.templateId = _loc2_.templateId;
         _loc3_.grade = _loc2_.level;
         _loc3_.extraStar = _loc2_.extraStar;
         _loc3_.exp = _loc2_.gp;
         _avatarList.dispatchKingInfoChangedEvent(_loc3_);
      }
      
      private function __onMountShopListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:MountShopItemMsg = null;
         var _loc5_:MountShopInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:MountShopMsg = new MountShopMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as MountShopMsg;
         _mountShopList = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.itemList.length)
         {
            _loc3_ = _loc2_.itemList[_loc4_] as MountShopItemMsg;
            _loc5_ = new MountShopInfo();
            _loc5_.index = _loc4_;
            _loc5_.tempId = _loc3_.itemTempId;
            _loc5_.count = _loc3_.itemCount;
            _loc5_.price = _loc3_.price;
            _loc5_.isCanBuy = _loc3_.canBuy;
            mountShopList.push(_loc5_);
            _loc4_++;
         }
         _avatarList.dispatchShopRefreshEvent();
      }
      
      private function __mountPreviewShopListHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:MountShopItemMsg = null;
         var _loc3_:MountShopInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:MountShopMsg = new MountShopMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as MountShopMsg;
         _previewMountsList = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.itemList.length)
         {
            _loc4_ = _loc2_.itemList[_loc5_] as MountShopItemMsg;
            _loc3_ = new MountShopInfo();
            _loc3_.tempId = _loc4_.itemTempId;
            _loc3_.count = _loc4_.itemCount;
            _previewMountsList.push(_loc3_);
            _loc5_++;
         }
         _avatarList.dispatchShopPreviewEvent();
      }
      
      private function __onMountStarUpdate(param1:SLGSocketEvent) : void
      {
         var _loc5_:MountTemplate = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:AvatarInfoMsg = new AvatarInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as AvatarInfoMsg;
         var _loc3_:WildSoulInfo = _avatarList.getWildSoulInfo(_loc2_.mountTempId);
         if(!_loc3_)
         {
            requestWildSoulList();
            return;
         }
         if(_loc2_.hasActiveDate)
         {
            _loc3_.activeDate = DateFormatter.parse(_loc2_.activeDate,"YYYY-MM-DD hh:mm:ss");
         }
         if(_loc2_.hasExpairDate)
         {
            _loc3_.expairDate = DateFormatter.parse(_loc2_.expairDate,"YYYY-MM-DD hh:mm:ss");
         }
         if(_loc2_.hasIsExist)
         {
            _loc3_.isExist = _loc2_.isExist;
         }
         if(_loc2_.hasStarLevel)
         {
            _loc3_.star = _loc2_.starLevel;
         }
         if(_loc2_.hasBlessing)
         {
            _loc3_.bless = _loc2_.blessing;
         }
         if(_loc2_.hasParam1)
         {
            _loc3_.param1 = _loc2_.param1;
         }
         if(_loc2_.hasParam2)
         {
            _loc3_.param2 = _loc2_.param2;
         }
         if(_loc2_.hasIsBuyFly)
         {
            _loc3_.isBuyFly = _loc2_.isBuyFly;
         }
         if(_loc2_.isBuyFly)
         {
            _loc5_ = TempleteManager.instance.mountTemplateDic[_loc2_.mountTempId];
            _loc5_.isBuyFly = true;
         }
         _avatarList.dispatchSoulInfoChangedEvent(_loc3_);
      }
      
      public function requestWildSoulList() : void
      {
         var _loc1_:PackageOut = new PackageOut(8530);
         socket.send(_loc1_);
      }
      
      public function sendUseGoods(param1:GoodsInfo, param2:Boolean) : void
      {
         if(param1.templateInfo.Property3 > 0)
         {
            if(this.mountInfo.grade < param1.templateInfo.Property3)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("mounts.UseGoodNeedGrade",param1.templateInfo.Property3));
               return;
            }
         }
         var _loc3_:MountTemplate = TempleteManager.instance.mountTemplateDic[param1.templateInfo.Property1];
         if(param2)
         {
            isShineArray[_loc3_.Area - 1] = 1;
         }
         SocketSendManager.instance.sendUseItem(param1.pos);
         MainToolBar.instance.mountButtonShine = true;
      }
      
      public function mountOperateSend(param1:int, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0) : void
      {
         var _loc7_:PackageOut = new PackageOut(8529);
         var _loc6_:MountEditMsg = new MountEditMsg();
         _loc6_.op = param1;
         _loc6_.propertyType = param2;
         _loc6_.payType = param3;
         _loc6_.param1 = param4;
         _loc6_.param2 = param5;
         socket.sendProtobuffer(_loc7_,_loc6_);
      }
      
      public function canShowStar(param1:int) : Boolean
      {
         var _loc2_:WildSoulInfo = avatarList.getWildSoulInfo(param1);
         if(!_loc2_)
         {
            return false;
         }
         if(!_loc2_.isExist)
         {
            return false;
         }
         if(_loc2_.validity != -1)
         {
            return false;
         }
         if(_loc2_.template.MountType == 3)
         {
            return false;
         }
         if(_loc2_.template.MountType == 4)
         {
            return false;
         }
         return true;
      }
      
      public function checkMountProperty() : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:PropertyInfo = null;
         var _loc4_:int = 0;
         var _loc1_:Array = ["Strength","Intellect","Stamina","Armor"];
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = _mountInfo.getProperty(_loc1_[_loc4_]);
            if(_loc3_.grade >= 2)
            {
               if(_loc3_.grade >= 3)
               {
                  _loc2_ += 2;
               }
               else
               {
                  _loc2_++;
               }
            }
            _loc4_++;
         }
         if(_loc2_ >= 2)
         {
            return false;
         }
         if(GoodsManager.instance.getGoodsNumByTempId(208017) >= 5)
         {
            return true;
         }
         return false;
      }
      
      public function getPromotSuccessRate(param1:WildSoulInfo) : int
      {
         if(!param1.blessUpgradeInfo)
         {
            return 0;
         }
         if(param1.bless >= param1.blessUpgradeInfo.Data)
         {
            return 100;
         }
         return 5;
      }
      
      public function set flashPromotBtn(param1:Boolean) : void
      {
         _flashPromotBtn = param1;
      }
      
      public function get flashPromotBtn() : Boolean
      {
         if(!SharedManager.instance.flashPromotionBtn)
         {
            return false;
         }
         if(!_flashPromotBtn)
         {
            return false;
         }
         return true;
      }
      
      private function get socket() : ByteSocket
      {
         return SocketManager.instance.socket;
      }
      
      public function get mountInfo() : MountInfo
      {
         return _mountInfo;
      }
      
      public function get avatarList() : WildSoulCollection
      {
         return _avatarList;
      }
      
      public function get selfRefiningSoulInfo() : MountRefiningSoulInfo
      {
         return _selfRefiningSoulInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get mountShopList() : Array
      {
         return _mountShopList;
      }
      
      public function get mountPreviewList() : Array
      {
         return _previewMountsList;
      }
   }
}

