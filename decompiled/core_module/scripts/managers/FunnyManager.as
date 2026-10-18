package managers
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import com.road.yishi.proto.active.ActiveData;
   import com.road.yishi.proto.active.ActiveInfoMsg;
   import com.road.yishi.proto.active.ChargeRewardMsg;
   import com.road.yishi.proto.active.ConsumeInfoMsg;
   import com.road.yishi.proto.active.NewMountFeedMsg;
   import com.road.yishi.proto.active.PackageConditionMsg;
   import com.road.yishi.proto.active.PackageData;
   import com.road.yishi.proto.active.QueryActiveMsg;
   import com.road.yishi.proto.active.ReturnChargeRewardMsg;
   import com.road.yishi.proto.active.ReturnCommonRewardMsg;
   import com.road.yishi.proto.active.ReturnOptionMsg;
   import com.road.yishi.proto.active.ReturnedItemMsg;
   import com.road.yishi.proto.active.RewardMsg;
   import com.road.yishi.proto.active.SumActiveDataMsg;
   import com.road.yishi.proto.active.SumActiveGetPackageMsg;
   import com.road.yishi.proto.active.SumActiveItemInfoMsg;
   import com.road.yishi.proto.active.SumActivePackageMsg;
   import com.road.yishi.proto.active.SumActiveinfoMsg;
   import com.road.yishi.proto.active.SumActivesMsg;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyConditionData;
   import funny.datas.FunnyData;
   import funny.datas.FunnyRewardData;
   import funny.datas.KarnevalInfo;
   import funny.regression.RegressionView;
   import manager.LanguageMgr;
   import mountact.MountActModel;
   import mvc.module.funny.ActiveInfo;
   import mvc.module.funny.FunnyModel;
   import tasktracetip.data.TipMessageData;
   import yishi.actions.base.AlertTipAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.SimpleAlertHelper;
   
   public class FunnyManager extends EventDispatcher
   {
      
      private static var _instance:FunnyManager;
      
      public static var isOpenTiroFunnyFrame:Boolean = false;
      
      private var _isNeed:Boolean;
      
      public var needTime:String;
      
      private var _godTreasureEnd:Number;
      
      private var _godTreasureStart:Number;
      
      private var _model:FunnyModel;
      
      private var _mountModel:MountActModel;
      
      private var version:int;
      
      private var total:int;
      
      public var selectedId:String = "";
      
      public var canShine:Boolean = true;
      
      private var _activityArr:Array = [];
      
      private var _needTipRegression:Boolean = true;
      
      private var _hasGetGift:Boolean = false;
      
      private var _regressionActiveId:String = "";
      
      private var _regressionActiveCost:int = 0;
      
      private var _tiroFunnySelectedId:String = "";
      
      public var backPlayerBtnEnable:Boolean;
      
      public var regressRewardBtnEnable:Boolean;
      
      private var mountFunnyData:FunnyData;
      
      public function FunnyManager(param1:IEventDispatcher = null)
      {
         super();
         if(_model == null)
         {
            _model = new FunnyModel();
         }
         if(_mountModel == null)
         {
            _mountModel = new MountActModel();
         }
         SharedManager.instance.funnyOldDic["ACTIVITY_CODE_ID"] = "ACTIVITY_CODE_ID";
      }
      
      public static function get instance() : FunnyManager
      {
         if(!_instance)
         {
            _instance = new FunnyManager();
         }
         return _instance;
      }
      
      public function get model() : FunnyModel
      {
         return _model;
      }
      
      public function get mountModel() : MountActModel
      {
         return _mountModel;
      }
      
      public function get regressionActiveId() : String
      {
         return _regressionActiveId;
      }
      
      public function get regressionActiveCost() : int
      {
         return _regressionActiveCost;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4475,__funnyTemHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4476,__funnyUserHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4714,__funnyUserHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4550,__backPlayerHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4723,__mountActHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4739,__returnerChargeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4740,__returnerCommonHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 345,__returnCrossCostHandler);
      }
      
      protected function __returnerCommonHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:Array = null;
         var _loc10_:Array = null;
         var _loc4_:RewardMsg = null;
         var _loc6_:ReturnedItemMsg = null;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc3_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc7_:int = 0;
         var _loc9_:PackageIn = param1.data as PackageIn;
         var _loc2_:ReturnCommonRewardMsg = new ReturnCommonRewardMsg();
         _loc2_ = _loc9_.readBody(_loc2_) as ReturnCommonRewardMsg;
         _loc8_ = _loc2_.rewards;
         if(_loc2_.type == 2)
         {
            _loc4_ = _loc8_[_loc8_.length - 1] as RewardMsg;
            if(_loc4_.type == 2)
            {
               _loc10_ = _loc4_.items;
               SimpleAlertHelper.instance.data = [];
               _loc3_ = LanguageMgr.GetTranslation("public.confirm");
               _loc11_ = LanguageMgr.GetTranslation("public.prompt");
               if(_loc4_.number < 5)
               {
                  _loc12_ = LanguageMgr.GetTranslation("funny.view.FunnyFrame.regress.rewardTips" + _loc4_.number);
               }
               else
               {
                  _loc12_ = LanguageMgr.GetTranslation("funny.view.FunnyFrame.regress.rewardTips" + _loc4_.number,_loc4_.returnerName);
               }
               _loc7_ = 0;
               while(_loc7_ < _loc10_.length)
               {
                  _loc6_ = _loc10_[_loc7_] as ReturnedItemMsg;
                  _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_.tempId);
                  if(_loc5_)
                  {
                     _loc12_ += LanguageMgr.GetTranslation("MonopolyManager.BattleGetTip02",_loc5_.TemplateName,_loc6_.count);
                  }
                  _loc7_++;
               }
               if(_loc12_ != "")
               {
                  _loc12_ = _loc12_.substring(0,_loc12_.length - 1);
               }
               SimpleAlertHelper.instance.popAlerFrame(_loc11_,_loc12_,_loc3_,"",false,false,true);
            }
         }
         regressRewardBtnEnable = _loc2_.hasReward;
         dispatchEvent(new FunnyEvent("REFRESH_REGRESS_REWARD"));
      }
      
      protected function __returnCrossCostHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChargeRewardMsg = new ChargeRewardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChargeRewardMsg;
         var _loc4_:Object = {};
         _loc4_.currentValue = _loc2_.totalCount;
         _loc4_.threeTotalValue = _loc2_.topThreeCount;
         _loc4_.dayTotalCount = _loc2_.dayTotalCount;
         _loc4_.myTotalCount = _loc2_.myTotalCount;
         model.currentCost = _loc4_;
         dispatchEvent(new FunnyEvent("REFRESH_CURRENT_COST"));
      }
      
      protected function __returnerChargeHandler(param1:SLGSocketEvent) : void
      {
         var _loc10_:Array = null;
         var _loc18_:Array = null;
         var _loc17_:* = null;
         var _loc3_:RewardMsg = null;
         var _loc5_:ReturnedItemMsg = null;
         var _loc7_:int = 0;
         var _loc14_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:FunnyBagData = null;
         var _loc4_:FunnyRewardData = null;
         var _loc15_:FunnyConditionData = null;
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc2_:ReturnChargeRewardMsg = new ReturnChargeRewardMsg();
         _loc2_ = _loc11_.readBody(_loc2_) as ReturnChargeRewardMsg;
         var _loc13_:Boolean = false;
         var _loc16_:Boolean = false;
         var _loc12_:FunnyData = model.regressCharge;
         if(!_loc12_)
         {
            _loc12_ = new FunnyData();
            _loc12_.id = "REGRESS_ID";
            _loc12_.type = 1007;
            _loc12_.title = LanguageMgr.GetTranslation("funny.view.FunnyFrame.regress.title");
            _loc12_.describe = LanguageMgr.GetTranslation("funny.view.FunnyFrame.regress.describe");
            _loc12_.condition = LanguageMgr.GetTranslation("funny.view.FunnyFrame.regress.condition");
            _loc10_ = _loc2_.rewards;
            _loc8_ = 0;
            while(_loc8_ < _loc10_.length)
            {
               _loc3_ = _loc10_[_loc8_] as RewardMsg;
               if(_loc3_.type == 1)
               {
                  _loc14_ = "REGRESS_ID" + _loc3_.number;
                  _loc6_ = new FunnyBagData();
                  _loc6_.id = _loc14_;
                  _loc6_.activeId = "REGRESS_ID";
                  _loc6_.order = _loc3_.number;
                  _loc6_.status = _loc3_.getStatu;
                  if(_loc6_.status == 1)
                  {
                     _loc12_.anyToGet = true;
                  }
                  _loc18_ = _loc3_.items;
                  _loc9_ = 0;
                  while(_loc9_ < _loc18_.length)
                  {
                     _loc5_ = _loc18_[_loc9_] as ReturnedItemMsg;
                     _loc4_ = new FunnyRewardData();
                     _loc4_.temId = _loc5_.tempId;
                     _loc4_.count = _loc5_.count;
                     _loc6_.rewardList.push(_loc4_);
                     _loc9_++;
                  }
                  _loc15_ = new FunnyConditionData();
                  _loc15_.id = 10066;
                  _loc15_.value = _loc3_.param1;
                  _loc6_.conditionList.push(_loc15_);
                  _loc6_.rewardList.sort(sortMasterType);
                  _loc12_.bagList.push(_loc6_);
                  _loc16_ = true;
               }
               _loc8_++;
            }
            _loc12_.bagList.sort(byOrder);
            model.data.push(_loc12_);
            model.data.sort(byOrder);
            model.regressCharge = _loc12_;
         }
         else
         {
            if(!_loc12_.bagList)
            {
               _loc12_.bagList = new Vector.<FunnyBagData>();
            }
            _loc12_.anyToGet = false;
            _loc10_ = _loc2_.rewards;
            _loc8_ = 0;
            while(_loc8_ < _loc10_.length)
            {
               _loc3_ = _loc10_[_loc8_] as RewardMsg;
               if(_loc3_.type == 1)
               {
                  _loc14_ = "REGRESS_ID" + _loc3_.number;
                  _loc6_ = findFunnyBagDataById(_loc12_,_loc14_);
                  _loc6_.id = _loc14_;
                  _loc6_.activeId = "REGRESS_ID";
                  _loc6_.order = _loc3_.number;
                  _loc6_.status = _loc3_.getStatu;
                  if(_loc6_.status == 1)
                  {
                     _loc12_.anyToGet = true;
                  }
                  _loc6_.rewardList.length = 0;
                  _loc6_.conditionList.length = 0;
                  _loc18_ = _loc3_.items;
                  _loc9_ = 0;
                  while(_loc9_ < _loc18_.length)
                  {
                     _loc5_ = _loc18_[_loc9_] as ReturnedItemMsg;
                     _loc4_ = new FunnyRewardData();
                     _loc4_.temId = _loc5_.tempId;
                     _loc4_.count = _loc5_.count;
                     _loc6_.rewardList.push(_loc4_);
                     _loc9_++;
                  }
                  _loc15_ = new FunnyConditionData();
                  _loc15_.id = 10066;
                  _loc15_.value = _loc3_.param1;
                  _loc6_.conditionList.push(_loc15_);
                  _loc6_.rewardList.sort(sortMasterType);
                  _loc16_ = true;
               }
               _loc8_++;
            }
            _loc12_.bagList.sort(byOrder);
            model.data.sort(byOrder);
         }
         if(_loc13_ && model.canShine)
         {
            dispatchEvent(new FunnyEvent("ITEM_CANGET"));
         }
         if(_loc16_)
         {
            dispatchEvent(new FunnyEvent("REFRESH_ITEM"));
         }
      }
      
      protected function __backPlayerHandler(param1:SLGSocketEvent) : void
      {
         backPlayerBtnEnable = true;
      }
      
      private function __mountActHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:NewMountFeedMsg = new NewMountFeedMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as NewMountFeedMsg;
         mountModel.beginTm = _loc2_.beginTm;
         mountModel.endTm = _loc2_.endTm;
         mountModel.mountLevel = _loc2_.mountLevel;
         mountModel.rebate = _loc2_.rebate;
         mountModel.toalCost = _loc2_.toalCost;
         mountModel.rebatePoint = _loc2_.rebatePoint;
         mountModel.complete = _loc2_.complete;
         NotificationManager.instance.sendNotification("REFRESH_MOUNT_ACT");
         if(_mountModel.toalCost <= 0 && MountsManager.instance.mountInfo && MountsManager.instance.mountInfo.grade != mountModel.mountLevel && model && model.data)
         {
            _loc3_ = 0;
            while(_loc3_ < model.data.length)
            {
               if((_model.data[_loc3_] as FunnyData).type == 62)
               {
                  mountFunnyData = model.data[_loc3_] as FunnyData;
                  model.data.splice(_loc3_,1);
                  break;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < model.data.length)
            {
               if((_model.data[_loc4_] as FunnyData).type == 62)
               {
                  return;
               }
               _loc4_++;
            }
            _model.data.push(mountFunnyData);
         }
      }
      
      private function __funnyTemHandler(param1:SLGSocketEvent) : void
      {
         var _loc11_:Array = null;
         var _loc23_:Array = null;
         var _loc21_:Array = null;
         var _loc8_:int = 0;
         var _loc15_:FunnyData = null;
         var _loc9_:int = 0;
         var _loc5_:FunnyBagData = null;
         var _loc6_:int = 0;
         var _loc3_:FunnyRewardData = null;
         var _loc7_:int = 0;
         var _loc19_:FunnyConditionData = null;
         var _loc10_:FunnyConditionData = null;
         var _loc17_:FunnyData = null;
         var _loc13_:PackageIn = param1.data as PackageIn;
         var _loc2_:SumActivesMsg = new SumActivesMsg();
         _loc2_ = _loc13_.readBody(_loc2_) as SumActivesMsg;
         if(_loc2_.dataStamp > version)
         {
            version = _loc2_.dataStamp;
            model.cleanData();
            total = 0;
         }
         total = total + 1;
         var _loc14_:Array = _loc2_.actives;
         var _loc24_:Number = 0;
         var _loc12_:Number = 0;
         var _loc4_:Number = 0;
         var _loc16_:Number = 0;
         var _loc18_:Boolean = false;
         var _loc20_:Boolean = false;
         model.topBagList = new Vector.<FunnyBagData>(4);
         _loc8_ = 0;
         for(; _loc8_ < _loc14_.length; _loc8_++)
         {
            if(DateFormatter.parse((_loc14_[_loc8_] as SumActiveinfoMsg).stopTime,"YYYY-MM-DD hh:mm:ss").getTime() >= playerModel.nowDate)
            {
               _loc15_ = new FunnyData();
               _loc15_.id = (_loc14_[_loc8_] as SumActiveinfoMsg).activeId;
               _loc15_.type = (_loc14_[_loc8_] as SumActiveinfoMsg).activeType;
               if(_loc15_.type == 15)
               {
                  if(DateFormatter.parse((_loc14_[_loc8_] as SumActiveinfoMsg).startTime,"YYYY-MM-DD hh:mm:ss").getTime() > playerModel.nowDate)
                  {
                     isNeed = true;
                     needTime = (_loc14_[_loc8_] as SumActiveinfoMsg).startTime;
                  }
                  else
                  {
                     isNeed = false;
                     needTime = "";
                  }
               }
               if(_loc15_.type == 49 || _loc15_.type == 51 || _loc15_.type == 186 || _loc15_.type == 197)
               {
                  _loc15_.appendParam = (_loc14_[_loc8_] as SumActiveinfoMsg).appendParam;
               }
               if(_loc15_.type == 62)
               {
                  MountActSocketOutManager.sendGetMountActInfo();
               }
               _loc15_.title = (_loc14_[_loc8_] as SumActiveinfoMsg).title;
               _loc15_.describe = (_loc14_[_loc8_] as SumActiveinfoMsg).detail;
               _loc15_.condition = (_loc14_[_loc8_] as SumActiveinfoMsg).conditionDetail;
               _loc15_.getWay = (_loc14_[_loc8_] as SumActiveinfoMsg).getway;
               _loc15_.startTime = DateFormatter.parse((_loc14_[_loc8_] as SumActiveinfoMsg).beginDate,"YYYY-MM-DD hh:mm:ss").getTime();
               _loc15_.endTime = DateFormatter.parse((_loc14_[_loc8_] as SumActiveinfoMsg).endDate,"YYYY-MM-DD hh:mm:ss").getTime();
               _loc15_.showStart = DateFormatter.parse((_loc14_[_loc8_] as SumActiveinfoMsg).startTime,"YYYY-MM-DD hh:mm:ss").getTime();
               _loc15_.showEnd = DateFormatter.parse((_loc14_[_loc8_] as SumActiveinfoMsg).stopTime,"YYYY-MM-DD hh:mm:ss").getTime();
               _loc15_.order = (_loc14_[_loc8_] as SumActiveinfoMsg).order;
               _loc15_.isInitiate = (_loc14_[_loc8_] as SumActiveinfoMsg).isInitiate;
               _loc11_ = (_loc14_[_loc8_] as SumActiveinfoMsg).packages;
               _loc9_ = 0;
               while(_loc9_ < _loc11_.length)
               {
                  _loc5_ = new FunnyBagData();
                  _loc5_.id = (_loc11_[_loc9_] as SumActivePackageMsg).packageId;
                  _loc5_.order = (_loc11_[_loc9_] as SumActivePackageMsg).order;
                  _loc5_.activeId = _loc15_.id;
                  _loc5_.getWay = _loc15_.getWay;
                  _loc23_ = (_loc11_[_loc9_] as SumActivePackageMsg).items;
                  _loc21_ = (_loc11_[_loc9_] as SumActivePackageMsg).conditions;
                  _loc6_ = 0;
                  while(_loc6_ < _loc23_.length)
                  {
                     _loc3_ = new FunnyRewardData();
                     _loc3_.temId = (_loc23_[_loc6_] as SumActiveItemInfoMsg).templateId;
                     _loc3_.temType = (_loc23_[_loc6_] as SumActiveItemInfoMsg).templateType;
                     _loc3_.count = (_loc23_[_loc6_] as SumActiveItemInfoMsg).count;
                     _loc3_.isBind = (_loc23_[_loc6_] as SumActiveItemInfoMsg).isbind;
                     _loc3_.strengthenGrade = (_loc23_[_loc6_] as SumActiveItemInfoMsg).length;
                     _loc3_.job = (_loc23_[_loc6_] as SumActiveItemInfoMsg).job;
                     _loc5_.rewardList.push(_loc3_);
                     _loc6_++;
                  }
                  _loc7_ = 0;
                  while(_loc7_ < _loc21_.length)
                  {
                     _loc19_ = new FunnyConditionData();
                     _loc19_.id = (_loc21_[_loc7_] as PackageConditionMsg).conditionId;
                     _loc19_.value = (_loc21_[_loc7_] as PackageConditionMsg).conditionValue;
                     _loc19_.bak = (_loc21_[_loc7_] as PackageConditionMsg).conditionBak;
                     _loc19_.bak2 = (_loc21_[_loc7_] as PackageConditionMsg).conditionBak2;
                     _loc19_.bak3 = (_loc21_[_loc7_] as PackageConditionMsg).conditionBak3;
                     _loc19_.bak4 = (_loc21_[_loc7_] as PackageConditionMsg).conditionBak4;
                     _loc5_.conditionList.push(_loc19_);
                     _loc7_++;
                  }
                  _loc5_.rewardList.sort(sortMasterType);
                  _loc15_.bagList.push(_loc5_);
                  if(_loc15_.type == 197 && _loc5_.conditionList.length > 0)
                  {
                     _loc10_ = _loc5_.conditionList[0];
                     if(_loc10_ && _loc10_.value == 1 && _loc10_.bak == _loc10_.bak2 && _loc10_.bak >= 1 && _loc10_.bak <= 3)
                     {
                        model.topBagList[_loc10_.bak] = _loc5_;
                     }
                  }
                  _loc9_++;
               }
               if(_loc15_.type == 2500)
               {
                  if(!isNowActive(_loc15_))
                  {
                     continue;
                  }
                  _loc15_.bagList.sort(byOrder);
                  model.continuePayRebateRewardData.push(_loc15_);
               }
               if(_loc15_.type == 2501)
               {
                  if(_loc15_.bagList.length != 3)
                  {
                     continue;
                  }
                  if(!isNowActive(_loc15_))
                  {
                     continue;
                  }
                  _loc15_.bagList.sort(byOrder);
                  model.continuePayRebateChestData.push(_loc15_);
               }
               if(_loc15_.type == 145)
               {
                  _godTreasureStart = DateFormatter.parse((_loc14_[_loc8_] as SumActiveinfoMsg).beginDate,"YYYY-MM-DD hh:mm:ss").getTime() + 120000;
                  _godTreasureEnd = DateFormatter.parse((_loc14_[_loc8_] as SumActiveinfoMsg).endDate,"YYYY-MM-DD hh:mm:ss").getTime();
               }
               if(model.isOtherType(_loc15_.type))
               {
                  if(_loc15_.type == 197)
                  {
                     model.showStartDate = _loc24_ = _loc15_.showStart;
                     model.showEndDate = _loc12_ = _loc15_.showEnd;
                     model.openDate = new Date(_loc15_.startTime);
                     model.endDate = new Date(_loc15_.endTime);
                     _loc18_ = true;
                  }
                  else if(_loc15_.type == 73)
                  {
                     model.showStartDate = _loc4_ = _loc15_.showStart;
                     model.showEndDate = _loc16_ = _loc15_.showEnd;
                     _loc15_.bagList.sort(sortByBak);
                     _loc20_ = true;
                  }
                  if(_loc18_ && _loc20_)
                  {
                     model.showStartDate = _loc24_ > _loc4_ ? _loc4_ : _loc24_;
                     model.showEndDate = _loc12_ > _loc16_ ? _loc12_ : _loc16_;
                     dispatchEvent(new FunnyEvent("CROSS_COST_TEMP"));
                  }
                  model.otherList[_loc15_.type].push(_loc15_);
               }
               else if(model.isTiroType(_loc15_.type) && _loc15_.isInitiate > 0)
               {
                  model.tiroFunnyList.push(_loc15_);
               }
               else
               {
                  model.data.push(_loc15_);
                  if(_loc15_.type == 4)
                  {
                     model.regression = _loc15_;
                  }
               }
            }
         }
         if(total >= _loc2_.maxPage)
         {
            _loc8_ = 0;
            while(_loc8_ < model.data.length)
            {
               model.data[_loc8_].bagList.sort(byOrder);
               _loc8_++;
            }
            _loc8_ = 0;
            while(_loc8_ < model.tiroFunnyList.length)
            {
               (model.tiroFunnyList[_loc8_] as FunnyData).bagList.sort(byOrder);
               _loc8_++;
            }
            for(var _loc22_:String in model.otherList)
            {
               _loc8_ = 0;
               while(_loc8_ < model.otherList[_loc22_].length)
               {
                  _loc17_ = model.otherList[_loc22_][_loc8_] as FunnyData;
                  if(_loc17_.type == 73)
                  {
                     _loc17_.bagList.sort(sortByBak);
                  }
                  else
                  {
                     _loc17_.bagList.sort(byOrder);
                  }
                  _loc8_++;
               }
            }
            if(model.findDataByType(51))
            {
               sendGetBag(3);
            }
            if(model.regressCharge)
            {
               model.data.push(model.regressCharge);
            }
            model.data.sort(byOrder);
            model.tiroFunnyList.sort(byOrder);
            model.continuePayRebateChestData.sort(byOrder);
            dispatchEvent(new FunnyEvent("REFRESH_TEMP"));
            sendGetBag(1);
         }
      }
      
      private function __funnyUserHandler(param1:SLGSocketEvent) : void
      {
         var _loc18_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc14_:FunnyData = null;
         var _loc9_:int = 0;
         var _loc19_:int = 0;
         var _loc12_:int = 0;
         var _loc4_:FunnyBagData = null;
         var _loc7_:KarnevalInfo = null;
         var _loc13_:PackageIn = param1.data as PackageIn;
         var _loc2_:SumActiveDataMsg = new SumActiveDataMsg();
         _loc2_ = _loc13_.readBody(_loc2_) as SumActiveDataMsg;
         var _loc15_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc16_:int = int(_loc2_.datas.length);
         _loc9_ = 0;
         while(_loc9_ < _loc16_)
         {
            if(_loc2_.datas[_loc9_])
            {
               _loc14_ = model.findFunnyDataByTypeAndId((_loc2_.datas[_loc9_] as ActiveData).type,(_loc2_.datas[_loc9_] as ActiveData).activeId);
               if(_loc14_ != null)
               {
                  _loc14_.anyToGet = false;
                  _loc14_.finishNum = (_loc2_.datas[_loc9_] as ActiveData).value;
                  _loc14_.type = (_loc2_.datas[_loc9_] as ActiveData).type;
                  _loc14_.canGet = (_loc2_.datas[_loc9_] as ActiveData).activeCharge;
                  _loc19_ = int((_loc2_.datas[_loc9_] as ActiveData).packdata.length);
                  _loc12_ = 0;
                  while(_loc12_ < _loc19_)
                  {
                     _loc4_ = findFunnyBagDataById(_loc14_,((_loc2_.datas[_loc9_] as ActiveData).packdata[_loc12_] as PackageData).packId);
                     if(_loc4_ != null)
                     {
                        _loc4_.status = ((_loc2_.datas[_loc9_] as ActiveData).packdata[_loc12_] as PackageData).status;
                        _loc4_.remainTime = ((_loc2_.datas[_loc9_] as ActiveData).packdata[_loc12_] as PackageData).countDown;
                        _loc4_.isShow = ((_loc2_.datas[_loc9_] as ActiveData).packdata[_loc12_] as PackageData).isShow;
                        _loc4_.param1 = ((_loc2_.datas[_loc9_] as ActiveData).packdata[_loc12_] as PackageData).param1;
                        _loc4_.finshCount = ((_loc2_.datas[_loc9_] as ActiveData).packdata[_loc12_] as PackageData).finishValue;
                        _loc4_.getCount = ((_loc2_.datas[_loc9_] as ActiveData).packdata[_loc12_] as PackageData).getCount;
                        if(_loc4_.status == 1)
                        {
                           if(_loc14_.type != 15 && _loc14_.type != 14 && _loc14_.type != 146)
                           {
                              _loc15_ = true;
                              _loc14_.anyToGet = true;
                           }
                           if(_loc14_.type == 73 || _loc14_.type == 197)
                           {
                              _loc5_ = true;
                              _loc14_.anyToGet = true;
                           }
                           if(_loc14_.type == 196 || _loc14_.type == 67)
                           {
                              _loc3_ = true;
                              _loc14_.anyToGet = true;
                           }
                        }
                        if(_loc14_.type == 4)
                        {
                           _regressionActiveId = _loc14_.id;
                           _regressionActiveCost = _loc14_.canGet;
                           if(_loc4_.status == 2)
                           {
                              _hasGetGift = true;
                           }
                        }
                        if(_loc14_.type == 51)
                        {
                           _loc14_.expenseList.splice(0,_loc14_.expenseList.length);
                           for each(var _loc6_:ConsumeInfoMsg in (_loc2_.datas[_loc9_] as ActiveData).consumeMsg)
                           {
                              _loc7_ = new KarnevalInfo();
                              _loc7_.userId = _loc6_.userId;
                              _loc7_.nickName = _loc6_.nickName;
                              _loc7_.order = _loc6_.order;
                              _loc7_.isVip = _loc6_.isVip;
                              _loc7_.point = _loc6_.point;
                              _loc14_.expenseList.push(_loc7_);
                           }
                           _loc14_.expenseList.sort(sortByOrder);
                           _loc17_ = true;
                        }
                        if(_loc14_.type == 197 || _loc14_.type == 73)
                        {
                           _loc10_ = true;
                        }
                        if(_loc14_.type == 73)
                        {
                           _loc11_ = true;
                        }
                        if(_loc14_.type == 231 || _loc14_.type == 131)
                        {
                           _loc8_ = true;
                        }
                        _loc18_ = true;
                     }
                     _loc12_++;
                  }
               }
            }
            _loc9_++;
         }
         model.setTimingStr();
         if(_loc15_ && model.canShine)
         {
            dispatchEvent(new FunnyEvent("ITEM_CANGET"));
         }
         if(_loc5_)
         {
            dispatchEvent(new FunnyEvent("CROSS_COSTITEM_CANGET"));
         }
         if(_loc3_)
         {
            dispatchEvent(new FunnyEvent("CROSS_PAY_CANGET"));
         }
         if(_needTipRegression && playerInfo.isBackPlayer && !_hasGetGift && model.regressionBagData)
         {
            _needTipRegression = false;
            DelayActionsUtils.instance.addAction(new AlertTipAction("",__regressionDelayHandler));
         }
         if(_loc10_)
         {
            dispatchEvent(new FunnyEvent("REFRESH_CROSSCOST_REWARD"));
         }
         if(_loc11_)
         {
            dispatchEvent(new FunnyEvent("REFRESH_NOTCROSSCOST_REWARD"));
         }
         if(_loc8_)
         {
            dispatchEvent(new FunnyEvent("LOGIN_ACTIVE_CHANGE"));
         }
         if(_loc17_)
         {
            dispatchEvent(new FunnyEvent("REFRESH_KARNEVAL"));
         }
         showTiroEffect();
         InfoTipsManager.instance.dealData(23);
         dispatchEvent(new FunnyEvent("REFRESH_ITEM"));
      }
      
      public function sortByBak(param1:FunnyBagData, param2:FunnyBagData) : int
      {
         if(param1.conditionList[0].bak < param2.conditionList[0].bak)
         {
            return -1;
         }
         if(param1.conditionList[0].bak > param2.conditionList[0].bak)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortByOrder(param1:KarnevalInfo, param2:KarnevalInfo) : int
      {
         if(param1.order < param2.order)
         {
            return -1;
         }
         if(param1.order > param2.order)
         {
            return 1;
         }
         return 0;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function findFunnyBagDataById(param1:FunnyData, param2:String) : FunnyBagData
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.bagList.length)
         {
            if(param1.bagList[_loc3_].id == param2)
            {
               return param1.bagList[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function sortMasterType(param1:Object, param2:Object) : int
      {
         var _loc5_:Object = null;
         var _loc3_:Object = null;
         var _loc4_:int = 0;
         if(param1.temType == 1)
         {
            _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.temId);
         }
         else
         {
            _loc5_ = TempleteManager.instance.starTempalteCate.getTemplateByID(param1.temId);
         }
         if(param2.temType == 1)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.temId);
         }
         else
         {
            _loc3_ = TempleteManager.instance.starTempalteCate.getTemplateByID(param2.temId);
         }
         if(_loc5_ && !_loc3_)
         {
            _loc4_ = -1;
         }
         else if(!_loc5_ && _loc3_)
         {
            _loc4_ = 1;
         }
         else if(!_loc5_ && !_loc3_)
         {
            _loc4_ = 0;
         }
         else if(_loc5_.Profile > _loc3_.Profile)
         {
            _loc4_ = -1;
         }
         else if(_loc5_.Profile < _loc3_.Profile)
         {
            _loc4_ = 1;
         }
         else if(_loc5_.MasterType > _loc3_.MasterType)
         {
            _loc4_ = 1;
         }
         else if(_loc5_.MasterType < _loc3_.MasterType)
         {
            _loc4_ = -1;
         }
         _loc5_ = null;
         _loc3_ = null;
         return _loc4_;
      }
      
      private function __regressionDelayHandler(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         var _loc2_:TipMessageData = new TipMessageData();
         _loc2_.type = 29;
         _loc2_.title = LanguageMgr.GetTranslation("public.prompt");
         TaskTraceTipManager.instance.cleanByType(29);
         TaskTraceTipManager.instance.showView(_loc2_);
         if(ModuleLoader.hasDefinition("asset.toptoolbar.regressionBack"))
         {
            showRegressView(null,null);
         }
         else
         {
            _loc4_ = ComponentSetting.getUISourcePath("toptoolbar");
            _loc3_ = 3;
            LoaderManagerII.instance.load(_loc4_,_loc3_,8,showRegressView);
         }
      }
      
      private function showRegressView(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:RegressionView = new RegressionView();
         _loc3_.show();
      }
      
      public function get selectedFunnyData() : FunnyData
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < model.data.length)
         {
            if(model.data[_loc1_] && model.data[_loc1_].id == selectedId)
            {
               return model.data[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function get selectedTiroFunnyDataType() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < model.tiroFunnyList.length)
         {
            if(model.tiroFunnyList[_loc1_].id == tiroFunnySelectedId)
            {
               return model.tiroFunnyList[_loc1_].type;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function byOrder(param1:Object, param2:Object) : int
      {
         if(param1.order < param2.order)
         {
            return -1;
         }
         if(param1.order == param2.order)
         {
            return 0;
         }
         if(param1.order > param2.order)
         {
            return 1;
         }
         return 0;
      }
      
      public function sendGetBag(param1:int, param2:String = "", param3:String = "", param4:int = 1) : void
      {
         var _loc6_:PackageOut = new PackageOut(8586);
         var _loc5_:SumActiveGetPackageMsg = new SumActiveGetPackageMsg();
         _loc5_.type = param1;
         _loc5_.activeId = param2;
         _loc5_.packageId = param3;
         _loc5_.count = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public function sedGetTiroBag(param1:int, param2:String = "", param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8586);
         var _loc4_:SumActiveGetPackageMsg = new SumActiveGetPackageMsg();
         _loc4_.activeId = tiroFunnySelectedId;
         _loc4_.type = param1;
         _loc4_.packageId = param2;
         _loc4_.count = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function set tiroFunnySelectedId(param1:String) : void
      {
         if(!param1 || _tiroFunnySelectedId == param1)
         {
            return;
         }
         _tiroFunnySelectedId = param1;
         dispatchEvent(new FunnyEvent("TIROITEM_CHANGE"));
      }
      
      public function get tiroFunnySelectedId() : String
      {
         return _tiroFunnySelectedId;
      }
      
      public function getTiroFunnyDataByActivityId() : FunnyData
      {
         var _loc1_:FunnyData = null;
         var _loc3_:int = 0;
         if(_tiroFunnySelectedId == "")
         {
            return null;
         }
         var _loc2_:int = int(model.tiroFunnyList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = model.tiroFunnyList[_loc3_] as FunnyData;
            if(_loc1_.id == _tiroFunnySelectedId)
            {
               return model.tiroFunnyList[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function showTiroEffect() : void
      {
         var _loc2_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:FunnyBagData = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = int(model.tiroFunnyList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = (model.tiroFunnyList[_loc3_] as FunnyData).bagList;
            _loc5_ = int(_loc2_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = _loc2_[_loc4_];
               if(_loc6_.status == 1)
               {
                  dispatchEvent(new FunnyEvent("SHOWTIROEFFECT"));
                  break;
               }
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function set isNeed(param1:Boolean) : void
      {
         if(isNeed != param1)
         {
            _isNeed = param1;
         }
      }
      
      public function get isNeed() : Boolean
      {
         return _isNeed;
      }
      
      public function set godTreasureStart(param1:Number) : void
      {
         if(godTreasureStart != param1)
         {
            _godTreasureStart = param1;
         }
      }
      
      public function get godTreasureStart() : Number
      {
         return _godTreasureStart;
      }
      
      public function set godTreasureEnd(param1:Number) : void
      {
         if(godTreasureEnd != param1)
         {
            _godTreasureEnd = param1;
         }
      }
      
      public function get godTreasureEnd() : Number
      {
         return _godTreasureEnd;
      }
      
      public function sendReturnOption(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8860);
         var _loc3_:ReturnOptionMsg = new ReturnOptionMsg();
         _loc3_.optionType = param1;
         _loc3_.param1 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function sendGetActiveBagStatus(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc7_:ActiveInfo = null;
         var _loc4_:ActiveInfoMsg = null;
         var _loc8_:PackageOut = new PackageOut(5049);
         var _loc2_:QueryActiveMsg = new QueryActiveMsg();
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         if(param1)
         {
            _loc5_ = int(param1.length);
         }
         if(_loc5_ <= 0)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc7_ = param1[_loc6_] as ActiveInfo;
            _loc4_ = new ActiveInfoMsg();
            _loc4_.activeId = _loc7_.activeId;
            _loc3_.push(_loc4_);
            _loc6_++;
         }
         _loc2_.actives = _loc3_;
         SocketManager.instance.socket.sendProtobuffer(_loc8_,_loc2_);
      }
      
      private function isNowActive(param1:FunnyData) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.showStart <= playerModel.nowDate && param1.showEnd >= playerModel.nowDate)
         {
            return true;
         }
         return false;
      }
   }
}

