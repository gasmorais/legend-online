package friends.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.IMManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FriendManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.PlayerMenu;
   
   public class FriendItemButton extends Sprite implements Disposeable, ISelectable
   {
      
      private var _selected:Boolean;
      
      private var _bg:ScaleFrameImage;
      
      private var _deleteBtn:ScaleBitmapImage;
      
      private var _chatBtn:BaseButton;
      
      private var _icon:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _data:ThaneInfo;
      
      private var _enable:Boolean;
      
      private var _alert:BaseAlerFrame;
      
      private var _canDelete:Boolean;
      
      private var _vipText:GradientText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _isConsortiaPanel:Boolean;
      
      public function FriendItemButton(param1:Boolean = false)
      {
         super();
         _isConsortiaPanel = param1;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         buttonMode = true;
         canDelete = true;
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsItemBg");
         _bg.setFrame(1);
         _bg.mouseChildren = false;
         _bg.mouseEnabled = false;
         addChild(_bg);
         _icon = ComponentFactory.Instance.creatComponentByStylename("friends.ItemSexIcon");
         addChild(_icon);
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsDeleteBtn");
         var _loc2_:String = LanguageMgr.GetTranslation("friends.view.FriendsFrame.deleteBtnTipData");
         _deleteBtn.tipData = _loc2_;
         addChild(_deleteBtn);
         _chatBtn = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsChatBtn");
         addChild(_chatBtn);
         var _loc1_:String = LanguageMgr.GetTranslation("public.privateChat");
         _chatBtn.tipData = _loc1_;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("FriendsItemNameTextStyle");
         _nameTxt.mouseEnabled = false;
         addChild(_nameTxt);
         _level = ComponentFactory.Instance.creatComponentByStylename("FriendsItemLevelTextStyle");
         _level.mouseEnabled = false;
         addChild(_level);
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsItem.VocationIcon");
         _vocationIcon.visible = false;
         addChild(_vocationIcon);
         if(_isConsortiaPanel)
         {
            _chatBtn.x = 182;
         }
         _deleteBtn.visible = false;
         setVipIcon();
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _deleteBtn = null;
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function initEvent() : void
      {
         DoubleClickManager.Instance.enableDoubleClick(this);
         addEventListener("click",__onMouseClick);
         addEventListener("interactive_double_click",__onDoubleClick);
         addEventListener("rollOver",__onMouseRollover);
         addEventListener("rollOut",__onMouseRollout);
         _deleteBtn.addEventListener("click",__deleteHandler);
         _deleteBtn.addEventListener("mouseDown",__chatDownHandler);
         _chatBtn.addEventListener("click",__privateChatHandler);
         _chatBtn.addEventListener("mouseDown",__chatDownHandler);
      }
      
      private function removeEvent() : void
      {
         DoubleClickManager.Instance.disableDoubleClick(this);
         removeEventListener("click",__onMouseClick);
         removeEventListener("interactive_double_click",__onDoubleClick);
         removeEventListener("rollOver",__onMouseRollover);
         removeEventListener("rollOut",__onMouseRollout);
         if(_deleteBtn)
         {
            _deleteBtn.removeEventListener("click",__deleteHandler);
            _deleteBtn.removeEventListener("mouseDown",__chatDownHandler);
         }
         if(_chatBtn)
         {
            _chatBtn.removeEventListener("click",__privateChatHandler);
            _chatBtn.removeEventListener("mouseDown",__chatDownHandler);
         }
      }
      
      private function __chatDownHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function privateChat() : void
      {
         IMManager.instance.createIMFrame(_data);
      }
      
      private function __privateChatHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         privateChat();
      }
      
      private function __onDoubleClick(param1:Event) : void
      {
         privateChat();
      }
      
      private function __onMouseClick(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         if(_data is ThaneInfo && (_data as ThaneInfo).userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
         {
            return;
         }
         var _loc4_:Point = parent.localToGlobal(new Point(x,y + 20));
         var _loc2_:Boolean = Boolean(FreedomTeamManager.instance.canInviteMember(_data.userId,_data.grades));
         var _loc3_:PlayerMenu = new PlayerMenu(false,false,false,false,_loc2_);
         _loc3_.setData(_data);
         _loc3_.x = _loc4_.x - _loc3_.width;
         _loc3_.y = _loc4_.y - _loc3_.height;
         if(_loc3_.y < 0)
         {
            _loc3_.y = 0;
         }
         LayerManager.Instance.addToLayer(_loc3_,7);
      }
      
      protected function __onMouseRollover(param1:MouseEvent) : void
      {
         if(!selected)
         {
            _bg.setFrame(2);
            if(_enable)
            {
               _chatBtn.filters = [UIFilter.getLightingFilter()];
            }
            else
            {
               _chatBtn.filters = [UIFilter.getGrayFilter()];
            }
            if(!_canDelete)
            {
               _deleteBtn.visible = false;
            }
            else
            {
               _deleteBtn.visible = true;
            }
         }
      }
      
      protected function __onMouseRollout(param1:MouseEvent) : void
      {
         if(!selected)
         {
            if(!_enable)
            {
               _chatBtn.filters = [UIFilter.getGrayFilter()];
            }
            else
            {
               _chatBtn.filters = [UIFilter.getLightingFilter()];
            }
            _bg.setFrame(1);
            _deleteBtn.visible = false;
         }
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         param1.stopImmediatePropagation();
         if(_data)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.prompt");
            _loc3_ = "";
            switch(int(_data.relation) - 2)
            {
               case 0:
                  _loc3_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.str02");
                  _alert = AlertManager.Instance.simpleAlert(_loc2_,_loc3_ + _data.nickName,"","",true);
                  break;
               case 1:
                  _loc3_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.delStrangerTip");
                  _alert = AlertManager.Instance.simpleAlert(_loc2_,_loc3_ + _data.nickName,"","",true);
                  break;
               case 2:
                  _loc3_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.str01");
                  _alert = AlertManager.Instance.simpleAlert(_loc2_,_loc3_ + _data.nickName,"","",true);
                  break;
               default:
                  _loc3_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.str03");
                  _alert = AlertManager.Instance.simpleAlert(_loc2_,_loc3_ + _data.nickName,"","",true);
            }
            _alert.addEventListener("response",__resposeHandler);
         }
      }
      
      private function __resposeHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               _alert.removeEventListener("response",__resposeHandler);
               if(_data.relation != 4)
               {
                  FriendManager.getInstance().sendRemoveFriendRequest(_data.userId);
                  break;
               }
               FriendManager.getInstance().removePrivatePerson(_data.userId);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(!_enable)
         {
            return;
         }
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         if(_selected)
         {
            _bg.setFrame(3);
            _deleteBtn.visible = true;
            _nameTxt.setFrame(2);
            _level.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
            _deleteBtn.visible = false;
            _nameTxt.setFrame(1);
            _level.setFrame(1);
         }
      }
      
      public function get data() : ThaneInfo
      {
         return _data;
      }
      
      private function setVipIcon() : void
      {
         _vipText = ComponentFactory.Instance.creatComponentByStylename("FriendsItemNameGradientText");
         addChild(_vipText);
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         _nameTxt.text = param1.nickName;
         _level.text = LanguageMgr.GetTranslation("buildings.casern.view.RecruitPawnCell.command06",param1.grades);
         if(_data.sexs == 0)
         {
            _icon.setFrame(2);
         }
         else
         {
            _icon.setFrame(1);
         }
         switch(int(_data.relation) - 1)
         {
            case 0:
               _deleteBtn.tipData = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.str05");
               break;
            case 1:
               _deleteBtn.tipData = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.str04");
               break;
            case 2:
               _deleteBtn.tipData = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.delStrangerTip");
         }
         if(_data.IsVipAndNoExpirt)
         {
            _vipText.visible = true;
            _nameTxt.visible = false;
            _vipText.text = _nameTxt.text;
         }
         else
         {
            _vipText.visible = false;
            _nameTxt.visible = true;
         }
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         if(_data && _data.vocationGrades > 0)
         {
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_data.templateInfo.Job,_data.vocationStep,_data.vocationLevel);
            _vocationIcon.setFrame(_data.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function set enable(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:DisplayObject = null;
         _enable = param1;
         _loc3_ = 0;
         while(_loc3_ < numChildren)
         {
            _loc2_ = getChildAt(_loc3_);
            if(_loc2_ != _deleteBtn)
            {
               _loc2_.filters = _enable ? null : [UIFilter.getGrayFilter()];
            }
            _loc3_++;
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
      }
      
      public function get canDelete() : Boolean
      {
         return _canDelete;
      }
      
      public function set canDelete(param1:Boolean) : void
      {
         _canDelete = param1;
         if(!_canDelete)
         {
            _deleteBtn.visible = false;
         }
      }
      
      public function set chatVisible(param1:Boolean) : void
      {
         _chatBtn.visible = param1;
      }
      
      override public function get height() : Number
      {
         return _bg.height - 5;
      }
   }
}

