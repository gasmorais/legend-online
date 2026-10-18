package yishi.manager
{
   import com.road.yishi.proto.player.PayTypeMsg;
   import com.road.yishi.proto.star.AdditionInfoMsg;
   import com.road.yishi.proto.star.StarAdditionMsg;
   import com.road.yishi.proto.star.StarComposeReqMsg;
   import com.road.yishi.proto.star.StarGrowOpMsg;
   import com.road.yishi.proto.star.StarLockReqMsg;
   import com.road.yishi.proto.star.StarMoveMsg;
   import com.road.yishi.proto.star.StarMoveReqMsg;
   import com.road.yishi.proto.star.StarMoveRspMsg;
   import com.road.yishi.proto.star.StarPickReqMsg;
   import com.road.yishi.proto.star.StarRandMsg;
   import com.road.yishi.proto.star.StarRandReqMsg;
   import com.road.yishi.proto.star.StarRandRspMsg;
   import com.road.yishi.proto.star.StarShopMsg;
   import com.road.yishi.proto.star.StarVipEventMsg;
   import events.StarEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.star.StarInfo;
   import mvc.module.star.StarModel;
   import mvc.module.star.StarTroughInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StarHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class StarManager extends EventDispatcher
   {
      
      private static var _instance:StarManager;
      
      public static var isNotAlert:Boolean = false;
      
      private const STAR_MASTER_TASK:int = 1802;
      
      private var _tempStarList:SimpleDictionary;
      
      private var _startList:SimpleDictionary;
      
      private var _randomPosList:Array;
      
      private var _starModel:StarModel;
      
      private var _composeList:Vector.<ComposeGoodsTemplete>;
      
      public function StarManager()
      {
         super();
         if(!_starModel)
         {
            _starModel = new StarModel();
         }
      }
      
      public static function get instance() : StarManager
      {
         if(!_instance)
         {
            _instance = new StarManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _tempStarList = new SimpleDictionary(true);
         _startList = new SimpleDictionary(true);
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4178,__starMoveUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4179,__starPickHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4180,__starRandHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4479,__starQuickComposeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4677,_starTroughInfoHandler);
      }
      
      private function __starMoveUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc10_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:StarInfo = null;
         var _loc8_:StarMoveMsg = null;
         var _loc5_:StarTroughInfo = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:Boolean = false;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:StarMoveRspMsg = new StarMoveRspMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as StarMoveRspMsg;
         var _loc11_:int = int(_loc2_.move.length);
         if(!_starModel.starTroughs)
         {
            _starModel.starTroughs = new Vector.<StarTroughInfo>();
         }
         var _loc3_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc5_ = new StarTroughInfo();
            _loc5_.pos = _loc7_;
            _loc5_.grade = 0;
            _loc5_.gp = 0;
            _starModel.starTroughs.push(_loc5_);
            _loc7_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc11_)
         {
            _loc8_ = _loc2_.move[_loc6_] as StarMoveMsg;
            _loc10_ = _loc8_.changeType;
            _loc12_ = _loc8_.changePos;
            _loc4_ = _loc8_.hasStar_Info;
            _loc13_ = _startList[_loc10_ + "_" + _loc12_] as StarInfo;
            if(_loc4_)
            {
               if(!_loc13_)
               {
                  _loc13_ = new StarInfo();
                  _startList.add(_loc10_ + "_" + _loc12_,_loc13_);
               }
               _loc13_.beginChange();
               _loc13_.bagType = _loc8_.star_Info.bagType;
               _loc13_.pos = _loc8_.star_Info.pos;
               _loc13_.id = _loc8_.star_Info.id;
               _loc13_.tempId = _loc8_.star_Info.templateId;
               _loc13_.userId = _loc8_.star_Info.userId;
               _loc13_.oldBagType = _loc8_.star_Info.objectId;
               _loc13_.grade = _loc8_.star_Info.grade;
               _loc13_.gp = _loc8_.star_Info.gp;
               _loc13_.composeLock = _loc8_.star_Info.isLock;
               _loc13_.commit();
               dispatchEvent(new StarEvent("UPDATE_STAR",_loc13_));
               if(_loc13_.bagType == 2)
               {
                  dispatchEvent(new StarEvent("UPDATE_STAR_POWER",_loc13_));
               }
            }
            else
            {
               _loc13_.pos = _loc12_;
               _loc13_.bagType = _loc10_;
               _startList.del(_loc10_ + "_" + _loc12_);
               dispatchEvent(new StarEvent("DELETE_STAR",_loc13_));
               if(_loc13_.bagType == 2)
               {
                  dispatchEvent(new StarEvent("UPDATE_STAR_POWER",_loc13_));
               }
            }
            _loc6_++;
         }
         InfoTipsManager.instance.dealData(13);
      }
      
      private function __starPickHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:StarRandMsg = null;
         var _loc8_:StarInfo = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:StarRandRspMsg = new StarRandRspMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as StarRandRspMsg;
         var _loc4_:int = int(_loc2_.starRand.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc2_.starRand[_loc5_] as StarRandMsg;
            _loc3_ = _loc6_.dropSite;
            _loc8_ = _tempStarList[_loc3_] as StarInfo;
            if(_loc8_)
            {
               _tempStarList.del(_loc3_);
            }
            _loc5_++;
         }
      }
      
      private function __starRandHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc9_:Boolean = false;
         var _loc5_:int = 0;
         var _loc7_:StarRandMsg = null;
         var _loc10_:StarInfo = null;
         var _loc3_:int = 0;
         var _loc6_:Boolean = false;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:StarRandRspMsg = new StarRandRspMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as StarRandRspMsg;
         if(!_randomPosList)
         {
            _randomPosList = _loc2_.site;
         }
         else
         {
            _loc4_ = int(_loc2_.site.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if(_randomPosList[_loc5_] != _loc2_.site[_loc5_])
               {
                  _randomPosList[_loc5_] = _loc2_.site[_loc5_];
                  _starModel.openCrystal == _loc5_ ? (_starModel.openCrystal = -1) : (_starModel.openCrystal = _loc5_);
                  _loc9_ = true;
               }
               _loc5_++;
            }
            if(_loc9_)
            {
               dispatchEvent(new StarEvent("RANDOMPOS_CHANGE",null));
            }
         }
         _loc4_ = int(_loc2_.starRand.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = _loc2_.starRand[_loc5_] as StarRandMsg;
            _loc3_ = _loc7_.dropSite;
            _loc10_ = _tempStarList[_loc3_] as StarInfo;
            _loc6_ = false;
            if(!_loc10_)
            {
               _loc10_ = new StarInfo();
               _loc6_ = true;
            }
            _loc10_.beginChange();
            _loc10_.bagType = _loc7_.starInfo.bagType;
            _loc10_.pos = _loc7_.starInfo.pos;
            _loc10_.id = _loc7_.starInfo.id;
            _loc10_.tempId = _loc7_.starInfo.templateId;
            _loc10_.userId = _loc7_.starInfo.userId;
            _loc10_.oldBagType = _loc7_.starInfo.objectId;
            _loc10_.grade = _loc7_.starInfo.grade;
            _loc10_.gp = _loc7_.starInfo.gp;
            _loc10_.composeLock = _loc7_.starInfo.isLock;
            _loc10_.commit();
            if(_loc6_)
            {
               _tempStarList.add(_loc3_,_loc10_);
            }
            _loc5_++;
         }
      }
      
      private function __starQuickComposeHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:StarRandRspMsg = new StarRandRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as StarRandRspMsg;
         var _loc6_:Array = _tempStarList.getList().concat();
         for each(var _loc7_:StarInfo in _loc6_)
         {
            _loc3_ = false;
            for each(var _loc4_:StarRandMsg in _loc2_.starRand)
            {
               if(_loc7_.pos == _loc4_.dropSite)
               {
                  _loc7_.beginChange();
                  _loc7_.bagType = _loc4_.starInfo.bagType;
                  _loc7_.pos = _loc4_.starInfo.pos;
                  _loc7_.id = _loc4_.starInfo.id;
                  _loc7_.tempId = _loc4_.starInfo.templateId;
                  _loc7_.userId = _loc4_.starInfo.userId;
                  _loc7_.oldBagType = _loc4_.starInfo.objectId;
                  _loc7_.grade = _loc4_.starInfo.grade;
                  _loc7_.gp = _loc4_.starInfo.gp;
                  _loc7_.composeLock = _loc4_.starInfo.isLock;
                  _loc7_.commit();
                  _loc3_ = true;
                  break;
               }
            }
            if(_loc3_)
            {
               dispatchEvent(new StarEvent("COMPOSE_STAR",_loc7_));
            }
            else
            {
               _tempStarList.del(_loc7_.pos);
            }
         }
      }
      
      private function _starTroughInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:AdditionInfoMsg = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:StarTroughInfo = null;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:StarAdditionMsg = new StarAdditionMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as StarAdditionMsg;
         var _loc5_:int = int(_loc2_.additions.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _loc2_.additions[_loc6_] as AdditionInfoMsg;
            _loc7_ = checkIsExist(_loc3_.pos,_starModel.starTroughs);
            _loc4_ = new StarTroughInfo();
            _loc4_.userId = _loc3_.userId;
            _loc4_.type = _loc3_.type;
            _loc4_.pos = _loc3_.pos;
            _loc4_.gp = _loc3_.curGp;
            _loc4_.grade = _loc3_.grade;
            if(_loc7_ >= 0)
            {
               _starModel.starTroughs[_loc7_] = _loc4_;
            }
            else
            {
               _starModel.starTroughs.push(_loc4_);
            }
            _loc6_++;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_STARTROUGHINFO"));
      }
      
      private function checkIsExist(param1:int, param2:Vector.<StarTroughInfo>) : int
      {
         var _loc3_:StarTroughInfo = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < starModel.starTroughs.length)
         {
            _loc3_ = starModel.starTroughs[_loc4_] as StarTroughInfo;
            if(_loc3_.pos == param1)
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
      
      public function sendRandomStar(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8269);
         var _loc2_:StarRandReqMsg = new StarRandReqMsg();
         _loc2_.site = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendAutoStar(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8876);
         var _loc4_:StarVipEventMsg = new StarVipEventMsg();
         _loc4_.golden = param1;
         _loc4_.sellMaxQuality = param2;
         _loc4_.composeMaxQuality = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendStarPick(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8268);
         var _loc3_:StarPickReqMsg = new StarPickReqMsg();
         _loc3_.dropsite = param1;
         _loc3_.way = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function starMove(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false, param6:int = 1) : void
      {
         var _loc8_:PackageOut = new PackageOut(8267);
         var _loc7_:StarMoveReqMsg = new StarMoveReqMsg();
         _loc7_.beginPos = param1;
         _loc7_.beginStarType = param2;
         _loc7_.endPos = param3;
         _loc7_.endStarType = param4;
         _loc7_.count = param6;
         _loc7_.eat = param5;
         SocketSendManager.instance.sendProtoBuffer(_loc8_,_loc7_);
      }
      
      public function sendBagCellBuy() : void
      {
         var _loc3_:int = int(TempleteManager.instance.getConfigInfoByConfigName("Star_BagPrice").ConfigValue);
         SimpleAlertHelper.instance.data = [payCallBack,_loc3_];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("yishi.manager.StarManager.content",_loc3_);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc1_,_loc2_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleStyle",_loc3_);
      }
      
      private function payCallBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc5_:PackageOut = null;
         var _loc4_:PayTypeMsg = null;
         if(param1)
         {
            _loc5_ = new PackageOut(8270);
            _loc4_ = new PayTypeMsg();
            _loc4_.payType = 0;
            if(!param2)
            {
               _loc4_.payType = 1;
            }
            SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
         }
      }
      
      public function sendQuickCompose(param1:int, param2:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(8331);
         var _loc3_:StarComposeReqMsg = new StarComposeReqMsg();
         _loc3_.pos = param1;
         _loc3_.bagType = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendStarComposeLock(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8330);
         var _loc3_:StarLockReqMsg = new StarLockReqMsg();
         _loc3_.starType = param1;
         _loc3_.pos = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendResetStarData() : void
      {
         var _loc1_:PackageOut = new PackageOut(8325);
         SocketSendManager.instance.sendProtoBuffer(_loc1_,null);
      }
      
      public function sendExchangeStar(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8341);
         var _loc2_:StarShopMsg = new StarShopMsg();
         _loc2_.goodId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function getStarListByBagType(param1:int) : SimpleDictionary
      {
         var _loc2_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc3_:StarInfo in _startList)
         {
            if(_loc3_.bagType == param1)
            {
               _loc2_.add(_loc3_.pos,_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getStarInfoByBagTypeAndPos(param1:int, param2:int) : StarInfo
      {
         for each(var _loc3_:StarInfo in _startList)
         {
            if(_loc3_.bagType == param1 && _loc3_.pos == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function get canShowSubList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:StarInfo in _startList)
         {
            if(!(_loc2_.bagType != 2 && _loc2_.bagType != 1))
            {
               if(_loc2_.template.Profile >= 8 || _loc2_.template.Profile == 7 && _loc2_.grade == 10 && _loc2_.tempId != 107)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         return _loc1_;
      }
      
      public function getStarTroughInfoByPos(param1:int) : StarTroughInfo
      {
         return starModel.starTroughs[param1] as StarTroughInfo;
      }
      
      public function checkStarPlayerBagIsFull() : Boolean
      {
         var _loc1_:int = int(getStarListByBagType(1).getList().length);
         if(_loc1_ >= 12 + playerInfo.starBagCount)
         {
            return true;
         }
         return false;
      }
      
      public function getStarPlayerBagCellNum() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = int(getStarListByBagType(1).getList().length);
         return int(12 + playerInfo.starBagCount - _loc2_);
      }
      
      public function sendStarAddition(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8772);
         var _loc3_:AdditionInfoMsg = new AdditionInfoMsg();
         _loc3_.pos = param1;
         _loc3_.type = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendStarSublime(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(5182);
         var _loc3_:StarGrowOpMsg = new StarGrowOpMsg();
         _loc3_.opType = param1;
         _loc3_.itemCount = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function checkIsStarNotFull() : Boolean
      {
         if(thane.grades >= 18 && thane.grades < 25 && starModel.getStarPow() < 150 && ResourceManager.instance.gold.count >= 50000)
         {
            return true;
         }
         if(thane.grades >= 25 && thane.grades < 35 && starModel.getStarPow() < 250 && ResourceManager.instance.gold.count >= 100000)
         {
            return true;
         }
         if(thane.grades >= 35 && thane.grades <= 40 && starModel.getStarPow() < 500 && ResourceManager.instance.gold.count >= 150000)
         {
            return true;
         }
         return false;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get tempStarList() : SimpleDictionary
      {
         return _tempStarList;
      }
      
      public function get startList() : SimpleDictionary
      {
         return _startList;
      }
      
      public function get randomPosList() : Array
      {
         return _randomPosList;
      }
      
      public function get starModel() : StarModel
      {
         return _starModel;
      }
      
      public function hideToBag() : void
      {
         var _loc1_:SimpleDictionary = getStarListByBagType(3);
         for each(var _loc2_:StarInfo in _loc1_)
         {
            if(_loc2_.oldBagType == 1)
            {
               moveToBag(_loc2_);
            }
            else if(_loc2_.oldBagType == 2)
            {
               moveToEquip(_loc2_);
            }
         }
      }
      
      public function getHighStar(param1:StarInfo) : StarInfo
      {
         var _loc2_:int = 0;
         var _loc4_:StarInfo = null;
         if(param1 == null)
         {
            return null;
         }
         initComposeList();
         for each(var _loc3_:ComposeGoodsTemplete in _composeList)
         {
            if(_loc3_.Material1 == param1.tempId)
            {
               _loc2_ = _loc3_.NewMaterial;
               break;
            }
         }
         if(_loc2_ > 0)
         {
            _loc4_ = new StarInfo();
            _loc4_.tempId = _loc2_;
            _loc4_.grade = 1;
            return _loc4_;
         }
         return null;
      }
      
      public function isDoubleSubStar(param1:StarInfo) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return true;
         }
         initComposeList();
         for each(var _loc3_:ComposeGoodsTemplete in _composeList)
         {
            if(_loc3_.Material1 == param1.tempId)
            {
               _loc2_ = _loc3_.NewMaterial;
               break;
            }
         }
         if(_loc2_ > 0)
         {
            for each(var _loc4_:StarInfo in _startList)
            {
               if(_loc4_.tempId == _loc2_)
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function initComposeList() : void
      {
         var _loc2_:Dictionary = null;
         if(_composeList == null)
         {
            _composeList = new Vector.<ComposeGoodsTemplete>();
            _loc2_ = TempleteManager.instance.getComposeTempleteList();
            for each(var _loc1_:ComposeGoodsTemplete in _loc2_)
            {
               if(_loc1_.Types == 14)
               {
                  _composeList.push(_loc1_);
               }
            }
         }
      }
      
      public function moveToBag(param1:StarInfo) : Boolean
      {
         var _loc6_:StarInfo = null;
         var _loc5_:int = 0;
         var _loc2_:String = "";
         var _loc3_:Boolean = false;
         var _loc4_:int = int(getStarListByBagType(1).getList().length);
         var _loc7_:int = 12 + playerInfo.starBagCount;
         if(_loc4_ == _loc7_)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command04");
            MessageTipManager.instance().show(_loc2_);
            return _loc3_;
         }
         _loc5_ = 0;
         while(_loc5_ < 18)
         {
            _loc6_ = getStarInfoByBagTypeAndPos(1,_loc5_);
            if(!_loc6_)
            {
               starMove(param1.pos,param1.bagType,_loc5_,1);
               _loc3_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function moveToSub(param1:StarInfo) : void
      {
         if(param1.tempId == 107)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.HigStarDragTips3"));
         }
         else if(param1.template.Profile == 7)
         {
            if(param1.grade == 10)
            {
               starMove(param1.pos,param1.bagType,0,3);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.HigStarDragTips2"));
            }
         }
         else if(param1.template.Profile < 8)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.HigStarDragTips2"));
         }
         else
         {
            starMove(param1.pos,param1.bagType,0,3);
         }
      }
      
      public function moveToEquip(param1:StarInfo) : Boolean
      {
         var _loc7_:StarInfo = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:String = "";
         if(param1.template.Profile == 6)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command01");
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         var _loc8_:int = int(getStarListByBagType(2).getList().length);
         var _loc9_:int = int(int(thane.grades / 10) > 8 ? 8 : int(thane.grades / 10));
         if(TaskManage.instance.IsTaskFinish(1802) && ArmyManager.instance.thane.grades >= 60)
         {
            _loc9_ += 1;
            if(playerInfo.vocationLevel > 0)
            {
               _loc9_ += 1;
            }
         }
         if(_loc8_ >= _loc9_)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command05");
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         var _loc3_:Vector.<int> = new Vector.<int>();
         var _loc5_:Vector.<int> = new Vector.<int>();
         _loc6_ = 0;
         while(_loc6_ < 10)
         {
            _loc7_ = getStarInfoByBagTypeAndPos(2,_loc6_);
            if(_loc7_)
            {
               if(_loc7_.template.MasterType == param1.template.MasterType)
               {
                  _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command02");
                  MessageTipManager.instance().show(_loc2_);
                  _loc3_ = null;
                  _loc5_ = null;
                  return false;
               }
            }
            else
            {
               _loc3_.push(_loc6_);
               if(_loc6_ == 8 && TaskManage.instance.IsTaskFinish(1802) && ArmyManager.instance.thane.grades >= 60)
               {
                  _loc5_.push(_loc6_);
               }
               else if(_loc6_ == 9 && TaskManage.instance.IsTaskFinish(1802) && playerInfo.vocationLevel > 0)
               {
                  _loc5_.push(_loc6_);
               }
            }
            _loc6_++;
         }
         if(param1.template.MasterType == 17 || param1.template.MasterType == 18 || param1.template.MasterType == 19)
         {
            if(_loc5_.length <= 0)
            {
               if(TaskManage.instance.IsTaskFinish(1802) && playerInfo.vocationLevel > 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command11");
               }
               else
               {
                  _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command12");
               }
               MessageTipManager.instance().show(_loc2_);
               return false;
            }
            _loc4_ = _loc5_[0];
         }
         else
         {
            _loc4_ = _loc3_[0];
         }
         if(_loc4_ == 8)
         {
            if(!TaskManage.instance.IsTaskFinish(1802) || ArmyManager.instance.thane.grades < 60)
            {
               if(param1.template.MasterType == 17 || param1.template.MasterType == 18 || param1.template.MasterType == 19)
               {
                  _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command09");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command07");
               MessageTipManager.instance().show(_loc2_);
               return false;
            }
         }
         else if(_loc4_ == 9)
         {
            if(!TaskManage.instance.IsTaskFinish(1802) || playerInfo.vocationLevel <= 0)
            {
               if(param1.template.MasterType == 17 || param1.template.MasterType == 18 || param1.template.MasterType == 19)
               {
                  _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command10");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               _loc2_ = LanguageMgr.GetTranslation("cell.view.starbag.StarBagCell.command08",StarHelper.getThirdJobStr());
               MessageTipManager.instance().show(_loc2_);
               return false;
            }
         }
         starMove(param1.pos,param1.bagType,_loc4_,2);
         _loc3_ = null;
         _loc5_ = null;
         return true;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

