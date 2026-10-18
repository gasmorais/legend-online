package fund
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.FundInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.FundEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class FundNewbieFrame extends Frame
   {
      
      private var _sexWoman:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private var _bgBox:Scale9CornerImage;
      
      private var _middleImg:Bitmap;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _fundBuy:FundBuyView;
      
      private var _fundReward:FundRewardView;
      
      private var _model:FundInfo;
      
      public function FundNewbieFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function initView() : void
      {
         _model = FundManager.instance.newbieModel;
         this.titleText = LanguageMgr.GetTranslation("fund.FundNewbieFrame.titleText");
         _sexWoman = ComponentFactory.Instance.creatBitmap("asset.fund.sexwomen");
         _bgBox = ComponentFactory.Instance.creatComponentByStylename("fund.bgBox");
         _middleImg = ComponentFactory.Instance.creatBitmap("asset.fund.middleImg");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("fund.bg1");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("fund.HelpBtn");
         addToContent(_sexWoman);
         addToContent(_bg1);
         addToContent(_bgBox);
         addToContent(_middleImg);
         addToContent(_helpBtn);
         _helpBtn.tipData = LanguageMgr.GetTranslation("fund.FundNewbieFrame.helpFrame.helpTitle");
         openView();
      }
      
      public function initEvent() : void
      {
         addEventListener("response",_frameResponse);
         FundManager.instance.addEventListener("OPEN",showGetHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
      }
      
      public function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
         FundManager.instance.removeEventListener("OPEN",showGetHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
      }
      
      public function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("fund.NewbieRewardHelpFrame");
         _loc2_.show();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_middleImg);
         _middleImg = null;
         ObjectUtils.disposeObject(_sexWoman);
         _sexWoman = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      public function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
         }
      }
      
      private function showGetHandler(param1:FundEvent) : void
      {
         openView();
      }
      
      private function openView() : void
      {
         if(_model.activeType == 1)
         {
            if(_fundReward)
            {
               _fundReward.dispose();
               _fundReward = null;
            }
            if(_model.depositLevel > 0)
            {
               if(_fundBuy)
               {
                  _fundBuy.dispose();
                  _fundBuy = null;
               }
               if(_fundReward == null)
               {
                  _fundReward = new FundRewardView();
                  addToContent(_fundReward);
               }
               return;
            }
            if(_fundBuy == null)
            {
               _fundBuy = new FundBuyView();
               addToContent(_fundBuy);
            }
         }
         else if(_model.activeType == 2 && _model.depositLevel > 0)
         {
            if(_fundBuy)
            {
               _fundBuy.dispose();
               _fundBuy = null;
            }
            if(_fundReward == null)
            {
               _fundReward = new FundRewardView();
               addToContent(_fundReward);
            }
         }
         show();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         if(_fundBuy != null)
         {
            this.width = 800;
            _helpBtn.x = 750;
            _bg1.width = 610;
            _bgBox.width = 600;
            _middleImg.x = 278;
         }
         else
         {
            this.width = 666;
            _helpBtn.x = 620;
            _bg1.width = 470;
            _bgBox.width = 460;
            _middleImg.x = 200;
         }
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

