package map.campaign.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RingTaskEvent;
   import flash.display.Bitmap;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import managers.RingTaskManager;
   import managers.TreasureMapManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.space.view.frame.DialogOptionItem;
   import mvc.module.marry.MarryModel;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskCondictionTemplate;
   import mvc.module.task.TaskTemplate;
   import yishi.SwitchPageHelp;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class NewbieVillageDialogFrame extends Frame implements IManualSize
   {
      
      private var _npcName:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _itemList:Vector.<DialogOptionItem>;
      
      private var _nodeInfo:Object;
      
      private var _iconView:BaseIconView;
      
      private var _iconHeight:int = 326;
      
      private var _minHeight:int = 113;
      
      private var _topLeading:int = 23;
      
      private var _ncLeading:int = 16;
      
      private var _ccHeight:int = 24;
      
      private var _cvLeading:int = 20;
      
      private var _bottomLeading:int = 23;
      
      private var _rewardTxt_200:Bitmap;
      
      private var _rewardTxt_50:Bitmap;
      
      private var _ringTaskDropItem_50:BaseItemView;
      
      private var _ringTaskDropItem_200:BaseItemView;
      
      private var _timer:Timer;
      
      private var _selfArmy:CampaignArmy;
      
      public function NewbieVillageDialogFrame()
      {
         super();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,484,326);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      public function set nodeInfo(param1:Object) : void
      {
         _nodeInfo = param1;
         if(_nodeInfo)
         {
            initView();
            initOptions();
            addEvent();
         }
         else
         {
            dispose();
         }
      }
      
      private function initView() : void
      {
         _iconView = ComponentFactory.Instance.creatCustomObject("map.space.view.frame.SpaceDialogFrame.NPCIcon");
         _npcName = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceDialogFrame.NpcNameText");
         _content = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceDialogFrame.ContentText");
         _rewardTxt_200 = ComponentFactory.Instance.creatBitmap("asset.space.reward200Txt");
         _rewardTxt_50 = ComponentFactory.Instance.creatBitmap("asset.space.reward50Txt");
         _ringTaskDropItem_50 = ComponentFactory.Instance.creatCustomObject("space.ringTask.DropItem");
         _ringTaskDropItem_200 = ComponentFactory.Instance.creatCustomObject("space.ringTask.DropItem");
         _vBox = new VBox();
         _vBox.spacing = 11;
         addToContent(_iconView);
         addToContent(_npcName);
         addToContent(_content);
         addToContent(_vBox);
         addToContent(_rewardTxt_200);
         addToContent(_rewardTxt_50);
         addToContent(_ringTaskDropItem_50);
         addToContent(_ringTaskDropItem_200);
         _iconView.icon = IconFactory.getNPCIcon(_nodeInfo.nodeId);
         _npcName.text = LanguageMgr.GetTranslation("public.colon",_nodeInfo.info.names);
         _content.htmlText = _nodeInfo.param6 ? _nodeInfo.param6 : "";
         _content.height = _content.numLines * _ccHeight;
         _content.y = _npcName.y + _npcName.height + _ncLeading;
         _vBox.x = _content.x;
         _vBox.y = _content.y + _content.height + _cvLeading;
         _rewardTxt_200.y = _content.y + _content.textHeight + 5;
         _rewardTxt_50.y = _content.y + _content.textHeight + 5;
         _rewardTxt_200.visible = false;
         _rewardTxt_50.visible = false;
         _ringTaskDropItem_200.visible = false;
         _ringTaskDropItem_50.visible = false;
         if(_nodeInfo.nodeId == 17 && ArmyManager.instance.thane.grades >= 35)
         {
            _rewardTxt_50.visible = true;
            _rewardTxt_200.visible = true;
            _ringTaskDropItem_50.visible = true;
            _ringTaskDropItem_200.visible = true;
            _ringTaskDropItem_50.x = _rewardTxt_50.x + _rewardTxt_50.width + 3;
            _ringTaskDropItem_200.x = _rewardTxt_200.x + _rewardTxt_200.width + 3;
            _ringTaskDropItem_50.y = _rewardTxt_200.y - 10;
            _ringTaskDropItem_200.y = _rewardTxt_200.y - 10;
            _vBox.y = _rewardTxt_50.y + _rewardTxt_50.height + 10;
            setItemValue();
            resetHeight();
         }
      }
      
      private function initOptions() : void
      {
         var _loc12_:Array = null;
         var _loc7_:Array = null;
         var _loc1_:Array = null;
         var _loc8_:String = null;
         var _loc6_:int = 0;
         var _loc13_:Function = null;
         var _loc9_:Object = null;
         var _loc11_:TaskTemplate = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc10_:DialogOptionItem = null;
         var _loc3_:Boolean = false;
         _vBox.disposeAllChildren();
         _itemList = new Vector.<DialogOptionItem>();
         var _loc5_:RingTask = RingTaskManager.instance.getRingTask();
         var _loc14_:int = 0;
         if(_nodeInfo.nodeId == 17 && _loc5_)
         {
            changeDialogContext(null,false);
            _rewardTxt_50.visible = false;
            _rewardTxt_200.visible = false;
            _ringTaskDropItem_200.visible = false;
            _ringTaskDropItem_50.visible = false;
            _vBox.y = _content.y + _content.height + _cvLeading;
         }
         if(_nodeInfo.param3)
         {
            _loc12_ = _nodeInfo.param3.split("|");
            _loc7_ = _nodeInfo.param4.split("|");
            if(_nodeInfo.param5)
            {
               _loc1_ = _nodeInfo.param5.split("$");
            }
            if(RingTaskManager.instance.getRingTaskType() == 16)
            {
               if(_nodeInfo.nodeId == RingTaskManager.instance.getTalkTaskNPCNode())
               {
                  _loc8_ = "11," + LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.RingTask") + ",35";
                  _loc12_.push(_loc8_);
               }
            }
            if(marryModel.getTalkTaskNPCNode() == _nodeInfo.nodeId && !marryModel.getMarryTask().isCompleted)
            {
               _loc8_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.MarryTaskNpcPath",97,36);
               _loc12_.push(_loc8_);
            }
            _loc6_ = 0;
            for(; _loc6_ < _loc12_.length; _loc6_++)
            {
               _loc13_ = null;
               _loc9_ = stringToObject(_loc12_[_loc6_]);
               if(_loc7_[_loc6_])
               {
                  _loc9_.optionParam = int(_loc7_[_loc6_]);
               }
               if(_loc9_.optionType == 7)
               {
                  _loc13_ = storyTaskNextStep;
                  _loc9_.taskId = int(_loc7_[_loc6_]);
                  if(_loc1_ && _loc1_[_loc6_])
                  {
                     _loc9_.dialogues = _loc1_[_loc6_].split("|");
                     _loc9_.totalStep = _loc9_.dialogues.length;
                  }
                  else
                  {
                     _loc9_.dialogues = [];
                     _loc9_.totalStep = 0;
                  }
                  _loc9_.currentStep = 0;
                  _loc11_ = TaskManage.instance.getTaskByID(_loc9_.taskId);
                  if(!_loc11_)
                  {
                     continue;
                  }
                  if(TaskManage.instance.cate.hasTask(_loc11_))
                  {
                     if(_loc11_.isCompleted)
                     {
                        continue;
                     }
                     _loc9_.optionTitle += LanguageMgr.GetTranslation("YiShi.mainBar.view.TaskTraceItem.Doing");
                  }
                  else if(!TaskManage.instance.isAvailableTask(_loc11_))
                  {
                     continue;
                  }
               }
               else if(_loc9_.optionType == 11)
               {
                  RingTaskManager.instance.addEventListener("COMPLETETASK",ringTaskCompleteHandler);
                  _loc13_ = changeDialogContext;
                  _loc9_.optionParam = -1;
                  if(_nodeInfo.nodeId == 17 && _loc5_)
                  {
                     continue;
                  }
               }
               else if(_loc9_.optionType == 97)
               {
                  MsgMan.addObserver("MarryEventType.TASK_UPDATE",this,__marryTaskHandler);
                  _loc13_ = marryTaskCallBack;
                  _loc9_.optionParam = -1;
               }
               else if(_loc9_.optionType == 23)
               {
                  if(!marryModel.canRideCar)
                  {
                     continue;
                  }
               }
               else if(_loc9_.optionType == 13)
               {
                  _loc2_ = TreasureMapManager.instance.model.rewardMax - TreasureMapManager.instance.model.rewardCount;
                  _loc4_ = int(TreasureMapManager.instance.model.rewardMax);
                  _loc9_.optionTitle = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.TreasureMapRewardTipsTxt",_loc9_.optionTitle,_loc2_,_loc4_);
               }
               else if(_loc9_.optionType == 15)
               {
                  if(!PlayerManager.instance.matchTransferCondition())
                  {
                     continue;
                  }
               }
               else
               {
                  _loc13_ = closeDialog;
               }
               if(_nodeInfo.nodeId == 17)
               {
                  _loc9_.optionParam = 17;
               }
               _loc3_ = false;
               if(_nodeInfo.nodeId == 22)
               {
                  switch(_loc9_.optionType)
                  {
                     case 17:
                        if(marryModel.canBuyQuality)
                        {
                           _loc3_ = true;
                        }
                        break;
                     case 19:
                        if(marryModel.canEnterWedding)
                        {
                           _loc3_ = true;
                        }
                        break;
                     case 20:
                        if(marryModel.canDivorce)
                        {
                           _loc3_ = true;
                        }
                        break;
                     case 21:
                        if(marryModel.selfMarryInfo.state == 3 && marryModel.hasAccessList.getList().length <= 0)
                        {
                           _loc3_ = true;
                        }
                        break;
                     default:
                        _loc3_ = true;
                  }
               }
               else
               {
                  _loc3_ = true;
               }
               if(_loc3_)
               {
                  _loc10_ = new DialogOptionItem(_loc9_.optionType,_loc9_.optionTitle,_loc9_.optionLevel,_loc9_.optionParam,_loc13_,_loc9_);
                  _vBox.addChild(_loc10_);
                  _itemList[_loc14_] = _loc10_;
                  _loc14_++;
               }
            }
         }
         addLeaveOption(_loc14_);
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function stringToObject(param1:String) : Object
      {
         var _loc3_:Array = null;
         var _loc2_:Object = {
            "optionType":0,
            "optionTitle":"",
            "optionLevel":0,
            "optionParam":0
         };
         if(!param1)
         {
            return _loc2_;
         }
         _loc3_ = param1.split(",");
         if(_loc3_[0])
         {
            _loc2_.optionType = int(_loc3_[0]);
         }
         if(_loc3_[1])
         {
            _loc2_.optionTitle = String(_loc3_[1]);
         }
         if(_loc3_[2])
         {
            _loc2_.optionLevel = int(_loc3_[2]);
         }
         return _loc2_;
      }
      
      private function addLeaveOption(param1:int) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("map.space.view.frame.Leave");
         var _loc3_:DialogOptionItem = new DialogOptionItem(99,_loc2_,0,0,closeDialog);
         _vBox.addChild(_loc3_);
         _itemList[param1] = _loc3_;
      }
      
      private function closeDialog(param1:Object) : void
      {
         dispose();
      }
      
      private function startTimer() : void
      {
         if(!_timer)
         {
            _timer = new Timer(300);
            _timer.addEventListener("timer",__timeTickHandler);
         }
         _timer.start();
      }
      
      private function __timeTickHandler(param1:TimerEvent) : void
      {
         var _loc4_:Object = CampaignManager.instance.controller.getArmyView(_selfArmy);
         if(!_selfArmy || !_loc4_ || !_nodeInfo || !_nodeInfo.nodeView)
         {
            dispose();
            return;
         }
         var _loc6_:Point = new Point(_loc4_.x,_loc4_.y);
         var _loc3_:Point = new Point(_nodeInfo.nodeView.x,_nodeInfo.nodeView.y);
         var _loc5_:int = 4;
         if(_nodeInfo.handlerRange > 0)
         {
            _loc5_ = int(_nodeInfo.handlerRange);
         }
         var _loc2_:Number = Point.distance(_loc6_,_loc3_);
         if(_loc2_ > _loc5_ * 20)
         {
            dispose();
            return;
         }
      }
      
      private function storyTaskNextStep(param1:Object) : void
      {
         var _loc6_:Array = null;
         var _loc3_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:TaskCondictionTemplate = null;
         var _loc4_:Array = null;
         var _loc5_:Boolean = false;
         if(_rewardTxt_50)
         {
            _rewardTxt_50.visible = false;
         }
         if(_rewardTxt_200)
         {
            _rewardTxt_200.visible = false;
         }
         if(_ringTaskDropItem_200)
         {
            _ringTaskDropItem_200.visible = false;
         }
         if(_ringTaskDropItem_50)
         {
            _ringTaskDropItem_50.visible = false;
         }
         RingTaskManager.instance.removeEventListener("COMPLETETASK",ringTaskCompleteHandler);
         var _loc2_:TaskTemplate = TaskManage.instance.getTaskByID(param1.taskId);
         if(param1.currentStep >= param1.totalStep)
         {
            if(_loc2_ && !_loc2_.isCompleted)
            {
               _loc6_ = _loc2_.conditionList;
               _loc3_ = true;
               _loc7_ = 0;
               while(_loc7_ < _loc6_.length)
               {
                  _loc8_ = _loc6_[_loc7_];
                  if(_loc8_.CondictionType == 85)
                  {
                     _loc2_.finishStory = true;
                     _loc2_.commit();
                     FinishNewbieTask(_loc2_);
                     _loc3_ = false;
                     break;
                  }
                  _loc7_++;
               }
               if(_loc3_)
               {
                  SwitchPageHelp.skipPageByTaskCondictionType(_loc2_,null);
               }
            }
            dispose();
         }
         else
         {
            _loc4_ = param1.dialogues[param1.currentStep].split("#");
            resetFrame(_loc4_[0],_loc4_[1],storyTaskNextStep,param1);
            param1.currentStep++;
            _loc5_ = Boolean(TaskManage.instance.cate.hasTask(_loc2_));
            if(!_loc5_ && param1.currentStep == param1.totalStep)
            {
               TaskManage.instance.requestAcceptTask(_loc2_);
            }
         }
      }
      
      private function FinishNewbieTask(param1:TaskTemplate) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1.TemplateId >= 1823 && param1.TemplateId <= 1831)
         {
            FrameControllerManager.instance.taskControler.sendGetTaskReward(param1.TemplateId,0);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("DISPOSEVIEW",disposeViewHandler);
      }
      
      private function disposeViewHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function resetFrame(param1:String, param2:String, param3:Function, param4:Object) : void
      {
         _content.htmlText = param1;
         _content.height = _content.numLines * _ccHeight;
         _content.y = _npcName.y + _npcName.height + _ncLeading;
         _vBox.x = _content.x;
         _vBox.y = _content.y + _content.height + _cvLeading;
         _vBox.disposeAllChildren();
         _itemList.length = 0;
         var _loc5_:DialogOptionItem = new DialogOptionItem(7,param2,0,0,param3,param4);
         _vBox.addChild(_loc5_);
         _itemList[0] = _loc5_;
         addLeaveOption(1);
         resetHeight();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         RingTaskManager.instance.removeEventListener("COMPLETETASK",ringTaskCompleteHandler);
         NotificationManager.instance.removeEventListener("DISPOSEVIEW",disposeViewHandler);
         MsgMan.removeObserver("MarryEventType.TASK_UPDATE",this,__marryTaskHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function getDialogItemByIndex(param1:int) : DialogOptionItem
      {
         return _itemList[param1];
      }
      
      private function resetHeight() : void
      {
         var _loc1_:int = _topLeading + _npcName.height + _cvLeading + _content.height;
         if(_rewardTxt_200.visible)
         {
            _loc1_ += _rewardTxt_200.height;
         }
         if(_vBox.height == 0)
         {
            _loc1_ += _bottomLeading;
         }
         else
         {
            _loc1_ += _cvLeading + _vBox.height + _bottomLeading;
         }
         if(_loc1_ < _minHeight)
         {
            _loc1_ = _minHeight;
         }
         height = _loc1_;
         _iconView.y = height - _iconHeight - 10;
      }
      
      public function show() : void
      {
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         resetHeight();
         startTimer();
         LayerManager.Instance.addToLayer(this,3,true,true);
         SoundManager.instance.play("022");
         y -= _iconView.y;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timeTickHandler);
            _timer = null;
         }
         if(_ringTaskDropItem_200)
         {
            ObjectUtils.disposeAllChildren(_ringTaskDropItem_200);
         }
         if(_ringTaskDropItem_50)
         {
            ObjectUtils.disposeAllChildren(_ringTaskDropItem_200);
         }
         ObjectUtils.disposeObject(_rewardTxt_200);
         ObjectUtils.disposeObject(_rewardTxt_50);
         if(_npcName)
         {
            ObjectUtils.disposeObject(_npcName);
            _npcName = null;
         }
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
            _content = null;
         }
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
            _vBox = null;
         }
         if(_itemList)
         {
            _itemList.length = 0;
         }
         _itemList = null;
         _nodeInfo = null;
         _selfArmy = null;
         super.dispose();
      }
      
      private function __marryTaskHandler(param1:String, param2:Object) : void
      {
         if(marryModel.hasAccessList.getList().length <= 0)
         {
            dispose();
         }
         else if(marryModel.hasAccessList.getList()[0].isCompleted)
         {
            dispose();
         }
      }
      
      private function ringTaskCompleteHandler(param1:RingTaskEvent) : void
      {
         dispose();
      }
      
      private function marryTaskCallBack(param1:Object = null, param2:Boolean = true) : void
      {
         var _loc3_:DialogOptionItem = null;
         _rewardTxt_200.visible = false;
         _rewardTxt_50.visible = false;
         _ringTaskDropItem_200.visible = false;
         _ringTaskDropItem_50.visible = false;
         _vBox.y = _content.y + _content.height + _cvLeading;
         var _loc6_:int = int(marryModel.getTalkTaskNPCNode());
         var _loc4_:String = LanguageMgr.GetTranslation("map.space.view.frame.Leave");
         var _loc5_:DialogOptionItem = new DialogOptionItem(99,_loc4_,0,0,closeDialog);
         if(_loc6_ == _nodeInfo.nodeId)
         {
            _content.htmlText = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.talkTask02");
            _vBox.disposeAllChildren();
            _loc3_ = new DialogOptionItem(96,LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.RingTask.completeTask"),0,0,closeDialog);
            _vBox.addChild(_loc3_);
            _vBox.addChild(_loc5_);
            resetHeight();
         }
      }
      
      private function changeDialogContext(param1:Object = null, param2:Boolean = true) : void
      {
         var _loc3_:DialogOptionItem = null;
         var _loc8_:RingTask = null;
         var _loc5_:OfferRewardConditionTemplate = null;
         var _loc6_:DialogOptionItem = null;
         _rewardTxt_200.visible = false;
         _rewardTxt_50.visible = false;
         _ringTaskDropItem_200.visible = false;
         _ringTaskDropItem_50.visible = false;
         _vBox.y = _content.y + _content.height + _cvLeading;
         var _loc9_:int = int(RingTaskManager.instance.getTalkTaskNPCNode());
         var _loc4_:String = LanguageMgr.GetTranslation("map.space.view.frame.Leave");
         var _loc7_:DialogOptionItem = new DialogOptionItem(99,_loc4_,0,0,closeDialog);
         if(_loc9_ == _nodeInfo.nodeId)
         {
            _content.htmlText = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.talkTask02");
            _vBox.disposeAllChildren();
            _loc3_ = new DialogOptionItem(98,LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.RingTask.completeTask"),0,0,null);
            _vBox.addChild(_loc3_);
            _vBox.addChild(_loc7_);
            resetHeight();
         }
         else
         {
            _loc8_ = RingTaskManager.instance.getRingTask();
            _loc5_ = RingTaskManager.instance.getCurrCondition();
            _content.htmlText = getRingTaskTalkContent();
            _vBox.disposeAllChildren();
            if(_loc5_.CondictionType == 16)
            {
               _loc6_ = new DialogOptionItem(12,LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.RingTask.goto"),35,_loc9_,null);
               _vBox.addChild(_loc6_);
            }
            if(param2)
            {
               _vBox.addChild(_loc7_);
            }
            resetHeight();
         }
      }
      
      private function getRingTaskTalkContent() : String
      {
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc1_:String = null;
         var _loc8_:CampaignTemplate = null;
         var _loc4_:OfferRewardConditionTemplate = null;
         var _loc9_:String = "";
         var _loc6_:RingTask = RingTaskManager.instance.getRingTask();
         var _loc2_:OfferRewardConditionTemplate = RingTaskManager.instance.getCurrCondition();
         if(_loc2_.CondictionType == 19)
         {
            _loc9_ = _loc2_.Para5;
            _loc7_ = "";
            switch(int(_loc6_.currTask.condition_2) - 2)
            {
               case 0:
                  _loc7_ = LanguageMgr.GetTranslation("public.consortia");
                  break;
               case 1:
                  _loc7_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.pvp");
                  break;
               case 2:
                  _loc7_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.Maze");
            }
            _loc9_ = _loc9_.replace("{1}",_loc7_);
            _loc3_ = "";
            if(_loc6_.currTask.condition_3 > 0)
            {
               _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc6_.currTask.condition_3);
               _loc3_ = _loc5_.TemplateName;
            }
            _loc9_ = _loc9_.replace("{0}",_loc3_);
         }
         else if(_loc2_.CondictionType == 18)
         {
            _loc1_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.killMonster");
            _loc8_ = TempleteManager.instance.getCampaignTemplateById(_loc6_.currTask.condition_2);
            _loc1_ = _loc1_.replace("{0}",_loc8_.CampaignName);
            _loc1_ = _loc1_.replace("{2}",_loc6_.currTask.condition_4);
            _loc9_ = _loc1_;
         }
         else
         {
            _loc4_ = RingTaskManager.instance.getCurrCondition();
            _loc9_ = _loc4_.Para5;
         }
         return _loc9_;
      }
      
      private function setItemValue() : void
      {
         var _loc2_:Array = RingTaskManager.instance.getRewardGoods(50);
         var _loc1_:Array = RingTaskManager.instance.getRewardGoods(200);
         _ringTaskDropItem_50.data = _loc2_[0];
         _ringTaskDropItem_200.data = _loc1_[0];
      }
   }
}

