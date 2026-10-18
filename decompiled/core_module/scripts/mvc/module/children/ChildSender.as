package mvc.module.children
{
   import com.road.yishi.proto.children.ChildrenOpMsg;
   import com.road.yishi.proto.guardpvp.GuardPvpListMsg;
   import com.road.yishi.proto.guardpvp.GuardPvpPosMsg;
   import com.road.yishi.proto.item.CommonItemMsg;
   import com.road.yishi.proto.item.SellItemMsg;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildSender
   {
      
      public static const OP_APPLY:int = 1;
      
      public static const OP_DESTORY:int = 2;
      
      public static const OP_FEED:int = 3;
      
      public static const OP_RESET_POINT:int = 4;
      
      public static const OP_JOB:int = 5;
      
      public static const OP_ENTER_WAR:int = 6;
      
      public static const OP_REST:int = 7;
      
      public static const OP_LEARN_SKILL:int = 8;
      
      public static const OP_UPGRADE_SKILL:int = 9;
      
      public static const OP_UP_GROWGH_VALUE:int = 10;
      
      public static const OP_MOOD:int = 11;
      
      public static const OP_SEX:int = 12;
      
      public static const CONFIRM_DESTORY:int = 13;
      
      public static const APT_RESET_ITEM:int = 14;
      
      public static const REFRESH_FEED_ITEM:int = 15;
      
      public static const CARRY_SKILL:int = 16;
      
      public static const SET_FIRST_POS:int = 22;
      
      public static const ACTIVE_EMBLEM:int = 17;
      
      public static const UPGRADE_EMBLEM:int = 18;
      
      public static const SELECT_PROPERTY:int = 19;
      
      public static const CHANGE_PROPERTY:int = 20;
      
      public static const UP_PROPERTY:int = 21;
      
      public static const UP_EXCHANGE_PROPERTY:int = 23;
      
      public static const SELL_CHILD:int = 24;
      
      public static const OP_SOUL_FEED:int = 25;
      
      public static const OP_CALL:int = 26;
      
      public static const OP_SWITCH:int = 27;
      
      public static const SPIRIT_COMPOSE:int = 28;
      
      public static const SPIRIT_UPGRADE:int = 29;
      
      public static const EMBLEM_UPGRADE:int = 30;
      
      public static const RESI_UPGRADE:int = 31;
      
      public static const REDUCE_RESI_UPGRADE:int = 32;
      
      public static const NS_SKILL_LEARN:int = 33;
      
      public static const NS_SKILL_UPGRADE:int = 34;
      
      public static const SPIRIT_LIFE_WHEEL_ROLL:int = 35;
      
      public static const SPIRIT_TALENT_UPGRADE:int = 36;
      
      public static const SPIRIT_TALENT_UPGRADE_SKILL:int = 37;
      
      public static const SPIRIT_TALENT_RESET_POINT:int = 38;
      
      public static const AWAKE_SKILL_UPGRADE:int = 39;
      
      public static const SPIRIT_ARTIFACT_EQUIP:int = 40;
      
      public static const SPIRIT_ARTIFACT_INJECT:int = 41;
      
      public static const SPIRIT_ARTIFACT_REFRESH:int = 42;
      
      public static const SPIRIT_ARTIFACT_ENCHANT:int = 43;
      
      public static const CHILD_ASSIST_AWAKE:int = 50;
      
      public static const SPIRIT_OPEN_TRAIN:int = 44;
      
      public static const SPIRIT_TRAIN:int = 45;
      
      public static const SPIRIT_TRAIN_UPGRADE:int = 46;
      
      public static const SPIRIT_TRAIN_ADD_POINT:int = 47;
      
      public static const SPIRIT_TRAIN_SKILL_UPGRADE:int = 48;
      
      public static const SPIRIT_TRAIN_SKILL_REFRESH:int = 49;
      
      public static const STRENGHT:int = 1;
      
      public static const UPGRADE:int = 2;
      
      public static const OPENING:int = 3;
      
      public static const MOSAIC:int = 4;
      
      public static const REFRESH:int = 5;
      
      public static const CONFIRM_REFRESH:int = 6;
      
      public static const MOVE:int = 7;
      
      public static const SELL:int = 8;
      
      private static var _childApplyItem:ConfigInfosTempInfo = null;
      
      public function ChildSender()
      {
         super();
      }
      
      public static function getChildApplyItemId() : int
      {
         if(!_childApplyItem)
         {
            _childApplyItem = TempleteManager.instance.getConfigInfoByConfigName("child_apply_item");
         }
         return int(_childApplyItem.ConfigValue.split(",")[0]);
      }
      
      public static function getChildApplyItemCount() : int
      {
         if(!_childApplyItem)
         {
            _childApplyItem = TempleteManager.instance.getConfigInfoByConfigName("child_apply_item");
         }
         return int(_childApplyItem.ConfigValue.split(",")[1]);
      }
      
      public static function emblemActive(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 17;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function emblemUp(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 18;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function emblemChange(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(8868);
         var _loc5_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc5_.opType = 20;
         _loc5_.property1 = param1;
         _loc5_.property2 = param2;
         _loc5_.property6 = param3;
         _loc5_.property7 = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function emblemExchange(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(8868);
         var _loc5_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc5_.opType = 23;
         _loc5_.property1 = param1;
         _loc5_.property2 = param2;
         _loc5_.property6 = param3;
         _loc5_.property7 = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function emblemSelect(param1:int, param2:int, param3:Array) : void
      {
         var _loc5_:PackageOut = new PackageOut(8868);
         var _loc4_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc4_.opType = 19;
         _loc4_.property1 = param1;
         _loc4_.property2 = param2;
         _loc4_.poses = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function emblemUpProperty(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(8868);
         var _loc5_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc5_.opType = 21;
         _loc5_.property1 = param1;
         _loc5_.property2 = param2;
         _loc5_.property6 = param3;
         _loc5_.property7 = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function pickChild(param1:int) : void
      {
         var _loc7_:String = null;
         var _loc5_:String = null;
         var _loc4_:int = 0;
         _loc4_ = getChildApplyItemCount();
         _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(getChildApplyItemId()).TemplateName;
         _loc7_ = LanguageMgr.GetTranslation("child.checkForExchangeChild",_loc4_,_loc5_);
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [pickChildCall,_loc4_,param1];
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,false,true);
      }
      
      private static function pickChildCall(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         if(param1)
         {
            if(GoodsManager.instance.getGoodsNumByTempId(2131140) < param3)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("mvc.module.children.ChildSender.pickChildCall.goldNotEnough5"));
               return;
            }
            applyChild(0);
         }
      }
      
      public static function applyChild(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 1;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function removeChild(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 2;
         _loc2_.property3 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function confirmRemoveChild(param1:Boolean) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 13;
         _loc2_.property5 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function refreshFeedItem(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 15;
         _loc3_.property1 = param1;
         if(param2)
         {
            _loc3_.payType = 0;
         }
         else
         {
            _loc3_.payType = 1;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function fosterApt(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8868);
         var _loc4_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc4_.opType = 3;
         _loc4_.property1 = param1;
         _loc4_.property2 = param2;
         _loc4_.property6 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function fosterMood(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8868);
         var _loc4_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc4_.opType = 11;
         _loc4_.property1 = param1;
         _loc4_.property2 = param2;
         _loc4_.property6 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function useResetGoods(param1:int, param2:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 14;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function resetPoint(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 4;
         _loc3_.property1 = param1;
         _loc3_.property3 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function choiceSex(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 12;
         _loc3_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function selectJob(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 5;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function rest(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 7;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function learnSkill(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8868);
         var _loc4_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc4_.opType = 8;
         _loc4_.property1 = param1;
         _loc4_.property2 = param2;
         _loc4_.property6 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function upgradeSkill(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8868);
         var _loc4_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc4_.opType = 9;
         _loc4_.property1 = param1;
         _loc4_.property2 = param2;
         _loc4_.property6 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function carrySkill(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 16;
         _loc3_.property1 = param1;
         _loc3_.property3 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function upGrowthValue(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 10;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function intensifyAndUpgradeEquip(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8869);
         var _loc4_:CommonItemMsg = new CommonItemMsg();
         _loc4_.opType = param1;
         _loc4_.composeId = param2;
         _loc4_.payType = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function insertJewel(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8869);
         var _loc4_:CommonItemMsg = new CommonItemMsg();
         _loc4_.opType = 4;
         _loc4_.endPos = param1;
         _loc4_.beginPos = param2;
         _loc4_.beginBagType = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function openHole(param1:int, param2:Boolean, param3:Boolean = true) : void
      {
         var _loc5_:PackageOut = new PackageOut(8869);
         var _loc4_:CommonItemMsg = new CommonItemMsg();
         _loc4_.opType = 3;
         _loc4_.holePos = param1;
         _loc4_.operate = param2;
         if(param3)
         {
            _loc4_.payType = 0;
         }
         else
         {
            _loc4_.payType = 1;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function refreshEquip(param1:Array, param2:int = 0, param3:int = 0, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(8869);
         var _loc5_:CommonItemMsg = new CommonItemMsg();
         _loc5_.opType = 5;
         _loc5_.lock = param1;
         _loc5_.bindType = param2;
         _loc5_.payType = param3;
         _loc5_.materialPayType = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc5_);
      }
      
      public static function confirmRefreshEquip() : void
      {
         var _loc2_:PackageOut = new PackageOut(8869);
         var _loc1_:CommonItemMsg = new CommonItemMsg();
         _loc1_.opType = 6;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      public static function moveBagToBag(param1:int, param2:int, param3:int, param4:int, param5:int = 0, param6:int = 1) : void
      {
         var _loc8_:PackageOut = new PackageOut(8869);
         var _loc7_:CommonItemMsg = new CommonItemMsg();
         _loc7_.opType = 7;
         _loc7_.beginBagType = param1;
         _loc7_.beginPos = param2;
         _loc7_.endBagType = param3;
         _loc7_.endPos = param4;
         _loc7_.objectId = param5;
         _loc7_.count = param6;
         SocketManager.instance.socket.sendProtobuffer(_loc8_,_loc7_);
      }
      
      public static function sellEquip(param1:int, param2:int, param3:int = 1) : void
      {
         var _loc6_:PackageOut = new PackageOut(8869);
         var _loc4_:CommonItemMsg = new CommonItemMsg();
         _loc4_.opType = 8;
         var _loc5_:SellItemMsg = new SellItemMsg();
         _loc5_.pos = param1;
         _loc5_.count = param3;
         _loc5_.id = param2;
         _loc4_.sellItem.push(_loc5_);
         SocketManager.instance.socket.sendProtobuffer(_loc6_,_loc4_);
      }
      
      public static function sellChild(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 24;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function callChild(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 26;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function awakeUpgradeChild(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 25;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function setEnterWar(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 6;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function setChildAssist(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 50;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function switchChild(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 27;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function composeChild(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8868);
         var _loc4_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc4_.opType = 28;
         _loc4_.property1 = param1;
         _loc4_.property6 = param2;
         _loc4_.property7 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function nsUpGrowthValue(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8868);
         var _loc4_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc4_.opType = param1;
         _loc4_.property1 = param2;
         _loc4_.property2 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function nsUpgradeSkill(param1:int, param2:int, param3:int, param4:int, param5:int = 0) : void
      {
         var _loc7_:PackageOut = new PackageOut(8868);
         var _loc6_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc6_.opType = param1;
         _loc6_.property1 = param2;
         _loc6_.property2 = param3;
         _loc6_.property6 = param4;
         _loc6_.property7 = param5;
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc6_);
      }
      
      public static function nsUpgradeTalent(param1:int, param2:int, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(8868);
         var _loc4_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc4_.opType = param1;
         _loc4_.property1 = param2;
         _loc4_.property2 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function nsLifeWheelTurn(param1:int, param2:int, param3:String, param4:Boolean, param5:int) : void
      {
         var _loc7_:PackageOut = new PackageOut(8868);
         var _loc6_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc6_.opType = 35;
         _loc6_.payType = param2;
         _loc6_.property1 = param1;
         _loc6_.property2 = param5;
         _loc6_.property3 = param3;
         _loc6_.property5 = param4;
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc6_);
      }
      
      public static function nsUpgradeAwakeSkill(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 39;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function setChildArenaPos(param1:Array = null) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:GuardPvpPosMsg = null;
         var _loc7_:PackageOut = new PackageOut(9657);
         var _loc2_:GuardPvpListMsg = new GuardPvpListMsg();
         _loc2_.guardPvpOp = 3;
         if(param1)
         {
            _loc4_ = int(param1.length);
            _loc3_ = [];
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = new GuardPvpPosMsg();
               _loc6_.param1 = param1[_loc5_].childId;
               _loc6_.param2 = param1[_loc5_].attackPos;
               _loc6_.param3 = param1[_loc5_].standPos;
               _loc3_.push(_loc6_);
               _loc5_ += 1;
            }
            _loc2_.guardPos = _loc3_;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc2_);
      }
      
      public static function requestChildArenaOp(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9657);
         var _loc3_:GuardPvpListMsg = new GuardPvpListMsg();
         _loc3_.guardPvpOp = param1;
         if(param1 == 2)
         {
            _loc3_.teamType = param2;
         }
         else if(param1 == 7)
         {
            _loc3_.betWinCount = param2;
         }
         else if(param1 == 9)
         {
            _loc3_.autoTeamType = param2;
         }
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function nsTreasureMostEquip(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 40;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function nsTreasureMostCharge(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 41;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function nsTreasureMostRefresh(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8868);
         var _loc2_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc2_.opType = 42;
         _loc2_.property1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function nsTreasureMostEnchant(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8868);
         var _loc3_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc3_.opType = 43;
         _loc3_.property1 = param1;
         _loc3_.property2 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function nsTrainOp(param1:int, param2:int = -1, param3:int = -1) : void
      {
         var _loc5_:PackageOut = new PackageOut(8868);
         var _loc4_:ChildrenOpMsg = new ChildrenOpMsg();
         _loc4_.opType = param1;
         _loc4_.property1 = param2;
         _loc4_.property2 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
   }
}

