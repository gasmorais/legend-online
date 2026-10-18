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
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.RingTaskManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.data.CampaignNode;
   import map.net.MapSocketOuterManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TaskManage;
   import yishi.utils.IconFactory;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   
   public class PetLandDialogFrame extends Frame implements IManualSize
   {
      
      protected var _npcName:FilterFrameText;
      
      protected var _content:FilterFrameText;
      
      protected var _vBox:VBox;
      
      protected var _itemList:Vector.<CampaignDialogOptionItem>;
      
      protected var _iconView:BaseIconView;
      
      protected var _iconHeight:int = 326;
      
      protected var _minHeight:int = 113;
      
      protected var _topLeading:int = 23;
      
      protected var _ncLeading:int = 16;
      
      protected var _ccHeight:int = 24;
      
      protected var _cvLeading:int = 20;
      
      protected var _bottomLeading:int = 23;
      
      protected var _timer:Timer;
      
      protected var _selfArmy:CampaignArmy;
      
      public var mapId:int = 0;
      
      protected var _data:CampaignNode;
      
      protected var leaveItem:CampaignDialogOptionItem;
      
      public function PetLandDialogFrame()
      {
         super();
         initView();
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
         _vBox = new VBox();
         _vBox.spacing = 11;
         addToContent(_iconView);
         addToContent(_npcName);
         addToContent(_content);
         addToContent(_vBox);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _vBox.addEventListener("click",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_vBox)
         {
            _vBox.removeEventListener("click",__onClickHandler);
         }
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
      
      protected function __onClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_data)
         {
            if(param1.target == leaveItem)
            {
               MapSocketOuterManager.sendFrameCallBack(mapId,_data.nodeId,false);
            }
            else if(param1.target is CampaignDialogOptionItem)
            {
               if(CampaignDialogOptionItem(param1.target).text == LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.RingTask"))
               {
                  changeDialogContext();
                  return;
               }
               if(CampaignDialogOptionItem(param1.target).text == LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.complete"))
               {
                  RingTaskManager.instance.updataState();
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("TALKRINGTASK_COMPLETE"));
               }
               else
               {
                  MapSocketOuterManager.sendFrameCallBack(mapId,_data.nodeId,true);
                  doSomething(_data);
               }
            }
         }
         dispose();
      }
      
      protected function doSomething(param1:CampaignNode) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkPetLand(_loc2_))
         {
            petLandLogic(param1);
         }
      }
      
      private function petLandLogic(param1:CampaignNode) : void
      {
         if(param1.param4 == "2")
         {
            FrameControllerManager.instance.openControllerByInfo("shop",888);
         }
      }
      
      public function show(param1:CampaignNode) : void
      {
         _data = param1;
         _iconView.icon = IconFactory.getNPCIcon(_data.nodeId);
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         refresh();
         resetHeight();
         startTimer();
         LayerManager.Instance.addToLayer(this,3,true,true);
         SoundManager.instance.play("022");
         CampaignManager.instance.mapModel.selectNode = null;
         y -= _iconView.y;
      }
      
      protected function refresh() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         if(_data)
         {
            _npcName.text = LanguageMgr.GetTranslation("public.colon",_data.info.names);
            _itemList = new Vector.<CampaignDialogOptionItem>();
            if(_data.param3)
            {
               _loc1_ = _data.param3.split("|");
               _loc2_ = _loc1_[0].split(",");
               initOptions(_loc2_);
               _content.htmlText = _loc1_[1];
            }
         }
         else
         {
            _npcName.text = "";
            _content.htmlText = "";
         }
         _content.height = _content.numLines * _ccHeight;
         _content.y = _npcName.y + _npcName.height + _ncLeading;
         _vBox.x = _content.x;
         _vBox.y = _content.y + _content.height + _cvLeading;
      }
      
      protected function initOptions(param1:Array) : void
      {
         var _loc2_:String = null;
         var _loc4_:CampaignDialogOptionItem = null;
         var _loc5_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkPetLand(_loc5_))
         {
            initOptionsPetLand(param1);
         }
         if(RingTaskManager.instance.getRingTaskType() == 16)
         {
            if(_data.nodeId == RingTaskManager.instance.getTalkTaskNPCNode())
            {
               _loc2_ = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.RingTask");
               _loc4_ = new CampaignDialogOptionItem(mapId,_data.nodeId,_loc2_,_itemList.length);
               _vBox.addChild(_loc4_);
               _itemList.push(_loc4_);
            }
         }
         var _loc3_:String = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leave");
         leaveItem = new CampaignDialogOptionItem(mapId,_data.nodeId,_loc3_,_itemList.length);
         _vBox.addChild(leaveItem);
         _itemList.push(leaveItem);
         _content.height = _content.numLines * _ccHeight;
         _content.y = _npcName.y + _npcName.height + _ncLeading;
         _vBox.x = _content.x;
         _vBox.y = _content.y + _content.height + _cvLeading;
      }
      
      private function initOptionsPetLand(param1:Array) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:CampaignDialogOptionItem = null;
         var _loc4_:int = 0;
         if(!_data)
         {
            return;
         }
         if(_data.param4 == "1")
         {
            _loc3_ = Boolean(TaskManage.instance.cate.hasTaskAndNotCompleted(TaskManage.PET_SYSTEM_OPEN_TASK02));
            if(!_loc3_)
            {
               return;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc2_ = new CampaignDialogOptionItem(mapId,_data.nodeId,param1[_loc4_],_loc4_);
            _vBox.addChild(_loc2_);
            _itemList[_loc4_] = _loc2_;
            _loc4_++;
         }
      }
      
      protected function resetHeight() : void
      {
         var _loc1_:int = _topLeading + _npcName.height + _cvLeading + _content.height;
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
      
      protected function startTimer() : void
      {
         if(!_timer)
         {
            _timer = new Timer(300);
            _timer.addEventListener("timer",__timeTickHandler);
         }
         _timer.start();
      }
      
      protected function __timeTickHandler(param1:TimerEvent) : void
      {
         var _loc4_:Object = CampaignManager.instance.controller.getArmyView(_selfArmy);
         if(!_selfArmy || !_loc4_ || !_data || !_data.nodeView)
         {
            dispose();
            return;
         }
         var _loc6_:Point = new Point(_loc4_.x,_loc4_.y);
         var _loc3_:Point = new Point(_data.nodeView.x,_data.nodeView.y);
         var _loc5_:int = 4;
         if(_data.handlerRange > 0)
         {
            _loc5_ = int(_data.handlerRange);
         }
         var _loc2_:Number = Point.distance(_loc6_,_loc3_);
         if(_loc2_ > _loc5_ * 20)
         {
            dispose();
            return;
         }
      }
      
      private function changeDialogContext() : void
      {
         _content.htmlText = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.talkTask02");
         _vBox.disposeAllChildren();
         var _loc3_:String = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.complete");
         var _loc1_:String = LanguageMgr.GetTranslation("map.space.view.frame.SpaceDialogFrame.leave");
         var _loc2_:CampaignDialogOptionItem = new CampaignDialogOptionItem(mapId,_data.nodeId,_loc3_,0);
         _vBox.addChild(_loc2_);
         leaveItem = new CampaignDialogOptionItem(mapId,_data.nodeId,_loc1_,0);
         _vBox.addChild(leaveItem);
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
         _data = null;
         _selfArmy = null;
         super.dispose();
      }
   }
}

