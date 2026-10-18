package map.campaign.view.ui.godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.physics.CampaignArmyView;
   import map.internals.data.CampaignNode;
   import mvc.module.godsevening.GodsEveningModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class GodsEveningTaskItem extends Component
   {
      
      private var _taskIcon:ScaleFrameImage;
      
      private var _titleText:FilterFrameText;
      
      private var _conditionText:FilterFrameText;
      
      private var _back:Scale9CornerImage;
      
      private var _data:OfferRewardTemplate;
      
      private var _bossNodeList:Array = [850104,850105,850106];
      
      private var _godLordsNodeList:Array = [850107,850108,850109];
      
      private var _goddessNodeList:Array = [850110,850111,850112];
      
      public function GodsEveningTaskItem()
      {
         super();
         initView();
         addEvent();
         buttonMode = true;
      }
      
      private function initView() : void
      {
         _taskIcon = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTaskItem.ItemTitleIcon");
         _titleText = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTaskItem.ItemTitleTxt");
         _conditionText = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTaskItem.ItemDescribeTxt");
         _back = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTaskItem.ItemBack");
         addChild(_back);
         _back.visible = false;
         _back.mouseChildren = false;
         addChild(_taskIcon);
         addChild(_titleText);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_taskIcon);
         _taskIcon = null;
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_conditionText);
         _conditionText = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__clickHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:CampaignArmy = null;
         var _loc6_:Point = null;
         var _loc4_:CampaignArmy = null;
         var _loc2_:* = null;
         var _loc5_:CampaignArmyView = null;
         var _loc9_:CampaignNode = null;
         if(godsEveningModel.taskProgressDic[data.TemplateId] >= data.RewardGold)
         {
            if(godsEveningModel.taskGotRewardDic[data.TemplateId])
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("godsEvening.GodsEveningTaskItem.clickTip"));
            }
            else
            {
               GodsEveningManager.instance.sendGetTaskReward(data.TemplateId,playerInfo.userId,playerInfo.serviceName);
            }
         }
         else
         {
            _loc3_ = 1.7976931348623157e+308;
            _loc8_ = CampaignManager.instance.mapModel.selfMemberData;
            _loc6_ = new Point(_loc8_.curPosX,_loc8_.curPosY);
            if(data.TemplateId == 5102)
            {
               for each(_loc2_ in mapModel.allUserArmy)
               {
                  _loc5_ = CampaignManager.instance.controller.getArmyView(_loc2_);
                  if(_loc5_ && _loc2_.teamId != godsEveningModel.teamId)
                  {
                     _loc7_ = Point.distance(_loc6_,new Point(_loc2_.curPosX,_loc2_.curPosY));
                     if(_loc7_ < _loc3_)
                     {
                        _loc3_ = _loc7_;
                        _loc4_ = _loc2_;
                     }
                  }
               }
               if(_loc4_)
               {
                  GodsEveningManager.instance.model.selfFowllowingArmy = _loc4_;
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",_loc4_));
               }
            }
            else if(data.TemplateId == 5103)
            {
               for each(_loc2_ in mapModel.allUserArmy)
               {
                  if(_loc2_.isDie == 12 || _loc2_.isDie == 10)
                  {
                     if(_loc2_.goddessTeamId == godsEveningModel.teamId)
                     {
                        _loc4_ = _loc2_;
                        GodsEveningManager.instance.model.selfFowllowingArmy = _loc4_;
                        NotificationManager.instance.dispatchEvent(new NotificationEvent("LOCK_PVP_WARFIGHT",_loc4_));
                        return;
                     }
                  }
               }
            }
            else
            {
               _loc9_ = getNodeByTaskId(data.TemplateId);
               if(CampaignManager.instance.controller && _loc9_)
               {
                  CampaignManager.instance.controller.moveArmyByPos(_loc9_.curPosX * 20,_loc9_.curPosY * 20,true);
               }
            }
         }
      }
      
      private function getNodeByTaskId(param1:int) : CampaignNode
      {
         var _loc2_:* = null;
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:CampaignArmy = null;
         var _loc4_:Point = null;
         var _loc5_:CampaignNode = null;
         if(data.TemplateId == 5001)
         {
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_godLordsNodeList.indexOf(_loc2_.nodeId) != -1 && _loc2_.param1 == 1 && _loc2_.info.state != 9)
               {
                  return _loc2_;
               }
            }
         }
         else if(data.TemplateId == 5002)
         {
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_godLordsNodeList.indexOf(_loc2_.nodeId) != -1 && _loc2_.param1 == 2 && _loc2_.info.state != 9)
               {
                  return _loc2_;
               }
            }
         }
         else if(data.TemplateId == 5003)
         {
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_godLordsNodeList.indexOf(_loc2_.nodeId) != -1 && _loc2_.param1 == 3 && _loc2_.info.state != 9)
               {
                  return _loc2_;
               }
            }
         }
         else if(data.TemplateId == 5011)
         {
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_bossNodeList.indexOf(_loc2_.nodeId) != -1 && _loc2_.param1 == 1 && _loc2_.info.state != 9)
               {
                  return _loc2_;
               }
            }
         }
         else if(data.TemplateId == 5012)
         {
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_bossNodeList.indexOf(_loc2_.nodeId) != -1 && _loc2_.param1 == 2 && _loc2_.info.state != 9)
               {
                  return _loc2_;
               }
            }
         }
         else if(data.TemplateId == 5013)
         {
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_bossNodeList.indexOf(_loc2_.nodeId) != -1 && _loc2_.param1 == 3 && _loc2_.info.state != 9)
               {
                  return _loc2_;
               }
            }
         }
         else if(data.TemplateId == 5021)
         {
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_goddessNodeList.indexOf(_loc2_.nodeId) != -1 && _loc2_.param1 == 1)
               {
                  return _loc2_;
               }
            }
         }
         else if(data.TemplateId == 5022)
         {
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_goddessNodeList.indexOf(_loc2_.nodeId) != -1 && _loc2_.param1 == 2)
               {
                  return _loc2_;
               }
            }
         }
         else if(data.TemplateId == 5023)
         {
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_goddessNodeList.indexOf(_loc2_.nodeId) != -1 && _loc2_.param1 == 3)
               {
                  return _loc2_;
               }
            }
         }
         else if(data.TemplateId == 5101)
         {
            _loc3_ = 1.7976931348623157e+308;
            _loc7_ = CampaignManager.instance.mapModel.selfMemberData;
            _loc4_ = new Point(_loc7_.curPosX,_loc7_.curPosY);
            for each(_loc2_ in mapModel.mapNodesData)
            {
               if(_loc2_.info.types == 91 && _loc2_.param1 != godsEveningModel.teamId && _loc2_.info.state != 9)
               {
                  _loc6_ = Point.distance(_loc4_,new Point(_loc2_.curPosX,_loc2_.curPosY));
                  if(_loc6_ < _loc3_)
                  {
                     _loc3_ = _loc6_;
                     _loc5_ = _loc2_;
                  }
               }
            }
            return _loc5_;
         }
         return null;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _back.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _back.visible = false;
      }
      
      public function refreshView() : void
      {
         if(data == null)
         {
            return;
         }
         if(_conditionText && _conditionText.parent)
         {
            _conditionText.parent.removeChild(_conditionText);
         }
         if(godsEveningModel.taskProgressDic[data.TemplateId] >= data.RewardGold)
         {
            _taskIcon.setFrame(2);
            _titleText.setFrame(2);
            if(godsEveningModel.taskGotRewardDic[data.TemplateId])
            {
               _titleText.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningTaskItem.taskRewardGot",getTitle(data.Title));
            }
            else
            {
               _titleText.text = LanguageMgr.GetTranslation("godsEvening.GodsEveningTaskItem.taskComplete",getTitle(data.Title));
            }
            _back.height = _titleText.textHeight + 21;
         }
         else
         {
            _taskIcon.setFrame(1);
            _titleText.setFrame(1);
            _back.height = 65;
            addChild(_conditionText);
            _titleText.text = getTitle(data.Title);
            _conditionText.text = data.Detail + " (" + godsEveningModel.taskProgressDic[data.TemplateId] + "/" + data.RewardGold + ")";
         }
      }
      
      private function getTitle(param1:String) : String
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:Array = [5101,5102,5103];
         if(_loc2_.indexOf(data.TemplateId) != -1)
         {
            _loc4_ = "godsEvening.GodsEveningTaskItem.newTitle" + godsEveningModel.taskCompleteCountsDic[data.TemplateId];
            _loc3_ = LanguageMgr.GetTranslation(_loc4_,param1);
         }
         else
         {
            _loc3_ = param1;
         }
         return _loc3_;
      }
      
      public function get data() : OfferRewardTemplate
      {
         return _data;
      }
      
      public function set data(param1:OfferRewardTemplate) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function get godsEveningModel() : GodsEveningModel
      {
         return GodsEveningManager.instance.model;
      }
      
      private function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function get height() : Number
      {
         return _back.height;
      }
   }
}

