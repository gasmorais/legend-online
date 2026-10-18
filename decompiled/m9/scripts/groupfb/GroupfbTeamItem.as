package groupfb
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GroupfbManager;
   import map.campaign.CampaignManager;
   import mvc.module.groupfb.GroupfbModel;
   import mvc.module.groupfb.GroupfbPlayerInfo;
   import mvc.module.groupfb.GroupfbSender;
   import room.view.invite.RoomInviteFrame;
   import yishi.filter.UIFilter;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   
   public class GroupfbTeamItem extends Component
   {
      
      public static const NAME:String = "groupfb.GroupfbTeamItem";
      
      private var _captainIcon:Image;
      
      private var _jobImage:ScaleFrameImage;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _fighting:FilterFrameText;
      
      private var _stateTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _delBtn:SimpleBitmapButton;
      
      private var _colorBg:ScaleFrameImage;
      
      private var _itemLineImg:MutipleImage;
      
      private var _data:GroupfbPlayerInfo;
      
      private var _registed:Boolean;
      
      private var _mediatorKey:String;
      
      private var _filter:UIFilter;
      
      public var team:int;
      
      public function GroupfbTeamItem()
      {
         super();
         buttonMode = true;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _colorBg = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.MemberItemBg");
         _itemLineImg = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.MemberItemLine");
         _captainIcon = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.CaptainFlag");
         _jobImage = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.jobImage");
         _name = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.name");
         _level = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.level");
         _fighting = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.fighting");
         _stateTxt = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.stateTxt");
         _delBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.EnterWarDelBtn");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamItem.AddBtn");
         _filter = new UIFilter();
         addChild(_colorBg);
         addChild(_itemLineImg);
         addChild(_captainIcon);
         addChild(_jobImage);
         addChild(_name);
         addChild(_level);
         addChild(_fighting);
         addChild(_stateTxt);
         addChild(_delBtn);
         addChild(_addBtn);
         _captainIcon.width = _captainIcon.height = 25;
      }
      
      private function unitView() : void
      {
         if(_colorBg)
         {
            _colorBg.dispose();
         }
         _colorBg = null;
         if(_itemLineImg)
         {
            _itemLineImg.dispose();
         }
         _itemLineImg = null;
         if(_captainIcon)
         {
            _captainIcon.dispose();
         }
         _captainIcon = null;
         if(_jobImage)
         {
            _jobImage.dispose();
         }
         _jobImage = null;
         if(_name)
         {
            _name.dispose();
         }
         _name = null;
         if(_level)
         {
            _level.dispose();
         }
         _level = null;
         if(_fighting)
         {
            _fighting.dispose();
         }
         _fighting = null;
         if(_stateTxt)
         {
            _stateTxt.dispose();
         }
         _stateTxt = null;
         if(_delBtn)
         {
            _delBtn.dispose();
         }
         _delBtn = null;
         if(_addBtn)
         {
            _addBtn.dispose();
         }
         _addBtn = null;
         _data = null;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("mouseOver",__onMouseOver);
         this.addEventListener("rollOut",__onMouseOut);
         if(_delBtn)
         {
            _delBtn.addEventListener("click",__delBtnHandler);
         }
         if(_addBtn)
         {
            _addBtn.addEventListener("click",__addBtnClickHandler);
         }
         if(_delBtn)
         {
            _delBtn.addEventListener("mouseDown",__mouseDownHandler);
         }
         if(_addBtn)
         {
            _addBtn.addEventListener("mouseDown",__mouseDownHandler);
         }
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseOver",__onMouseOver);
         this.removeEventListener("rollOut",__onMouseOut);
         if(_delBtn)
         {
            _delBtn.removeEventListener("click",__delBtnHandler);
         }
         if(_addBtn)
         {
            _addBtn.removeEventListener("click",__addBtnClickHandler);
         }
         if(_delBtn)
         {
            _delBtn.removeEventListener("mouseDown",__mouseDownHandler);
         }
         if(_addBtn)
         {
            _addBtn.removeEventListener("mouseDown",__mouseDownHandler);
         }
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __addBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:RoomInviteFrame = null;
         if(model.isCaptain)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("room.RoomInviteFrame");
            _loc2_.show();
         }
         param1.stopPropagation();
      }
      
      private function __delBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(model.isCaptain && _data)
         {
            SimpleAlertHelper.instance.data = [delCallBack];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("groupfb.GroupfbTeamItem.delTips",_data.nickName);
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
         }
         param1.stopPropagation();
      }
      
      private function delCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_data)
            {
               GroupfbSender.delPlayer(_data.userId);
            }
         }
      }
      
      public function get data() : GroupfbPlayerInfo
      {
         return _data;
      }
      
      public function set data(param1:GroupfbPlayerInfo) : void
      {
         if(isDie)
         {
            return;
         }
         _data = param1;
         if(_data == null || model.selfTeam == null || model.selfTeam.selfInfo == null)
         {
            clean();
         }
         else
         {
            refreshView();
         }
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      private function refreshView() : void
      {
         _colorBg.setFrame(1);
         _jobImage.visible = true;
         if(_data.job >= 1 && _data.job <= 4)
         {
            _jobImage.setFrame(_data.job);
         }
         else
         {
            _jobImage.setFrame(1);
         }
         _name.text = _data.nickName;
         _level.text = LanguageMgr.GetTranslation("public.level2",_data.grades);
         _fighting.text = "" + _data.fightCapacity;
         _captainIcon.visible = _data.userId == model.selfTeam.captainId;
         _delBtn.visible = _data && model.selfTeam.selfInfo != _data && model.isCaptain;
         _addBtn.visible = _data == null && Boolean(model.isCaptain);
         if(_data.userId == model.selfTeam.captainId)
         {
            _stateTxt.text = "";
         }
         else if(_data.state == 2 || Boolean(WorldBossHelper.checkGroupfb(CampaignManager.instance.mapId)))
         {
            _stateTxt.text = LanguageMgr.GetTranslation("groupfb.GroupfbTeamItem.ready");
         }
         else if(_data.state == 1)
         {
            _stateTxt.text = LanguageMgr.GetTranslation("groupfb.GroupfbTeamItem.wait");
         }
         if(_data.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            _name.setFrame(2);
            _level.setFrame(2);
            _fighting.setFrame(2);
            _stateTxt.setFrame(2);
         }
         else
         {
            _name.setFrame(1);
            _level.setFrame(1);
            _fighting.setFrame(1);
            _stateTxt.setFrame(1);
         }
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [GroupfbTeamItemDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"groupfb.GroupfbTeamItem");
      }
      
      private function clean() : void
      {
         _colorBg.setFrame(1);
         _jobImage.visible = false;
         _captainIcon.visible = false;
         _delBtn.visible = false;
         _addBtn.visible = model.isCaptain;
         _name.text = "";
         _level.text = "";
         _fighting.text = "";
         _stateTxt.text = "";
      }
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         if(_data && _colorBg)
         {
            _colorBg.setFrame(2);
         }
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         if(_colorBg)
         {
            _colorBg.setFrame(1);
         }
      }
      
      public function setGrayFilter() : void
      {
         _filter.setGrayFilter(this);
      }
      
      public function setNormalFilter() : void
      {
         _filter.setNormalFilter(this);
      }
      
      private function get model() : GroupfbModel
      {
         return GroupfbManager.instance.model;
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

