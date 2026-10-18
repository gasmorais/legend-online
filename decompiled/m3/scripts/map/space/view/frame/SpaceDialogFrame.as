package map.space.view.frame
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
   import com.pickgliss.utils.StringUtils;
   import events.RingTaskEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import managers.RingTaskManager;
   import managers.TreasureMapManager;
   import map.internals.data.SpaceNode;
   import map.space.SpaceManager;
   import mvc.module.marry.MarryModel;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskCondictionTemplate;
   import mvc.module.task.TaskTemplate;
   import yishi.SwitchPageHelp;
   import yishi.datas.VersionSwitch;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class SpaceDialogFrame extends Frame implements IManualSize
   {
      
      private var _npcName:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _itemList:Vector.<DialogOptionItem>;
      
      private var _nodeInfo:SpaceNode;
      
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
      
      public function SpaceDialogFrame()
      {
         super();
         _nodeInfo = SpaceManager.instance.model.selectNode;
         if(_nodeInfo == null)
         {
            dispose();
            return;
         }
         initView();
         initOptions();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,484,326);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
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
         if(_nodeInfo.nodeId != 21)
         {
            _iconView.icon = IconFactory.getNPCIcon(_nodeInfo.nodeId);
         }
         else
         {
            _iconView.visible = false;
         }
         _npcName.text = LanguageMgr.GetTranslation("public.colon",_nodeInfo.info.names);
         _content.htmlText = _nodeInfo.dialogue;
         _content.height = _content.numLines * _ccHeight + 5;
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
      
      private function __openHelperFrameHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("Marry.space.HelpFrame");
         if(_loc2_)
         {
            _loc2_.show();
         }
      }
      
      private function initOptions() : void
      {
         var _loc17_:Array = null;
         var _loc8_:Array = null;
         var _loc1_:Array = null;
         var _loc7_:Array = null;
         var _loc9_:String = null;
         var _loc6_:int = 0;
         var _loc18_:Function = null;
         var _loc10_:Object = null;
         var _loc14_:TaskTemplate = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc12_:Array = null;
         var _loc11_:Array = null;
         var _loc15_:GoodsTemplateInfo = null;
         var _loc16_:GoodsTemplateInfo = null;
         var _loc13_:DialogOptionItem = null;
         var _loc3_:Boolean = false;
         _vBox.disposeAllChildren();
         _itemList = new Vector.<DialogOptionItem>();
         var _loc5_:RingTask = RingTaskManager.instance.getRingTask();
         var _loc19_:int = 0;
         if(_nodeInfo.nodeId == 17 && _loc5_)
         {
            changeDialogContext(null,false);
            _rewardTxt_50.visible = false;
            _rewardTxt_200.visible = false;
            _ringTaskDropItem_200.visible = false;
            _ringTaskDropItem_50.visible = false;
            _vBox.y = _content.y + _content.height + _cvLeading;
         }
         var _loc20_:int = int(RingTaskManager.instance.getTalkTaskNPCNode());
         if(_nodeInfo.param3 || _nodeInfo.nodeId == _loc20_)
         {
            _loc17_ = _nodeInfo.param3.split("|");
            _loc8_ = _nodeInfo.param4.split("|");
            if(_nodeInfo.param5)
            {
               _loc1_ = _nodeInfo.param5.split("$");
            }
            if(_nodeInfo.ItemExchange)
            {
               _loc7_ = _nodeInfo.ItemExchange.split("|");
            }
            if(RingTaskManager.instance.getRingTaskType() == 16)
            {
               if(_nodeInfo.nodeId == _loc20_)
               {
                  _loc9_ = "11," + LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.RingTask") + ",35";
                  _loc17_.push(_loc9_);
               }
            }
            if(marryModel.getTalkTaskNPCNode() == _nodeInfo.nodeId && !marryModel.getMarryTask().isCompleted)
            {
               _loc9_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.MarryTaskNpcPath",97,36);
               _loc17_.push(_loc9_);
            }
            _loc6_ = 0;
            for(; _loc6_ < _loc17_.length; _loc6_++)
            {
               if(!StringUtils.isEmpty(_loc17_[_loc6_]))
               {
                  _loc18_ = null;
                  _loc10_ = stringToObject(_loc17_[_loc6_]);
                  if(_loc8_[_loc6_])
                  {
                     _loc10_.optionParam = int(_loc8_[_loc6_]);
                  }
                  if(_loc10_.optionType == 7)
                  {
                     _loc18_ = storyTaskNextStep;
                     _loc10_.taskId = int(_loc8_[_loc6_]);
                     if(_loc1_ && _loc1_[_loc6_])
                     {
                        _loc10_.dialogues = _loc1_[_loc6_].split("|");
                        _loc10_.totalStep = _loc10_.dialogues.length;
                     }
                     else
                     {
                        _loc10_.dialogues = [];
                        _loc10_.totalStep = 0;
                     }
                     _loc10_.currentStep = 0;
                     _loc14_ = TaskManage.instance.getTaskByID(_loc10_.taskId);
                     if(!_loc14_)
                     {
                        continue;
                     }
                     if(TaskManage.instance.cate.hasTask(_loc14_))
                     {
                        if(_loc14_.isCompleted)
                        {
                           continue;
                        }
                        _loc10_.optionTitle += LanguageMgr.GetTranslation("YiShi.mainBar.view.TaskTraceItem.Doing");
                     }
                     else if(!TaskManage.instance.isAvailableTask(_loc14_))
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 11)
                  {
                     RingTaskManager.instance.addEventListener("COMPLETETASK",ringTaskCompleteHandler);
                     _loc18_ = changeDialogContext;
                     _loc10_.optionParam = -1;
                     if(_nodeInfo.nodeId == 17 && _loc5_)
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 97)
                  {
                     MsgMan.addObserver("MarryEventType.TASK_UPDATE",this,__marryTaskHandler);
                     _loc18_ = marryTaskCallBack2;
                     _loc10_.optionParam = -1;
                  }
                  else if(_loc10_.optionType == 90)
                  {
                     if(marryModel.marriangeState == 3)
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 21)
                  {
                     _loc18_ = marryTaskCallBack1;
                     _loc10_.optionParam = -1;
                  }
                  else if(_loc10_.optionType == 23)
                  {
                     if(!marryModel.canRideCar)
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 13)
                  {
                     _loc2_ = TreasureMapManager.instance.model.rewardMax - TreasureMapManager.instance.model.rewardCount;
                     _loc4_ = int(TreasureMapManager.instance.model.rewardMax);
                     _loc10_.optionTitle = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.TreasureMapRewardTipsTxt",_loc10_.optionTitle,_loc2_,_loc4_);
                  }
                  else if(_loc10_.optionType == 15)
                  {
                     if(!PlayerManager.instance.matchTransferCondition())
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 104)
                  {
                     if(!PlayerManager.instance.matchChangeJobCondition())
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 146)
                  {
                     if(!PlayerManager.instance.isShowAvengerItem())
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 154)
                  {
                     if(!PlayerManager.instance.isShowFourTransferItem())
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 107)
                  {
                     if(_loc7_ && _loc7_[_loc6_])
                     {
                        _loc12_ = _loc7_[_loc6_].split("#")[0].split(",");
                        _loc11_ = _loc7_[_loc6_].split("#")[1].split(",");
                        if(_loc12_ && _loc11_)
                        {
                           _loc15_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_[0]);
                           _loc16_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc11_[0]);
                           if(_loc15_ && _loc16_)
                           {
                              _loc10_.optionTitle = LanguageMgr.GetTranslation("SpaceDialogFrame.HOLIDAY_GOODS_EXCHANGE.text",_loc12_[1],_loc15_.TemplateName,_loc11_[1],_loc16_.TemplateName);
                              _loc10_.optionParam = _loc6_;
                           }
                        }
                     }
                  }
                  else if(_loc10_.optionType == 152)
                  {
                     if(!VersionSwitch.SHADOW_LAND)
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 160)
                  {
                     if(!TaskManage.instance.IsTaskFinish(TaskManage.WARSOUL_TOWER))
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 161)
                  {
                     if(!TaskManage.instance.IsTaskFinish(TaskManage.FINAL_ROAD))
                     {
                        continue;
                     }
                  }
                  else if(_loc10_.optionType == 4)
                  {
                     if(!VersionSwitch.SAND_BOX)
                     {
                        continue;
                     }
                  }
                  else
                  {
                     _loc18_ = closeDialog;
                  }
                  if(_nodeInfo.nodeId == 17)
                  {
                     _loc10_.optionParam = 17;
                  }
                  _loc3_ = false;
                  if(_nodeInfo.nodeId == 22)
                  {
                     switch(_loc10_.optionType)
                     {
                        case 17:
                           if(marryModel.canCreateWedding)
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
                           _loc18_ = divorceCallBack;
                           _loc10_.optionParam = -1;
                        case 92:
                        case 93:
                        case 91:
                           if(marryModel.canDivorce)
                           {
                              _loc3_ = true;
                           }
                           break;
                        case 25:
                           if(marryModel.canAnswer)
                           {
                              _loc3_ = true;
                           }
                           break;
                        case 21:
                           if(marryModel.isMarry && marryModel.hasAccessList.getList().length <= 0)
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
                     _loc13_ = new DialogOptionItem(_loc10_.optionType,_loc10_.optionTitle,_loc10_.optionLevel,_loc10_.optionParam,_loc18_,_loc10_);
                     _loc13_.nodeInfo = _nodeInfo;
                     _vBox.addChild(_loc13_);
                     _itemList[_loc19_] = _loc13_;
                     _loc19_++;
                  }
               }
            }
         }
         addLeaveOption(_loc19_);
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
      
      private function closeDialog(param1:Object = null) : void
      {
         dispose();
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
            if(_loc2_.TemplateId == TaskManage.MONSTER_EXPLORE_TASK)
            {
               SwitchPageHelp.openMonsterExploreFrame(false);
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
         _content.height = _content.numLines * _ccHeight + 5;
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
      
      private function divorceCallBack(param1:Object = null) : void
      {
         var _loc3_:DialogOptionItem = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         if(marryModel.canDivorce == false || _nodeInfo.nodeId != 22)
         {
            dispose();
            return;
         }
         _rewardTxt_200.visible = false;
         _rewardTxt_50.visible = false;
         _ringTaskDropItem_200.visible = false;
         _ringTaskDropItem_50.visible = false;
         _vBox.y = _content.y + _content.height + _cvLeading;
         var _loc2_:String = LanguageMgr.GetTranslation("map.space.view.frame.Leave");
         var _loc4_:DialogOptionItem = new DialogOptionItem(99,_loc2_,0,0,closeDialog);
         _vBox.disposeAllChildren();
         _loc5_ = 92;
         _loc6_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.divorce1");
         _loc3_ = new DialogOptionItem(_loc5_,_loc6_,0,0,closeDialog);
         _vBox.addChild(_loc3_);
         _loc5_ = 93;
         _loc6_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.divorce2");
         _loc3_ = new DialogOptionItem(_loc5_,_loc6_,0,0,closeDialog);
         _vBox.addChild(_loc3_);
         _loc5_ = 91;
         _loc6_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.divorce3");
         _loc3_ = new DialogOptionItem(_loc5_,_loc6_,0,0,closeDialog);
         _vBox.addChild(_loc3_);
         _vBox.addChild(_loc4_);
         resetHeight();
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
         _iconView.y = height - _iconHeight;
      }
      
      public function show() : void
      {
         if(marryModel.lockScreen)
         {
            return;
         }
         resetHeight();
         LayerManager.Instance.addToLayer(this,3,true,true);
         SoundManager.instance.play("022");
         y -= _iconView.y;
      }
      
      override public function dispose() : void
      {
         removeEvent();
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
      
      private function marryTaskCallBack1(param1:Object = null, param2:Boolean = true) : void
      {
         var _loc3_:OfferRewardConditionTemplate = null;
         var _loc5_:DialogOptionItem = null;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         if(!marryModel.getMarryTask() || !marryModel.getMarryTask().conditionList || marryModel.getMarryTask().conditionList.length <= 0)
         {
            dispose();
            return;
         }
         _rewardTxt_200.visible = false;
         _rewardTxt_50.visible = false;
         _ringTaskDropItem_200.visible = false;
         _ringTaskDropItem_50.visible = false;
         _vBox.y = _content.y + _content.height + _cvLeading;
         var _loc4_:String = LanguageMgr.GetTranslation("map.space.view.frame.Leave");
         var _loc6_:DialogOptionItem = new DialogOptionItem(99,_loc4_,0,0,closeDialog);
         if(_nodeInfo.nodeId == 22)
         {
            _loc3_ = marryModel.getMarryTask().conditionList[0];
            _vBox.disposeAllChildren();
            switch(int(_loc3_.CondictionType) - 16)
            {
               case 0:
                  _loc7_ = 95;
                  _loc8_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.RingTask.goto");
                  break;
               case 6:
                  _loc7_ = 94;
                  _loc8_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.MarrytalkTask02");
                  break;
               case 7:
                  _loc7_ = 94;
                  _loc8_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.MarrytalkTask02");
            }
            _loc5_ = new DialogOptionItem(_loc7_,_loc8_,0,0,closeDialog);
            _vBox.addChild(_loc5_);
            _vBox.addChild(_loc6_);
            resetHeight();
         }
      }
      
      private function marryTaskCallBack2(param1:Object = null, param2:Boolean = true) : void
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
            _content.htmlText = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.MarrytalkTask01");
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
         _vBox.y = _content.y + _content.height + _cvLeading;
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

