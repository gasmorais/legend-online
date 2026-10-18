package im.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.PlayerInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.HeadIconCell;
   
   public class IMFriendInfoView extends Sprite implements Disposeable
   {
      
      private var _gmIcon:Image;
      
      private var _headCell:HeadIconCell;
      
      private var _stateImg:ScaleFrameImage;
      
      private var _nickName:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _serverName:FilterFrameText;
      
      private var _mood:FilterFrameText;
      
      private var _filter:UIFilter;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _data:ThaneInfo;
      
      private var _tipButton:BaseButton;
      
      private var _uninitList:Array = [];
      
      public function IMFriendInfoView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _gmIcon = ComponentFactory.Instance.creatComponentByStylename("core.ItemGmIcon");
         _headCell = ComponentFactory.Instance.creatCustomObject("core.IMFriendHeadIcon");
         _stateImg = ComponentFactory.Instance.creatComponentByStylename("core.IMFriendInfoStateImg");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("core.IMFriendNickNameTxt");
         _level = ComponentFactory.Instance.creatComponentByStylename("core.IMFriendLevelTxt");
         _serverName = ComponentFactory.Instance.creatComponentByStylename("core.serverNameText");
         _mood = ComponentFactory.Instance.creatComponentByStylename("core.IMFriendMoodTxt");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("core.IMFriend.VocationIcon");
         _filter = new UIFilter();
         _headCell.buttonMode = true;
         _mood.isAutoFitLength = true;
         _stateImg.setFrame(7);
         _vocationIcon.visible = false;
         addChild(_gmIcon);
         addChild(_headCell);
         addChild(_stateImg);
         addChild(_nickName);
         addChild(_level);
         addChild(_serverName);
         addChild(_mood);
         addChild(_vocationIcon);
      }
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         refreshView();
         refreshVocation();
      }
      
      private function refreshVocation() : void
      {
         var _loc1_:int = 0;
         if(_data && _data.vocationGrades > 0)
         {
            _loc1_ = int(isCross || !_data.templateInfo ? _data.job : int(_data.templateInfo.Job));
            _vocationIcon.tipData = PlayerManager.instance.getVocationName(_loc1_,_data.vocationStep,_data.vocationLevel);
            _vocationIcon.setFrame(_data.vocationLevel);
            _vocationIcon.visible = true;
            _level.x = _vocationIcon.x + _vocationIcon.width;
         }
         else
         {
            _vocationIcon.visible = false;
            _level.x = _vocationIcon.x;
         }
      }
      
      private function addEvent() : void
      {
         _headCell.addEventListener("click",__onHeadCellClick);
         _nickName.addEventListener("link",__onHeadCellClick);
         if(_data)
         {
            _data.addEventListener("PLAYER_STATE_CHANGE",refreshBaseView);
         }
      }
      
      private function removeEvent() : void
      {
         _headCell.removeEventListener("click",__onHeadCellClick);
         _nickName.removeEventListener("link",__onHeadCellClick);
         if(_data)
         {
            _data.removeEventListener("PLAYER_STATE_CHANGE",refreshBaseView);
         }
      }
      
      private function __onHeadCellClick(param1:Event) : void
      {
         if(isCross)
         {
            return;
         }
         if(_data)
         {
            PlayerInfoManager.instance.show(_data);
         }
      }
      
      private function _onHeadClick(param1:MouseEvent) : void
      {
         if(isCross)
         {
            return;
         }
         if(_data)
         {
            PlayerInfoManager.instance.show(_data);
         }
      }
      
      private function refreshBaseView(param1:PlayerEvent) : void
      {
         if(_data)
         {
            _stateImg.setFrame(_data.state);
            _data.isOnline ? (_headCell.filters = null) : _filter.setGrayFilter(_headCell);
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:String = null;
         if(_data)
         {
            addEvent();
            if(isCross)
            {
               _headCell.headId = _data.pics;
            }
            else
            {
               _headCell.headId = _data.snsInfo ? _data.snsInfo.headId : int(_data.templateId);
            }
            if(_data.right == 2)
            {
               _gmIcon.visible = true;
               _nickName.x = _gmIcon.x + _gmIcon.width;
            }
            else
            {
               _gmIcon.visible = false;
               _nickName.x = 50;
            }
            _nickName.text = _data.nickName;
            _serverName.text = "" + _data.serviceName;
            if(_tipButton)
            {
               ObjectUtils.disposeObject(_tipButton);
               _tipButton.removeEventListener("click",_onHeadClick);
               _tipButton = null;
            }
            if(_nickName.textWidth + 3 > _nickName.width)
            {
               _loc2_ = int(_nickName.getCharIndexAtPoint(_nickName.width - 22,5));
               _loc1_ = _nickName.text.substring(0,_loc2_) + "...";
               _nickName.htmlText = "<a href=\'event:#\'>" + _loc1_ + "</a>";
               _tipButton = ComponentFactory.Instance.creatComponentByStylename("core.CloseBtn");
               _tipButton.x = _nickName.x;
               _tipButton.y = _nickName.y;
               _tipButton.width = _nickName.width;
               _tipButton.height = _nickName.height;
               _tipButton.alpha = 1;
               _tipButton.tipData = _data.nickName;
               addChild(_tipButton);
               _tipButton.tipGapH = 0;
               _tipButton.tipGapV = 0;
               _tipButton.addEventListener("click",_onHeadClick);
               _uninitList.push(_tipButton);
            }
            else
            {
               _nickName.htmlText = "<a href=\'event:#\'>" + _data.nickName + "</a>";
            }
            _level.text = LanguageMgr.GetTranslation("public.level2",_data.grades);
            _level.x = _nickName.x + _nickName.textWidth + 15;
            _mood.text = _data.snsInfo.sign;
            refreshBaseView(null);
         }
      }
      
      private function get isCross() : Boolean
      {
         return _data.serviceName != null && _data.serviceName != "" && _data.serviceName != playerInfo.serviceName;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get moodTxt() : FilterFrameText
      {
         return _mood;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_headCell)
         {
            _headCell.filters = null;
         }
         if(_gmIcon)
         {
            _gmIcon.dispose();
         }
         _gmIcon = null;
         if(_nickName)
         {
            _nickName.dispose();
         }
         _nickName = null;
         if(_level)
         {
            _level.dispose();
         }
         _level = null;
         if(_mood)
         {
            _mood.dispose();
         }
         _mood = null;
         ObjectUtils.disposeObject(_headCell);
         _headCell = null;
         ObjectUtils.disposeObject(_filter);
         _filter = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_serverName);
         _serverName = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

