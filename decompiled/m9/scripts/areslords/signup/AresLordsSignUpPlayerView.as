package areslords.signup
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.areslords.AresLordsPlayerInfo;
   
   public class AresLordsSignUpPlayerView extends Component implements IManualSize
   {
      
      private var _bg:Image;
      
      private var _shadow:Image;
      
      private var _pointBg:Image;
      
      private var _none:Image;
      
      private var _medal:ScaleFrameImage;
      
      private var _avatar:ShowAvatar;
      
      private var _userName:FilterFrameText;
      
      private var _serverName:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _data:AresLordsPlayerInfo;
      
      public function AresLordsSignUpPlayerView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpPlayerBg");
         _avatar = ComponentFactory.Instance.creatCustomObject("areslords.SignUpPlayer",[false,__onCompleteHandler]);
         _shadow = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpPlayerShadow");
         _pointBg = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpPlayerPointBg");
         _none = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpPlayerNone");
         _medal = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpPlayerMedal");
         _userName = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpPlayerUserNameTxt");
         _serverName = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpPlayerServerNameTxt");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpPlayerPointTxt");
         addChild(_bg);
         addChild(_avatar);
         addChild(_shadow);
         addChild(_pointBg);
         addChild(_none);
         addChild(_medal);
         addChild(_userName);
         addChild(_serverName);
         addChild(_pointTxt);
         _avatar.mouseEnabled = _avatar.mouseChildren = false;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_avatar);
         _avatar = null;
         ObjectUtils.disposeObject(_shadow);
         _shadow = null;
         ObjectUtils.disposeObject(_pointBg);
         _pointBg = null;
         ObjectUtils.disposeObject(_none);
         _none = null;
         ObjectUtils.disposeObject(_medal);
         _medal = null;
         ObjectUtils.disposeObject(_userName);
         _userName = null;
         ObjectUtils.disposeObject(_serverName);
         _serverName = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         super.dispose();
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1 as AresLordsPlayerInfo;
         if(_data)
         {
            _avatar.data = _data.thaneInfo;
            _userName.text = _data.nickName + "";
            _serverName.text = _data.serverName + "";
            _pointTxt.htmlText = LanguageMgr.GetTranslation("areslords.SignUpFrame.score",_data.totalScore + "");
            ObjectUtils.removeFromParent(_shadow);
            ObjectUtils.removeFromParent(_none);
            addChild(_medal);
         }
         else
         {
            _avatar.data = null;
            _userName.text = "";
            _serverName.text = "";
            _pointTxt.text = "";
            addChild(_shadow);
            addChild(_none);
            ObjectUtils.removeFromParent(_medal);
         }
      }
      
      private function __onCompleteHandler() : void
      {
         if(_data && _data.thaneInfo)
         {
            _avatar.data = _data.thaneInfo;
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,290,309);
      }
   }
}

