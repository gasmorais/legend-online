package apex
{
   import avatar.view.AppellView;
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.apex.ApexPlayerViewData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class ApexHallPlayerItem extends Sprite implements Disposeable, IEnterFrame
   {
      
      protected static const APPEL_ID:int = 163;
      
      private var _avatar:ShowAvatar;
      
      private var _nickName:GradientText;
      
      private var _serverName:GradientText;
      
      private var _defaultAvatar:ScaleFrameImage;
      
      private var _awaitImg:Bitmap;
      
      private var _index:int;
      
      private var _data:ThaneInfo;
      
      private var _honerView:AppellView;
      
      private var _vipIcon:Bitmap;
      
      private var apexPlayerViewData:ApexPlayerViewData;
      
      public function ApexHallPlayerItem(param1:int)
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
         _nickName = ComponentFactory.Instance.creatComponentByStylename("ui.apex.hall.nickname.gradient");
         _serverName = ComponentFactory.Instance.creatComponentByStylename("apex.hall.playerServerNameTxt.gradient");
         _defaultAvatar = ComponentFactory.Instance.creatComponentByStylename("apex.defaultAvatarImg");
         _awaitImg = ComponentFactory.Instance.creatBitmap("asset.apex.PleaseAwaitImg");
         _avatar.mouseEnabled = _avatar.mouseChildren = false;
         var _loc1_:int = 1;
         if(_index % 2 == 0)
         {
            _loc1_ = 2;
            _defaultAvatar.x = 60;
         }
         _defaultAvatar.setFrame(_loc1_);
         addChild(_avatar);
         addChild(_nickName);
         addChild(_serverName);
         var _loc2_:AppellInfoTemplate = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(163);
         _loc2_ = null;
         if(_loc2_)
         {
            _honerView = new AppellView(_loc2_);
            _honerView.x = -20;
            _honerView.y = 180;
         }
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
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         if(_honerView)
         {
            _honerView.draw();
         }
      }
      
      public function set data(param1:ApexPlayerViewData) : void
      {
         if(param1)
         {
            apexPlayerViewData = param1;
            _data = param1.thaneInfo;
            _avatar.data = _data;
            _nickName.text = _data.nickName;
            _serverName.text = "[" + param1.serverName + "]";
            if(_honerView)
            {
               addChild(_honerView);
            }
            if(_defaultAvatar.parent)
            {
               _defaultAvatar.parent.removeChild(_defaultAvatar);
            }
            if(_awaitImg.parent)
            {
               _awaitImg.parent.removeChild(_awaitImg);
            }
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
            if(_honerView != null && _honerView.parent)
            {
               _honerView.parent.removeChild(_honerView);
            }
            if(_defaultAvatar)
            {
               addChild(_defaultAvatar);
            }
            if(_awaitImg)
            {
               addChild(_awaitImg);
            }
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
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         ObjectUtils.disposeObject(_defaultAvatar);
         _defaultAvatar = null;
         ObjectUtils.disposeObject(_awaitImg);
         _awaitImg = null;
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         ObjectUtils.disposeObject(_serverName);
         _serverName = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

