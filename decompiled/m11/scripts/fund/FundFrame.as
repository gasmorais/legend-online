package fund
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
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
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.FundInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.FundEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class FundFrame extends Frame implements IManualSize
   {
      
      private var _sexWoman:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private var _bgBox:Bitmap;
      
      private var _bgBox2:Scale9CornerImage;
      
      private var _middleImg:Bitmap;
      
      private var _bg1:ScaleBitmapImage;
      
      private var _fundBuy:FundNewBuyView;
      
      private var _fundReward:FundNewRewardView;
      
      private var _model:FundInfo;
      
      public function FundFrame()
      {
         super();
         _model = FundManager.instance.model;
         initView();
         initEvent();
         openView();
      }
      
      public function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("fund.FundFrame.titleText");
         _sexWoman = ComponentFactory.Instance.creatBitmap("asset.fundnew.sexwomen");
         _bgBox = ComponentFactory.Instance.creatBitmap("asset.fundnew.newbgBox");
         _bgBox2 = ComponentFactory.Instance.creatComponentByStylename("fund.bgBox");
         _middleImg = ComponentFactory.Instance.creatBitmap("asset.fund.middleImg");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("fund.newbg1");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("fund.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("fund.FundFrame.helpFrame.helpTitle");
         addToContent(_sexWoman);
         addToContent(_bg1);
         addToContent(_bgBox);
         addToContent(_bgBox2);
         _bgBox2.visible = false;
         addToContent(_middleImg);
         addToContent(_helpBtn);
         _bg1.x = 120;
         _bg1.width = 732;
         _helpBtn.x = 800;
      }
      
      public function initEvent() : void
      {
         addEventListener("response",_frameResponse);
         FundManager.instance.addEventListener("OPEN",showGetHandler);
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnClickHandler);
         }
      }
      
      public function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
         FundManager.instance.removeEventListener("OPEN",showGetHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         }
      }
      
      public function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("fund.RewardHelpFrame");
         _loc2_.show();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_sexWoman);
         _sexWoman = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_bgBox);
         _bgBox = null;
         ObjectUtils.disposeObject(_bgBox2);
         _bgBox2 = null;
         ObjectUtils.disposeObject(_middleImg);
         _middleImg = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_fundBuy);
         _fundBuy = null;
         ObjectUtils.disposeObject(_fundReward);
         _fundReward = null;
         ObjectUtils.disposeAllChildren(this);
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
            }
            if(_model.depositLevel > 0)
            {
               if(_fundBuy)
               {
                  _fundBuy.dispose();
               }
               if(_fundReward == null)
               {
                  _fundReward = new FundNewRewardView();
                  addToContent(_fundReward);
               }
               return;
            }
            if(_fundBuy == null)
            {
               _fundBuy = new FundNewBuyView();
               addToContent(_fundBuy);
            }
         }
         else if(_model.activeType == 2 && _model.depositLevel > 0)
         {
            if(_fundBuy)
            {
               _fundBuy.dispose();
            }
            if(_fundReward == null)
            {
               _fundReward = new FundNewRewardView();
               _fundReward.x = 207;
               _fundReward.y = 85;
               addToContent(_fundReward);
            }
         }
         show();
      }
      
      public function show() : void
      {
         if(_fundReward != null)
         {
            this.width = 666;
            this.height = 480;
            _helpBtn.x = 620;
            if(_bgBox)
            {
               ObjectUtils.disposeObject(_bgBox);
            }
            _bgBox = null;
            _bg1.width = 470;
            _bg1.height = 400;
            _bg1.x = 198;
            _bg1.y = 71;
            _bgBox2.visible = true;
            _bgBox2.x = 203;
            _bgBox2.y = 76;
            _bgBox2.height = 390;
            _sexWoman.x = -35;
            _sexWoman.y = 0;
         }
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,720,430);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

