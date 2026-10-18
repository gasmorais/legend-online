package map.space.helper.hero
{
   import flash.geom.Point;
   import managers.RingTaskManager;
   import map.campaign.CampaignManager;
   import map.internals.data.SpaceNode;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.data.SpaceArmy;
   import map.space.event.SpaceEvent;
   import map.space.helper.npcai.SpaceNpcAttackHelper;
   import map.space.manager.SpaceSocketOutManager;
   import map.space.view.physics.SpaceNpcView;
   import mvc.module.ringtask.RingTask;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class SpaceArmyViewHelper
   {
      
      public static const VISIBLE_RANGE:int = 1000;
      
      public function SpaceArmyViewHelper()
      {
         super();
      }
      
      public static function robotVisibleTest(param1:int, param2:int) : Boolean
      {
         var _loc3_:SpaceArmy = null;
         var _loc5_:Object = null;
         var _loc4_:Point = model.nextPoint;
         if(!_loc4_)
         {
            _loc3_ = model.selfArmy;
            if(!_loc3_)
            {
               return false;
            }
            _loc5_ = CampaignManager.instance.controller.getArmyView(_loc3_);
            if(!_loc5_)
            {
               return false;
            }
            _loc4_ = new Point(_loc5_.x,_loc5_.y);
         }
         var _loc6_:Point = new Point(param1,param2);
         var _loc7_:int = Point.distance(_loc4_,_loc6_);
         if(_loc7_ <= 1000)
         {
            return true;
         }
         return false;
      }
      
      public static function visitNode(param1:SpaceNode) : void
      {
         var _loc6_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:SpaceArmy = null;
         var _loc3_:Point = null;
         var _loc4_:Object = SpaceManager.instance.controller.getArmyView(model.selfArmy);
         if(param1 == model.selectNode && getNodeInRange(_loc4_))
         {
            nodeTrigger(param1);
         }
         else
         {
            if(model.selectNode)
            {
               if(model.selectNode.dialogue)
               {
                  FrameControllerManager.instance.spaceController.closeFrame();
               }
               if(model.selectNode.param3)
               {
                  _loc6_ = model.selectNode.param3.split(",");
                  _loc5_ = int(_loc6_[0]);
                  SpaceArmyViewHelper.closeNodeFrame(_loc5_);
               }
               model.checkNodeId = -1;
            }
            model.selectNode = param1;
            _loc2_ = model.selfArmy;
            if(param1.info.types == 1)
            {
               _loc3_ = SpaceNpcAttackHelper.getAttackPoint(param1,new Point(_loc4_.x,_loc4_.y),new Point(param1.x,param1.y));
            }
            else
            {
               _loc3_ = new Point(param1.x,param1.y);
            }
            SpaceManager.instance.controller.moveArmyByPos(_loc3_.x,_loc3_.y);
         }
      }
      
      public static function selfArmyToEnd(param1:BaseArmyAiInfo, param2:Object) : Boolean
      {
         var _loc3_:SpaceNode = getNodeInRange(param2);
         if(!_loc3_)
         {
            _loc3_ = model.getHandlerNode(viewPosXToInfoPosX(param2.x),viewPosYToInfoPosY(param2.y));
            if(_loc3_ && _loc3_.param1 != 2)
            {
               return false;
            }
         }
         if(!_loc3_)
         {
            return false;
         }
         nodeTrigger(_loc3_);
         return true;
      }
      
      private static function nodeTrigger(param1:SpaceNode) : void
      {
         var _loc2_:Object = null;
         var _loc4_:SpaceArmy = null;
         var _loc6_:Object = null;
         var _loc3_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:RingTask = null;
         var _loc5_:OfferRewardConditionTemplate = null;
         var _loc9_:Array = param1.param3.split(",");
         if(param1.info.types == 1)
         {
            _loc2_ = SpaceManager.instance.controller.getNpcView(param1);
            _loc4_ = model.selfArmy;
            _loc6_ = SpaceManager.instance.controller.getArmyView(_loc4_);
            _loc3_ = new Point(_loc2_.x,_loc2_.y);
            _loc7_ = Math.atan2(_loc3_.y - _loc6_.y,_loc3_.x - _loc6_.x);
            _loc8_ = _loc7_ * 180 / 3.141592653589793;
            if(_loc8_ < 0)
            {
               _loc8_ += 360;
            }
            if(_loc2_ is SpaceNpcView)
            {
               _loc2_.avatarView.angle = _loc8_;
               _loc2_.aiInfo.moveState = 3;
            }
            else
            {
               _loc2_.angle = _loc8_;
               _loc2_.aiInfo.moveState = 3;
               _loc2_.action("S",_loc2_.currentDirection);
            }
            NotificationManager.instance.dispatchEvent(new SpaceEvent("SELECT_NODE",param1.info.id));
         }
         else
         {
            if(_loc9_[0] == "12")
            {
               _loc10_ = RingTaskManager.instance.getRingTask();
               if(!_loc10_)
               {
                  return;
               }
               _loc5_ = _loc10_.conditionList[0] as OfferRewardConditionTemplate;
               if(_loc5_.CondictionType != 4)
               {
                  return;
               }
               if(_loc5_.Para1 + "" != param1.param4)
               {
                  return;
               }
               if(_loc10_.isCompleted)
               {
                  return;
               }
            }
            SpaceSocketOutManager.instance.nodeTrigger(param1.nodeId);
         }
      }
      
      private static function getNodeFrameName(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case 1:
               _loc2_ = "offerreward";
               break;
            case 2:
               _loc2_ = "pveroomlist";
               break;
            case 3:
               _loc2_ = "pvp";
               break;
            case 4:
               _loc2_ = "vehicleroomlist";
               break;
            case 5:
               _loc2_ = "auction";
               break;
            case 8:
            case 10:
               _loc2_ = "shop";
               break;
            case 9:
               _loc2_ = "petchallenge";
               break;
            case 13:
               _loc2_ = "treasuremap";
               break;
            case 14:
               _loc2_ = "skyboxroad";
               break;
            case 135:
               _loc2_ = "antaeus";
         }
         return _loc2_;
      }
      
      public static function getOpenType(param1:int) : Object
      {
         var _loc2_:Object = null;
         switch(param1 - 8)
         {
            case 0:
               _loc2_ = 888;
               break;
            case 1:
               _loc2_ = 2;
               break;
            case 2:
               _loc2_ = 11;
               break;
            case 5:
               _loc2_ = 1;
         }
         return _loc2_;
      }
      
      public static function openNodeFrame(param1:int) : void
      {
         var _loc2_:String = getNodeFrameName(param1);
         if(_loc2_ == "")
         {
            return;
         }
         var _loc3_:Object = getOpenType(param1);
         FrameControllerManager.instance.closeControllerByInfo(_loc2_);
         if(_loc3_ == null)
         {
            FrameControllerManager.instance.openControllerByInfo(_loc2_);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo(_loc2_,_loc3_);
         }
      }
      
      public static function closeNodeFrame(param1:int) : void
      {
         var _loc2_:String = getNodeFrameName(param1);
         if(_loc2_ == "")
         {
            return;
         }
         FrameControllerManager.instance.closeControllerByInfo(_loc2_);
      }
      
      public static function openNodeDialog() : void
      {
         FrameControllerManager.instance.spaceController.closeFrame();
         FrameControllerManager.instance.openControllerByInfo("space",2);
      }
      
      public static function closeNodeDialog() : void
      {
         FrameControllerManager.instance.spaceController.closeFrame();
         FrameControllerManager.instance.planeCrisisController.closeFrame();
      }
      
      public static function getNodeInRange(param1:Object) : SpaceNode
      {
         var _loc2_:Point = null;
         var _loc3_:Point = null;
         var _loc5_:int = 0;
         var _loc4_:SpaceNode = model.selectNode;
         if(_loc4_ && param1)
         {
            if(_loc4_.info.state == 1)
            {
               _loc2_ = new Point(viewPosXToInfoPosX(param1.x),viewPosYToInfoPosY(param1.y));
               _loc3_ = new Point(viewPosXToInfoPosX(_loc4_.x),viewPosYToInfoPosY(_loc4_.y));
               _loc5_ = Point.distance(_loc2_,_loc3_);
               if(_loc5_ < _loc4_.handlerRange + 5)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      private static function viewPosXToInfoPosX(param1:int) : int
      {
         return int(param1 / 20);
      }
      
      private static function viewPosYToInfoPosY(param1:int) : int
      {
         return int(param1 / 20);
      }
      
      private static function get model() : SpaceModel
      {
         return SpaceManager.instance.model;
      }
   }
}

