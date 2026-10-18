package matelords
{
   import avatar.view.AppellView;
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.matelords.MatelordsModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MatelordsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class MatelordsTopItemView extends Sprite implements Disposeable, IEnterFrame
   {
      
      protected static const APPEL_ID:int = 163;
      
      private var _platform:Bitmap;
      
      private var _avatar:ShowAvatar;
      
      private var _nameBg:Bitmap;
      
      private var _nickName:FilterFrameText;
      
      private var _defaultAvatar:ScaleFrameImage;
      
      private var _awaitImg:Bitmap;
      
      private var _index:int;
      
      private var _data:ThaneInfo;
      
      private var _honerView:AppellView;
      
      private var _model:MatelordsModel = MatelordsManager.instance.model;
      
      public function MatelordsTopItemView(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _platform = ComponentFactory.Instance.creatBitmap("asset.matelords.MatelordsTopItemPlatformBg");
         _avatar = ComponentFactory.Instance.creatCustomObject("matelords.MatelordsTopItemAvatar",[false,__onCompleteHandler]);
         _nameBg = ComponentFactory.Instance.creatBitmap("asset.matelords.MatelordsTopItemNameBg");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsTopItemNickNameTxt");
         _defaultAvatar = ComponentFactory.Instance.creatComponentByStylename("matelords.MatelordsTopItemDefaultAvatarImg");
         _awaitImg = ComponentFactory.Instance.creatBitmap("asset.matelords.PleaseAwaitImg");
         _avatar.mouseEnabled = _avatar.mouseChildren = false;
         var _loc1_:int = 1;
         switch(_index - 2)
         {
            case 0:
               _defaultAvatar.x = -60;
               _defaultAvatar.y = 7;
               _loc1_ = 2;
         }
         _defaultAvatar.setFrame(_loc1_);
         addChild(_platform);
         addChild(_avatar);
         addChild(_nameBg);
         addChild(_nickName);
         var _loc2_:AppellInfoTemplate = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(163);
         if(_loc2_)
         {
            _honerView = new AppellView(_loc2_);
            _honerView.x = -20;
            _honerView.y = 230;
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
      
      public function set data(param1:ThaneInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _avatar.data = _data;
            _nickName.text = _data.nickName;
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
         }
         else
         {
            _avatar.data = null;
            _nickName.text = "";
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
         ObjectUtils.disposeObject(_platform);
         _platform = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_nameBg);
         _nameBg = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         ObjectUtils.disposeObject(_defaultAvatar);
         _defaultAvatar = null;
         ObjectUtils.disposeObject(_awaitImg);
         _awaitImg = null;
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

