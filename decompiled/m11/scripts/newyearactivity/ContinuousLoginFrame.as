package newyearactivity
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NewYearActManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class ContinuousLoginFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _back:Bitmap;
      
      private var _splieLine:Bitmap;
      
      private var _loginDayTitle:FilterFrameText;
      
      private var _getRewardTitle:FilterFrameText;
      
      private var _vbox:VBox;
      
      public function ContinuousLoginFrame()
      {
         super();
         initView();
         initEvent();
         initData(null);
      }
      
      private function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("newyearactivity.ContinuousLoginFrame.titleTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("newYearAct.continuousLoginBg");
         _back = ComponentFactory.Instance.creatBitmap("asset.newYearAct.continousLoginBg");
         _splieLine = ComponentFactory.Instance.creatBitmap("asset.newYearAct.titleSplitLine");
         _loginDayTitle = ComponentFactory.Instance.creatComponentByStylename("newYearAct.continuousLogin.loginDayTitleTxt");
         _getRewardTitle = ComponentFactory.Instance.creatComponentByStylename("newYearAct.continuousLogin.getRewardTitleTxt");
         _loginDayTitle.text = LanguageMgr.GetTranslation("countlogin.CountLoginFrame.loginDateText");
         _getRewardTitle.text = LanguageMgr.GetTranslation("countlogin.CountLoginFrame.rewardText");
         _vbox = new VBox();
         _vbox.x = 4;
         _vbox.y = 44;
         _vbox.spacing = 7;
         addToContent(_bg);
         addToContent(_back);
         addToContent(_splieLine);
         addToContent(_loginDayTitle);
         addToContent(_getRewardTitle);
         addToContent(_vbox);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_respose);
         NotificationManager.instance.addEventListener("NEWYEARLOGINREFRESH",initData);
         NotificationManager.instance.addEventListener("REFRESH_NEWYEAR_BTN",hide);
      }
      
      private function hide(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function initData(param1:NotificationEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ContinuousLoginItem = null;
         _vbox.removeAllChild();
         _loc3_ = 1;
         while(_loc3_ < 8)
         {
            _loc2_ = new ContinuousLoginItem();
            _loc2_.data = NewYearActManager.instance.loginModel.rewardInfos[_loc3_ - 1];
            _vbox.addChild(_loc2_);
            _loc3_++;
         }
         if(NewYearActManager.instance.isGetOver)
         {
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_respose);
         NotificationManager.instance.removeEventListener("NEWYEARLOGINREFRESH",initData);
         NotificationManager.instance.removeEventListener("REFRESH_NEWYEAR_BTN",hide);
      }
      
      private function _respose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         super.dispose();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_vbox)
         {
            ObjectUtils.disposeObject(_vbox);
         }
         _vbox = null;
         if(_splieLine)
         {
            ObjectUtils.disposeObject(_splieLine);
         }
         _splieLine = null;
      }
   }
}

