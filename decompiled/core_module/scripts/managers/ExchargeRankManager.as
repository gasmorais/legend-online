package managers
{
   import com.road.yishi.proto.active.ActiveData;
   import com.road.yishi.proto.active.ChargeRewardMsg;
   import com.road.yishi.proto.active.PackageConditionMsg;
   import com.road.yishi.proto.active.PackageData;
   import com.road.yishi.proto.active.SumActiveDataMsg;
   import com.road.yishi.proto.active.SumActiveGetPackageMsg;
   import com.road.yishi.proto.active.SumActiveItemInfoMsg;
   import com.road.yishi.proto.active.SumActivePackageMsg;
   import com.road.yishi.proto.active.SumActiveinfoMsg;
   import com.road.yishi.proto.active.SumActivesMsg;
   import flash.events.EventDispatcher;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyConditionData;
   import funny.datas.FunnyRewardData;
   import mvc.module.exchargerank.ExchargeData;
   import mvc.module.exchargerank.ExchargeRankModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.InfoTipsManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   
   public class ExchargeRankManager extends EventDispatcher
   {
      
      private static var _instance:ExchargeRankManager;
      
      private var _model:ExchargeRankModel;
      
      public var selectedId:String = "";
      
      public var _chargeNumber:int;
      
      public var _dayTotalCount:int;
      
      public var _myTotalCount:int;
      
      public var _isOpen:Boolean;
      
      public function ExchargeRankManager()
      {
         super();
         _model = FrameControllerManager.instance.exchargeAllControler.model;
      }
      
      public static function get instance() : ExchargeRankManager
      {
         if(!_instance)
         {
            _instance = new ExchargeRankManager();
         }
         return _instance;
      }
      
      public static function sendPointMsg() : void
      {
         var _loc1_:PackageOut = new PackageOut(8866);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      public function get model() : ExchargeRankModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4475,__exchargeRankTempHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4476,__exchargeRankUserHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4745,__exchargeNumberHandler);
      }
      
      private function __exchargeNumberHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ChargeRewardMsg = new ChargeRewardMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ChargeRewardMsg;
         _chargeNumber = _loc2_.totalCount;
         _dayTotalCount = _loc2_.dayTotalCount;
         _myTotalCount = _loc2_.myTotalCount;
      }
      
      private function __exchargeRankTempHandler(param1:SLGSocketEvent) : void
      {
         var _loc13_:Array = null;
         var _loc21_:Array = null;
         var _loc20_:Array = null;
         var _loc9_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc12_:int = 0;
         var _loc10_:int = 0;
         var _loc19_:ExchargeData = null;
         var _loc11_:int = 0;
         var _loc6_:FunnyBagData = null;
         var _loc7_:int = 0;
         var _loc5_:FunnyRewardData = null;
         var _loc8_:int = 0;
         var _loc18_:FunnyConditionData = null;
         var _loc14_:PackageIn = param1.data as PackageIn;
         var _loc2_:SumActivesMsg = new SumActivesMsg();
         _loc2_ = _loc14_.readBody(_loc2_) as SumActivesMsg;
         var _loc15_:Array = _loc2_.actives;
         _loc16_ = 0;
         while(_loc16_ < _loc15_.length)
         {
            if((_loc15_[_loc16_] as SumActiveinfoMsg).activeType == 66)
            {
               _loc3_++;
            }
            if((_loc15_[_loc16_] as SumActiveinfoMsg).activeType == 67)
            {
               _loc4_++;
            }
            _loc16_++;
         }
         if(_loc3_ > 1)
         {
            _loc17_ = 0;
            while(_loc17_ < _loc15_.length)
            {
               if((_loc15_[_loc17_] as SumActiveinfoMsg).activeType == 66)
               {
                  _loc15_.splice(_loc17_,1);
               }
               _loc17_++;
            }
         }
         if(_loc4_ > 1)
         {
            _loc12_ = 0;
            while(_loc12_ < _loc15_.length)
            {
               if((_loc15_[_loc12_] as SumActiveinfoMsg).activeType == 67)
               {
                  _loc15_.splice(_loc12_,1);
               }
               _loc12_++;
            }
         }
         model.data = new Vector.<ExchargeData>();
         model.topBagList = new Vector.<FunnyBagData>(4);
         _loc10_ = 0;
         while(_loc10_ < _loc15_.length)
         {
            if(DateFormatter.parse((_loc15_[_loc10_] as SumActiveinfoMsg).stopTime,"YYYY-MM-DD hh:mm:ss").getTime() >= playerModel.nowDate)
            {
               _loc19_ = new ExchargeData();
               _loc19_.id = (_loc15_[_loc10_] as SumActiveinfoMsg).activeId;
               _loc19_.type = (_loc15_[_loc10_] as SumActiveinfoMsg).activeType;
               if(_loc19_.type == 196 || _loc19_.type == 67)
               {
                  _isOpen = true;
                  if(_loc19_.type == 67)
                  {
                     sendPointMsg();
                  }
                  _loc19_.title = (_loc15_[_loc10_] as SumActiveinfoMsg).title;
                  _loc19_.describe = (_loc15_[_loc10_] as SumActiveinfoMsg).detail;
                  _loc19_.condition = (_loc15_[_loc10_] as SumActiveinfoMsg).conditionDetail;
                  _loc19_.getWay = (_loc15_[_loc10_] as SumActiveinfoMsg).getway;
                  _loc19_.startTime = DateFormatter.parse((_loc15_[_loc10_] as SumActiveinfoMsg).beginDate,"YYYY-MM-DD hh:mm:ss").getTime();
                  _loc19_.endTime = DateFormatter.parse((_loc15_[_loc10_] as SumActiveinfoMsg).endDate,"YYYY-MM-DD hh:mm:ss").getTime();
                  _loc19_.showStart = DateFormatter.parse((_loc15_[_loc10_] as SumActiveinfoMsg).startTime,"YYYY-MM-DD hh:mm:ss").getTime();
                  _loc19_.showEnd = DateFormatter.parse((_loc15_[_loc10_] as SumActiveinfoMsg).stopTime,"YYYY-MM-DD hh:mm:ss").getTime();
                  _loc19_.order = (_loc15_[_loc10_] as SumActiveinfoMsg).order;
                  _loc19_.isInitiate = (_loc15_[_loc10_] as SumActiveinfoMsg).isInitiate;
                  _loc13_ = (_loc15_[_loc10_] as SumActiveinfoMsg).packages;
                  _loc11_ = 0;
                  while(_loc11_ < _loc13_.length)
                  {
                     _loc6_ = new FunnyBagData();
                     _loc6_.id = (_loc13_[_loc11_] as SumActivePackageMsg).packageId;
                     _loc6_.order = (_loc13_[_loc11_] as SumActivePackageMsg).order;
                     _loc6_.activeId = _loc19_.id;
                     _loc6_.getWay = _loc19_.getWay;
                     _loc21_ = (_loc13_[_loc11_] as SumActivePackageMsg).items;
                     _loc20_ = (_loc13_[_loc11_] as SumActivePackageMsg).conditions;
                     _loc7_ = 0;
                     while(_loc7_ < _loc21_.length)
                     {
                        _loc5_ = new FunnyRewardData();
                        _loc5_.temId = (_loc21_[_loc7_] as SumActiveItemInfoMsg).templateId;
                        _loc5_.temType = (_loc21_[_loc7_] as SumActiveItemInfoMsg).templateType;
                        _loc5_.count = (_loc21_[_loc7_] as SumActiveItemInfoMsg).count;
                        _loc5_.isBind = (_loc21_[_loc7_] as SumActiveItemInfoMsg).isbind;
                        _loc5_.strengthenGrade = (_loc21_[_loc7_] as SumActiveItemInfoMsg).length;
                        _loc5_.job = (_loc21_[_loc7_] as SumActiveItemInfoMsg).job;
                        _loc6_.rewardList.push(_loc5_);
                        _loc7_++;
                     }
                     _loc8_ = 0;
                     while(_loc8_ < _loc20_.length)
                     {
                        _loc18_ = new FunnyConditionData();
                        _loc18_.id = (_loc20_[_loc8_] as PackageConditionMsg).conditionId;
                        _loc18_.value = (_loc20_[_loc8_] as PackageConditionMsg).conditionValue;
                        _loc18_.bak = (_loc20_[_loc8_] as PackageConditionMsg).conditionBak;
                        _loc18_.bak2 = (_loc20_[_loc8_] as PackageConditionMsg).conditionBak2;
                        _loc18_.bak3 = (_loc20_[_loc8_] as PackageConditionMsg).conditionBak3;
                        _loc18_.bak4 = (_loc20_[_loc8_] as PackageConditionMsg).conditionBak4;
                        _loc6_.conditionList.push(_loc18_);
                        _loc8_++;
                     }
                     _loc19_.bagList.push(_loc6_);
                     if(_loc19_.type == 196 && _loc6_.conditionList.length > 0 && _loc6_.conditionList[0].bak == _loc6_.conditionList[0].bak2 && _loc6_.conditionList[0].bak >= 1 && _loc6_.conditionList[0].bak <= 3)
                     {
                        model.topBagList[_loc6_.conditionList[0].bak] = _loc6_;
                     }
                     _loc11_++;
                  }
                  _loc19_.bagList.sort(sortFunction);
                  if(_loc19_.type == 67)
                  {
                     changeItem(_loc19_);
                  }
                  model.data.push(_loc19_);
               }
            }
            _loc10_++;
         }
         dispatchEvent(new FunnyEvent("EXCHARGE_RANK"));
      }
      
      private function sortFunction(param1:FunnyBagData, param2:FunnyBagData) : Number
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
      
      private function changeItem(param1:ExchargeData) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Vector.<FunnyBagData> = new Vector.<FunnyBagData>();
         _loc2_.push(new FunnyBagData());
         _loc2_.push(new FunnyBagData());
         _loc2_.push(new FunnyBagData());
         _loc3_ = 0;
         while(_loc3_ < param1.bagList.length)
         {
            _loc4_ = (param1.bagList[_loc3_] as FunnyBagData).conditionList[0].bak - 1;
            _loc2_[_loc4_] = param1.bagList[_loc3_];
            _loc3_++;
         }
         param1.bagList = _loc2_;
      }
      
      private function __exchargeRankUserHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc7_:ExchargeData = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:FunnyBagData = null;
         var _loc11_:PackageIn = param1.data as PackageIn;
         var _loc2_:SumActiveDataMsg = new SumActiveDataMsg();
         _loc2_ = _loc11_.readBody(_loc2_) as SumActiveDataMsg;
         var _loc12_:Boolean = false;
         var _loc3_:int = int(_loc2_.datas.length);
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            if(_loc2_.datas[_loc8_])
            {
               _loc7_ = model.findExchargeDataByTypeAndId((_loc2_.datas[_loc8_] as ActiveData).type,(_loc2_.datas[_loc8_] as ActiveData).activeId);
               if(_loc7_ != null)
               {
                  _loc7_.anyToGet = false;
                  _loc7_.finishNum = (_loc2_.datas[_loc8_] as ActiveData).value;
                  _loc7_.type = (_loc2_.datas[_loc8_] as ActiveData).type;
                  _loc7_.canGet = (_loc2_.datas[_loc8_] as ActiveData).activeCharge;
                  _loc9_ = int((_loc2_.datas[_loc8_] as ActiveData).packdata.length);
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     _loc5_ = findFunnyBagDataById(_loc7_,((_loc2_.datas[_loc8_] as ActiveData).packdata[_loc10_] as PackageData).packId);
                     if(_loc5_ != null)
                     {
                        _loc5_.status = ((_loc2_.datas[_loc8_] as ActiveData).packdata[_loc10_] as PackageData).status;
                        _loc5_.remainTime = ((_loc2_.datas[_loc8_] as ActiveData).packdata[_loc10_] as PackageData).countDown;
                        _loc5_.isShow = ((_loc2_.datas[_loc8_] as ActiveData).packdata[_loc10_] as PackageData).isShow;
                        _loc5_.param1 = ((_loc2_.datas[_loc8_] as ActiveData).packdata[_loc10_] as PackageData).param1;
                        _loc5_.finshCount = ((_loc2_.datas[_loc8_] as ActiveData).packdata[_loc10_] as PackageData).finishValue;
                        _loc5_.getCount = ((_loc2_.datas[_loc8_] as ActiveData).packdata[_loc10_] as PackageData).getCount;
                        if(_loc5_.status == 1)
                        {
                           _loc12_ = true;
                           _loc7_.anyToGet = true;
                        }
                        _loc6_ = true;
                     }
                     _loc10_++;
                  }
               }
            }
            _loc8_++;
         }
         if(_loc6_)
         {
            dispatchEvent(new FunnyEvent("REFRESH_ITEM"));
         }
         InfoTipsManager.instance.dealData(23);
      }
      
      private function findFunnyBagDataById(param1:ExchargeData, param2:String) : FunnyBagData
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
      
      public function sendInitBagData(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8586);
         var _loc2_:SumActiveGetPackageMsg = new SumActiveGetPackageMsg();
         _loc2_.type = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
   }
}

