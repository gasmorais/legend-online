package childpatrol
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ChildPatrolEvent;
   import events.KingContractEvents;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import managers.KingContractManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildPatrolMissionTemplateInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildPatrolTaskView extends Component
   {
      
      private var back:MutipleImage;
      
      private var taskImage:MutipleImage;
      
      private var normalText:FilterFrameText;
      
      private var hardText:FilterFrameText;
      
      private var nightmareText:FilterFrameText;
      
      private var _kingFreeTxt:FilterFrameText;
      
      private var normalRewardBox:HBox;
      
      private var hardRewardBox:HBox;
      
      private var nightmareRewardBox:HBox;
      
      private var normalRewardImage:Image;
      
      private var hardRewardImage:Image;
      
      private var nightmareRewardImage:Image;
      
      private var refreshBtn:IconButton;
      
      private var pointImage:MutipleImage;
      
      private var pointImage1:MutipleImage;
      
      private var costText:FilterFrameText;
      
      private var _data:ChildPatrolTowerInfo;
      
      private var refreshCostInfo:ConfigInfosTempInfo;
      
      private var _lastClickTime:int = 0;
      
      public function ChildPatrolTaskView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.back");
         taskImage = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.taskImage");
         normalText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.normalText");
         hardText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.hardText");
         nightmareText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.nightmareText");
         normalRewardBox = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.normalRewardBox");
         hardRewardBox = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.hardRewardBox");
         nightmareRewardBox = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.nightmareRewardBox");
         refreshBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.refreshBtn");
         pointImage = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.pointImage");
         pointImage1 = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.pointImage1");
         costText = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.costText");
         _kingFreeTxt = ComponentFactory.Instance.creatComponentByStylename("mopup.MazeMopupKingFreeTxt");
         normalRewardImage = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.normalRewardImage");
         hardRewardImage = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.hardRewardImage");
         nightmareRewardImage = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTaskView.nightmareRewardImage");
         addChild(back);
         addChild(taskImage);
         addChild(normalText);
         addChild(hardText);
         addChild(nightmareText);
         addChild(normalRewardImage);
         normalRewardImage.visible = false;
         addChild(hardRewardImage);
         hardRewardImage.visible = false;
         addChild(nightmareRewardImage);
         nightmareRewardImage.visible = false;
         addChild(normalRewardBox);
         addChild(hardRewardBox);
         addChild(nightmareRewardBox);
         addChild(refreshBtn);
         addChild(pointImage);
         addChild(pointImage1);
         addChild(costText);
         normalText.setFrame(1);
         hardText.setFrame(1);
         nightmareText.setFrame(1);
         _kingFreeTxt.y = 240;
         _kingFreeTxt.x = 45;
         _kingFreeTxt.width = 600;
         _kingFreeTxt.height = 21;
         if(!hasMopupBuff)
         {
            addChild(_kingFreeTxt);
         }
         refreshCostInfo = TempleteManager.instance.getConfigInfoByConfigName("child_patrol_mission_refresh_point");
      }
      
      private function addEvent() : void
      {
         _kingFreeTxt.addEventListener("link",__openKingClick);
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         refreshBtn.addEventListener("click",__refreshBtnHandler);
         ChildPatrolManager.instance.addEventListener("UPDATE_BOTTOM_CHILDLIST",__updateBottomChildList);
      }
      
      private function get hasMopupBuff() : Boolean
      {
         return KingContractManager.Instance.checkHasBuffById(16);
      }
      
      private function __updateKingContractHandler(param1:KingContractEvents) : void
      {
         if(hasMopupBuff)
         {
            _kingFreeTxt.visible = false;
            if(model.freeCount < 10)
            {
               costText.text = LanguageMgr.GetTranslation("ChildPatrolTaskView.refresh.costText1",10 - model.freeCount);
               pointImage1.visible = true;
               pointImage.visible = false;
            }
         }
      }
      
      private function __openKingClick(param1:TextEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("kingcontract");
      }
      
      private function removeEvent() : void
      {
         _kingFreeTxt.removeEventListener("link",__openKingClick);
         NotificationManager.instance.removeEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         refreshBtn.removeEventListener("click",__refreshBtnHandler);
         ChildPatrolManager.instance.removeEventListener("UPDATE_BOTTOM_CHILDLIST",__updateBottomChildList);
      }
      
      private function __refreshBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:int = getTimer();
         if(hasMopupBuff && model.freeCount < 10)
         {
            ChildPatrolManager.instance.sendChildPatrolOperate(6,0,0,_data.towerId);
            return;
         }
         if(_loc3_ - _lastClickTime < 400)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastClickTime = _loc3_;
         SoundManager.instance.play("022");
         if(_data.state != 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildPatrolTaskView.noRefresh.alert"));
            return;
         }
         _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         _loc4_ = "";
         if(refreshCostInfo)
         {
            _loc4_ = LanguageMgr.GetTranslation("ChildPatrolTaskView.refresh.content",refreshCostInfo.ConfigValue);
         }
         SharedManagerHelper.ins.needAlert("ChildPatrolTaskView.refresh.alert",refreshResultHandler,_loc2_,_loc4_,"");
      }
      
      private function refreshResultHandler(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(refreshCostInfo)
         {
            _loc2_ = parseInt(refreshCostInfo.ConfigValue);
         }
         if(param1)
         {
            _loc3_ = int(playerModel.playerInfo.allPoint);
         }
         else
         {
            _loc3_ = int(playerModel.playerInfo.point);
         }
         if(_loc3_ >= _loc2_)
         {
            _loc4_ = param1 ? 2 : 1;
            ChildPatrolManager.instance.sendChildPatrolOperate(6,0,_loc4_,_data.towerId);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         var _loc10_:BaseItemView = null;
         var _loc14_:GoodsInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc13_:GoodsInfo = null;
         var _loc5_:BaseItemView = null;
         var _loc12_:GoodsInfo = null;
         normalRewardBox.removeAllChild();
         hardRewardBox.removeAllChild();
         nightmareRewardBox.removeAllChild();
         normalRewardImage.visible = false;
         hardRewardImage.visible = false;
         nightmareRewardImage.visible = false;
         _data = param1;
         if(!_data)
         {
            return;
         }
         var _loc4_:int = 1;
         var _loc11_:ChildPatrolMissionTemplateInfo = TempleteManager.instance.childPatrolMissionTemplateCate.getTemplateByID(_data.normalMissionId);
         var _loc2_:ChildPatrolMissionTemplateInfo = TempleteManager.instance.childPatrolMissionTemplateCate.getTemplateByID(_data.hardMissionId);
         var _loc8_:ChildPatrolMissionTemplateInfo = TempleteManager.instance.childPatrolMissionTemplateCate.getTemplateByID(_data.nightmareMissionId);
         model.beginChange();
         var _loc7_:String = LanguageMgr.GetTranslation("map.campaign.view.ui.childpatrol.freeTip");
         var _loc9_:String = "<font color=\'#06ff00\'><a href=\'event:clickLink\'><u>" + LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.openVipTxt") + "</u></a></font>";
         var _loc6_:String = LanguageMgr.GetTranslation("public.parentheses1",_loc9_);
         _kingFreeTxt.htmlText = _loc7_ + _loc6_;
         if(_loc11_)
         {
            normalText.text = _loc11_.Description;
            normalText.setFrame(model.getTaskNameFrameByData(1,_data,model.childList));
            _loc4_;
            while(_loc4_ <= 3)
            {
               if(_loc11_["RewardId" + _loc4_] != 0)
               {
                  _loc10_ = ComponentFactory.Instance.creatCustomObject("ChildPatrolTaskView.baseItem");
                  _loc14_ = new GoodsInfo();
                  _loc14_.templateId = _loc11_["RewardId" + _loc4_];
                  _loc14_.count = _loc11_["RewardCount" + _loc4_];
                  _loc10_.data = _loc14_;
                  normalRewardBox.addChild(_loc10_);
               }
               _loc4_++;
            }
         }
         else
         {
            normalText.text = LanguageMgr.GetTranslation("ChildPatrol.ChildPatrolTaskView.towerOpenTask.grade",model.openTaskLevelArr[1]);
            normalText.setFrame(1);
         }
         if(_loc2_)
         {
            hardText.text = _loc2_.Description;
            hardText.setFrame(model.getTaskNameFrameByData(2,_data,model.childList));
            _loc4_ = 1;
            while(_loc4_ <= 3)
            {
               if(_loc2_["RewardId" + _loc4_] != 0)
               {
                  _loc3_ = ComponentFactory.Instance.creatCustomObject("ChildPatrolTaskView.baseItem");
                  _loc13_ = new GoodsInfo();
                  _loc13_.templateId = _loc2_["RewardId" + _loc4_];
                  _loc13_.count = _loc2_["RewardCount" + _loc4_];
                  _loc3_.data = _loc13_;
                  hardRewardBox.addChild(_loc3_);
               }
               _loc4_++;
            }
         }
         else
         {
            hardText.text = LanguageMgr.GetTranslation("ChildPatrol.ChildPatrolTaskView.towerOpenTask.grade",model.openTaskLevelArr[2]);
            hardText.setFrame(1);
         }
         if(_loc8_)
         {
            nightmareText.text = _loc8_.Description;
            nightmareText.setFrame(model.getTaskNameFrameByData(3,_data,model.childList));
            _loc4_ = 1;
            while(_loc4_ <= 3)
            {
               if(_loc8_["RewardId" + _loc4_] != 0)
               {
                  _loc5_ = ComponentFactory.Instance.creatCustomObject("ChildPatrolTaskView.baseItem");
                  _loc12_ = new GoodsInfo();
                  _loc12_.templateId = _loc8_["RewardId" + _loc4_];
                  _loc12_.count = _loc8_["RewardCount" + _loc4_];
                  _loc5_.data = _loc12_;
                  nightmareRewardBox.addChild(_loc5_);
               }
               _loc4_++;
            }
         }
         else
         {
            nightmareText.text = LanguageMgr.GetTranslation("ChildPatrol.ChildPatrolTaskView.towerOpenTask.grade",model.openTaskLevelArr[3]);
            nightmareText.setFrame(1);
         }
         model.commitChange();
         if(normalRewardBox.numChildren > 0)
         {
            normalRewardImage.visible = true;
         }
         if(hardRewardBox.numChildren > 0)
         {
            hardRewardImage.visible = true;
         }
         if(nightmareRewardBox.numChildren > 0)
         {
            nightmareRewardImage.visible = true;
         }
         if(refreshCostInfo)
         {
            pointImage1.visible = false;
            pointImage.visible = true;
            costText.text = LanguageMgr.GetTranslation("ChildPatrolTaskView.refresh.costText",refreshCostInfo.ConfigValue);
            if(hasMopupBuff)
            {
               if(model.freeCount < 10)
               {
                  costText.text = LanguageMgr.GetTranslation("ChildPatrolTaskView.refresh.costText1",10 - model.freeCount);
                  pointImage1.visible = true;
                  pointImage.visible = false;
               }
            }
         }
      }
      
      private function __updateBottomChildList(param1:ChildPatrolEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         model.beginChange();
         normalText.setFrame(model.getTaskNameFrameByData(1,_data,_loc2_));
         hardText.setFrame(model.getTaskNameFrameByData(2,_data,_loc2_));
         nightmareText.setFrame(model.getTaskNameFrameByData(3,_data,_loc2_));
         model.commitChange();
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(taskImage)
         {
            ObjectUtils.disposeObject(taskImage);
         }
         taskImage = null;
         if(normalText)
         {
            ObjectUtils.disposeObject(normalText);
         }
         normalText = null;
         if(hardText)
         {
            ObjectUtils.disposeObject(hardText);
         }
         hardText = null;
         if(nightmareText)
         {
            ObjectUtils.disposeObject(nightmareText);
         }
         nightmareText = null;
         if(normalRewardBox)
         {
            ObjectUtils.disposeObject(normalRewardBox);
         }
         normalRewardBox = null;
         if(hardRewardBox)
         {
            ObjectUtils.disposeObject(hardRewardBox);
         }
         hardRewardBox = null;
         if(nightmareRewardBox)
         {
            ObjectUtils.disposeObject(nightmareRewardBox);
         }
         nightmareRewardBox = null;
         if(refreshBtn)
         {
            ObjectUtils.disposeObject(refreshBtn);
         }
         refreshBtn = null;
         if(pointImage)
         {
            ObjectUtils.disposeObject(pointImage);
         }
         pointImage = null;
         if(costText)
         {
            ObjectUtils.disposeObject(costText);
         }
         costText = null;
         if(normalRewardImage)
         {
            ObjectUtils.disposeObject(normalRewardImage);
         }
         normalRewardImage = null;
         if(hardRewardImage)
         {
            ObjectUtils.disposeObject(hardRewardImage);
         }
         hardRewardImage = null;
         if(nightmareRewardImage)
         {
            ObjectUtils.disposeObject(nightmareRewardImage);
         }
         nightmareRewardImage = null;
         _data = null;
         refreshCostInfo = null;
         super.dispose();
      }
   }
}

