package sevenyear.view.gloryGame
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.gloryGame.GloryGameTeamPlayer;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   
   public class SevenYearGloryGameHallPlayer extends Sprite implements Disposeable
   {
      
      protected static const APPEL_ID:int = 163;
      
      private var _avatar:ShowAvatar;
      
      private var _nickName:GradientText;
      
      private var _serverName:FilterFrameText;
      
      private var _index:int;
      
      private var _data:ThaneInfo;
      
      private var _vipIcon:Bitmap;
      
      private var apexPlayerViewData:GloryGameTeamPlayer;
      
      public function SevenYearGloryGameHallPlayer(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _avatar = new ShowAvatar(false,__onCompleteHandler);
         _avatar.scaleX = _avatar.scaleY = 0.85;
         _nickName = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.gloryGame.nickname.gradient");
         _serverName = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.gloryGame.playerServerNameTxt");
         _avatar.mouseEnabled = _avatar.mouseChildren = false;
         addChild(_avatar);
         addChild(_nickName);
         addChild(_serverName);
      }
      
      private function __onCompleteHandler() : void
      {
         var _loc1_:Boolean = false;
         if(_data)
         {
            _avatar.data = _data;
            _loc1_ = Boolean(PlayerManager.instance.getIsDragonTalkerState(_data));
            _avatar.y = _loc1_ ? 40 : 50;
         }
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set data(param1:GloryGameTeamPlayer) : void
      {
         if(param1)
         {
            apexPlayerViewData = param1;
            _data = param1.thaneInfo;
            _avatar.data = _data;
            _nickName.text = _data.nickName;
            _serverName.text = "[" + param1.serverName + "]";
            if(isVip)
            {
               setVipIcon();
               _vipIcon.x = _nickName.x + (_nickName.width - _nickName.textWidth) / 2 - _vipIcon.width - 3;
               _vipIcon.y = _nickName.y + 2;
            }
         }
         else
         {
            _avatar.data = null;
            _nickName.text = "";
            _serverName.text = "";
         }
      }
      
      private function get isVip() : Boolean
      {
         return apexPlayerViewData.vipType != 0;
      }
      
      private function setVipIcon() : void
      {
         _vipIcon || (_vipIcon = ComponentFactory.Instance.creatBitmap("asset.core.simpleVIPIcon"));
         addChild(_vipIcon);
         _vipIcon.scaleX = _vipIcon.scaleY = 1;
      }
      
      override public function get width() : Number
      {
         return 163;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         ObjectUtils.disposeObject(_serverName);
         _serverName = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

