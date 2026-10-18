package map.campaign.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dialog.view.SplitePointFrame;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.data.CampaignNode;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import mvc.module.room.RoomInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryWeddingDialogFrame extends Frame implements IManualSize
   {
      
      private var _npcName:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      protected var _vBox:VBox;
      
      protected var _itemList:Vector.<CampaignDialogOptionItem>;
      
      private var _iconView:BaseIconView;
      
      private var _iconHeight:int = 326;
      
      private var _minHeight:int = 113;
      
      private var _topLeading:int = 23;
      
      private var _ncLeading:int = 16;
      
      private var _ccHeight:int = 24;
      
      private var _cvLeading:int = 20;
      
      private var _bottomLeading:int = 23;
      
      private var _timer:Timer;
      
      private var _selfArmy:CampaignArmy;
      
      private var _helpBtn:BaseButton;
      
      private var _farme:SplitePointFrame;
      
      public var mapId:int = 0;
      
      protected var _data:CampaignNode;
      
      protected var leaveItem:CampaignDialogOptionItem;
      
      public function MarryWeddingDialogFrame()
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
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("MarryWeddingDialogFrame.helpBtn");
         addToContent(_helpBtn);
         _farme = ComponentFactory.Instance.creatComponentByStylename("core.SplitePointFrame");
         _farme.handPointFunction = handPoint;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _vBox.addEventListener("click",__onClickHandler);
         _helpBtn.addEventListener("click",__openHelperFrameHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_vBox)
         {
            _vBox.removeEventListener("click",__onClickHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelperFrameHandler);
         }
      }
      
      private function __openHelperFrameHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         SoundManager.instance.play("008");
         if(_data)
         {
            if(_data.param1 == 3)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("MarryWeddingDialogFrame.HelpFrame02");
            }
            else if(_data.param1 == 8)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("MarryWeddingDialogFrame.HelpFrame01");
            }
            if(_loc2_)
            {
               _loc2_.show();
            }
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
         var _loc9_:String = null;
         var _loc2_:String = null;
         var _loc13_:String = null;
         var _loc8_:String = null;
         var _loc10_:int = 0;
         var _loc14_:ConfigInfosTempInfo = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         SoundManager.instance.play("022");
         var _loc3_:CampaignDialogOptionItem = param1.target as CampaignDialogOptionItem;
         if(_data && _loc3_)
         {
            if(_loc3_.type == 104)
            {
               if(_loc3_.param > ResourceManager.instance.gold.count)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.gold"));
               }
               else
               {
                  SimpleAlertHelper.instance.data = [confirmCallback,_loc3_.param];
                  _loc9_ = LanguageMgr.GetTranslation("public.confirm");
                  _loc2_ = LanguageMgr.GetTranslation("public.cancel");
                  _loc13_ = LanguageMgr.GetTranslation("public.prompt");
                  _loc8_ = LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.confirmCall01",_loc3_.param);
                  SimpleAlertHelper.instance.popAlerFrame(_loc13_,_loc8_,_loc9_,_loc2_);
               }
            }
            else if(_loc3_.type == 109)
            {
               _loc10_ = 2000;
               _loc14_ = TempleteManager.instance.getConfigInfoByConfigName("marriage_fireworks");
               if(_loc14_ && !StringHelper.isNullOrEmpty(_loc14_.ConfigValue))
               {
                  _loc10_ = int(_loc14_.ConfigValue);
               }
               SimpleAlertHelper.instance.data = [itemClickBack,_loc3_.type];
               _loc11_ = LanguageMgr.GetTranslation("public.confirm");
               _loc12_ = LanguageMgr.GetTranslation("public.cancel");
               _loc6_ = LanguageMgr.GetTranslation("public.prompt");
               _loc4_ = LanguageMgr.GetTranslation("map.campaign.view.frame.buyTxt",_loc10_);
               SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc4_,_loc11_,_loc12_);
            }
            else if(_loc3_.type == 112)
            {
               _farme.show();
            }
            else if(_loc3_.type == 101)
            {
               _loc7_ = int(MarryManager.instance.model.marriageData.userId);
               _loc5_ = int(MarryManager.instance.model.selfMarryInfo.userId);
               if(roomInfo.playerList["_" + _loc7_] != null && roomInfo.playerList["_" + _loc5_] != null)
               {
                  if(!roomInfo.playerList["_" + _loc7_].online || !roomInfo.playerList["_" + _loc5_].online)
                  {
                     MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.view.frame.marryWeddingDialogFrame.isOnline"));
                  }
                  else
                  {
                     MarrySender.weddingDialogConfirm(_loc3_.type);
                  }
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("map.campaign.view.frame.marryWeddingDialogFrame.canStartWedding"));
               }
            }
            else
            {
               MarrySender.weddingDialogConfirm(_loc3_.type);
            }
         }
         dispose();
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      private function itemClickBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            MarrySender.weddingDialogConfirm(param3);
         }
      }
      
      private function confirmCallback(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            MarrySender.handGift(param3);
         }
      }
      
      private function handPoint(param1:int) : void
      {
         MarrySender.handPoint(param1);
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
         if(_data)
         {
            _npcName.text = LanguageMgr.GetTranslation("public.colon",_data.info.names);
            _itemList = new Vector.<CampaignDialogOptionItem>();
            if(!StringHelper.isNullOrEmpty(_data.param3))
            {
               _content.htmlText = _data.param3;
            }
            initOptions();
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
      
      protected function initOptions() : void
      {
         var _loc2_:int = int(CampaignManager.instance.mapId);
         if(WorldBossHelper.checkWedding(_loc2_))
         {
            initOptionsWedding();
         }
         var _loc1_:String = LanguageMgr.GetTranslation("friends.im.view.IMStateComBox.leave");
         leaveItem = new CampaignDialogOptionItem(mapId,_data.nodeId,_loc1_,_itemList.length);
         _vBox.addChild(leaveItem);
         _itemList.push(leaveItem);
         _vBox.refreshChildPos();
         _content.height = _content.numLines * _ccHeight;
         _content.y = _npcName.y + _npcName.height + _ncLeading;
         _vBox.x = _content.x;
         _vBox.y = _content.y + _content.height + _cvLeading;
      }
      
      private function initOptionsWedding() : void
      {
         var _loc2_:ConfigInfosTempInfo = null;
         var _loc1_:Array = null;
         if(!_data)
         {
            return;
         }
         if(_data.param1 == 3)
         {
            _helpBtn.tipData = LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.helpTitle02");
            if(marryModel.isWeddingMaster && marryModel.selfMarryInfo.speTemplateId != 0)
            {
               creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle1"),101);
            }
         }
         else if(_data.param1 == 8)
         {
            _helpBtn.tipData = LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.helpTitle01");
            if(marryModel.canAddCake)
            {
               creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle2"),102);
            }
            if(marryModel.canAddBubbly)
            {
               creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle3"),108);
            }
            if(marryModel.canFetchFlower)
            {
               creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle4"),103);
            }
            if(marryModel.canAddSweet)
            {
               creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle6"),107);
            }
            if(marryModel.canHandGift)
            {
               _loc2_ = TempleteManager.instance.getConfigInfoByConfigName("marriage_gift");
               if(_loc2_)
               {
                  _loc1_ = _loc2_.ConfigValue.split(",");
                  switch(int(marryModel.weddingInfo.property9) - 1)
                  {
                     case 0:
                        creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle7",_loc1_[2]),104,_loc1_[2]);
                        break;
                     case 1:
                        creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle7",_loc1_[1]),104,_loc1_[1]);
                        break;
                     case 2:
                        creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle7",_loc1_[0]),104,_loc1_[0]);
                        break;
                     default:
                        creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle7",1000000),104,100000);
                  }
               }
               else
               {
                  creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle7",1000000),104,100000);
               }
            }
            if(marryModel.canHandPoint)
            {
               creatOpItem(LanguageMgr.GetTranslation("map.campaign.view.frame.MarryWeddingDialogFrame.OptionsTitle8"),112);
            }
         }
      }
      
      private function creatOpItem(param1:String, param2:int, param3:int = 0) : void
      {
         var _loc4_:CampaignDialogOptionItem = null;
         _loc4_ = new CampaignDialogOptionItem(mapId,_data.nodeId,param1,param3,param2);
         _vBox.addChild(_loc4_);
         _itemList.push(_loc4_);
      }
      
      private function resetHeight() : void
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
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
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
         if(_helpBtn)
         {
            _helpBtn.dispose();
         }
         _helpBtn = null;
         _data = null;
         _selfArmy = null;
         super.dispose();
      }
   }
}

