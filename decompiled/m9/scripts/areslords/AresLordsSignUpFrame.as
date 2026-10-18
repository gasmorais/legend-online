package areslords
{
   import areslords.signup.AresLordsSignUpPlayerView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.areslords.AresLordsSignUpInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.AresLordsManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class AresLordsSignUpFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _titleImg:MutipleImage;
      
      private var _shopBtn:IconButton;
      
      private var _rankBtn:BaseButton;
      
      private var _signUpBtn:IconButton;
      
      private var _cost:Image;
      
      private var _costTxt:FilterFrameText;
      
      private var _time:Image;
      
      private var _timeTxt:FilterFrameText;
      
      private var _roundTxt:FilterFrameText;
      
      private var _playerTop:Component;
      
      private var _playerList:Vector.<AresLordsSignUpPlayerView>;
      
      private var _isOver:Boolean;
      
      public function AresLordsSignUpFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:Point = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameBg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameTitle");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameShopBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameRankBtn");
         _signUpBtn = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameSignUpBtn");
         _cost = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameCost");
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameCostTxt");
         _time = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameTime");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameTimeTxt");
         _roundTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFrameRoundTxt");
         _playerTop = ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpFramePlayerTop");
         addToContent(_bg);
         addToContent(_titleImg);
         addToContent(_shopBtn);
         addToContent(_rankBtn);
         addToContent(_signUpBtn);
         addToContent(_cost);
         addToContent(_costTxt);
         addToContent(_time);
         addToContent(_timeTxt);
         addToContent(_roundTxt);
         addToContent(_playerTop);
         _costTxt.text = LanguageMgr.GetTranslation("areslords.SignUpFrame.cost",ConfigInfoManager.instance.getAresNeedGold());
         titleText = LanguageMgr.GetTranslation("areslords.title");
         _playerList = new Vector.<AresLordsSignUpPlayerView>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _playerList.push(ComponentFactory.Instance.creatComponentByStylename("areslords.SignUpPlayerView"));
            _loc1_ = ComponentFactory.Instance.creatCustomObject("areslords.TopPlayerPos" + (_loc2_ + 1));
            _playerList[_loc2_].x = _loc1_.x;
            _playerList[_loc2_].y = _loc1_.y;
            _playerTop.addChild(_playerList[_loc2_]);
            _playerList[_loc2_].data = null;
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _shopBtn.addEventListener("click",__shopBtnClickHandler);
         _rankBtn.addEventListener("click",__rankBtnClickHandler);
         _signUpBtn.addEventListener("click",__signUpBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _shopBtn.removeEventListener("click",__shopBtnClickHandler);
         _rankBtn.removeEventListener("click",__rankBtnClickHandler);
         _signUpBtn.removeEventListener("click",__signUpBtnClickHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_signUpBtn);
         _signUpBtn = null;
         ObjectUtils.disposeObject(_cost);
         _cost = null;
         ObjectUtils.disposeObject(_costTxt);
         _costTxt = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_roundTxt);
         _roundTxt = null;
         if(_playerList)
         {
            while(_playerList.length)
            {
               ObjectUtils.disposeObject(_playerList.pop());
            }
            _playerList = null;
         }
         ObjectUtils.disposeObject(_playerTop);
         _playerTop = null;
         super.dispose();
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __shopBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",10);
      }
      
      private function __rankBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         AresLordsManager.instance.requestRankInfo();
         FrameControllerManager.instance.openControllerByInfo("areslords",2);
      }
      
      private function __signUpBtnClickHandler(param1:MouseEvent) : void
      {
         if(_isOver)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("areslords.Error.str03"));
            return;
         }
         SimpleAlertHelper.instance.data = [conformSignUp];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("areslords.Dialog.signup",ConfigInfoManager.instance.getAresNeedGold());
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function conformSignUp(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            AresLordsManager.instance.requestSignUp();
         }
      }
      
      public function set data(param1:AresLordsSignUpInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(param1)
         {
            _isOver = param1.isOver;
            _timeTxt.text = param1.openTime + "";
            _roundTxt.text = LanguageMgr.GetTranslation("areslords.SignUpFrame.round",param1.season,param1.warIndex);
            _loc3_ = 0;
            _loc2_ = int(_playerList.length);
            while(_loc3_ < _loc2_)
            {
               _playerList[_loc3_].data = param1.topList[_loc3_];
               _loc3_++;
            }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,884,640);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
   }
}

