package outyard.titan
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.titanland.TitanlandOpMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardTitanFrame extends Frame
   {
      
      private var _titleBmp:Bitmap;
      
      private var _challengeBmp:Bitmap;
      
      private var _playerView4:OutyardTitanPlayerView;
      
      private var _playerView3:OutyardTitanPlayerView;
      
      private var _playerView2:OutyardTitanPlayerView;
      
      private var _playerView1:OutyardTitanPlayerView;
      
      private var _playerView0:OutyardTitanPlayerView;
      
      private var _rightView:OutyardTitanRightView;
      
      private var _addBtn:BaseButton;
      
      private var _numberAsset:BitmapData;
      
      private var _container1:Component;
      
      private var _progressMc:MovieClip;
      
      private var _progressBmp:Bitmap;
      
      private var _helpBtn:BaseButton;
      
      private var _progressFrame:Array = [85,67,47,29,11];
      
      private var _progressPosY:Array = [70,175,280,385,490];
      
      private var _bufferView:MagicSpringBufferAddView;
      
      public function OutyardTitanFrame()
      {
         super();
         initView();
         addEvent();
         OutyardManager.instance.OperateTitan(0);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _titleBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.titanTitleBmp");
         _challengeBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.titanAddChallengeBmp");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.titanAddChallengeBtn");
         _playerView0 = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanPlayerView");
         _playerView0.x = 100;
         _playerView0.y = 40;
         _playerView1 = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanPlayerView");
         _playerView1.x = 100;
         _playerView1.y = 145;
         _playerView2 = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanPlayerView");
         _playerView2.x = 100;
         _playerView2.y = 250;
         _playerView3 = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanPlayerView");
         _playerView3.x = 100;
         _playerView3.y = 355;
         _playerView4 = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanPlayerView");
         _playerView4.x = 100;
         _playerView4.y = 460;
         _rightView = ComponentFactory.Instance.creatCustomObject("outyard.titan.OutyardTitanRightView");
         _progressMc = ComponentFactory.Instance.creatCustomObject("asset.outyard.titanLevelMc");
         _progressBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.titanArrowBmp");
         _numberAsset = ComponentFactory.Instance.creatBitmapData("asset.outyard.titanExchangeNum");
         _container1 = new Component();
         _container1.x = 225;
         _container1.y = 15;
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("OutyardTitanFrame.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("OutyardTitanFrame.helpBtn.tipData");
         addToContent(_titleBmp);
         addToContent(_challengeBmp);
         addToContent(_playerView0);
         addToContent(_playerView1);
         addToContent(_playerView2);
         addToContent(_playerView3);
         addToContent(_playerView4);
         addToContent(_rightView);
         addToContent(_progressMc);
         addToContent(_progressBmp);
         addToContent(_addBtn);
         addToContent(_helpBtn);
         addToContent(_container1);
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(17);
         if(_loc1_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc1_);
            _bufferView.setDescText(_loc1_.tempInfo.Desc);
            _bufferView.x = 425;
            _bufferView.y = 15;
            addToContent(_bufferView);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_frameResponse);
         _addBtn.addEventListener("click",_addBtnClick);
         _helpBtn.addEventListener("click",__helpClickHandler);
         NotificationManager.instance.addEventListener("UPDATE_TITAN_VIEW",__updateTitanHandler);
         NotificationManager.instance.addEventListener("CLICK_TITAN_VIEW",__titanClickHandler);
      }
      
      private function removeEvent() : void
      {
         _addBtn.removeEventListener("click",_addBtnClick);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpClickHandler);
         }
         NotificationManager.instance.removeEventListener("UPDATE_TITAN_VIEW",__updateTitanHandler);
         NotificationManager.instance.removeEventListener("CLICK_TITAN_VIEW",__titanClickHandler);
         removeEventListener("response",_frameResponse);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("OutyardTitanFrame.helperFrame");
         _loc2_.show();
      }
      
      private function __titanClickHandler(param1:NotificationEvent) : void
      {
         __updateTitanHandler(null);
         _playerView0.index = 1;
         _playerView1.index = 2;
         _playerView2.index = 3;
         _playerView3.index = 4;
         _playerView4.index = 5;
      }
      
      private function __updateTitanHandler(param1:NotificationEvent) : void
      {
         var _loc3_:TitanlandOpMsg = OutyardManager.instance.titanModel.titanlandMsg;
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:Number = Number(_loc3_.fightLeftCount);
         NumberViewUtils.refreshValue(_loc2_,_container1,_numberAsset,16,22,10,16,"0123456789");
         _progressMc.gotoAndStop(_progressFrame[_loc3_.curLevel - 1]);
         _progressBmp.y = _progressPosY[_loc3_.curLevel - 1];
         _rightView.refreshView();
      }
      
      private function _addBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:Array = ConfigInfoManager.instance.getTitanLandFightCount();
         var _loc3_:int = int(OutyardManager.instance.titanModel.titanlandMsg.fightAddCount);
         if(int(_loc2_[2]) - _loc3_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("auction.view.mysteryshop.BuyGoodsItem.buyTipData"));
            return;
         }
         showPromptAlert();
      }
      
      private function showPromptAlert() : void
      {
         var _loc3_:Array = ConfigInfoManager.instance.getTitanLandFightCount();
         var _loc4_:int = int(OutyardManager.instance.titanModel.titanlandMsg.fightAddCount);
         SimpleAlertHelper.instance.data = [showPromptAlertBack,_loc3_[0]];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("OutyardTitanRightView.addFightLeftCountTxt",_loc3_[0],int(_loc3_[2]) - _loc4_);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc1_,_loc2_,true,true,false,2,"USEBINDPOINT_ALERT");
      }
      
      private function showPromptAlertBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            if(param2)
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(_loc5_ < param3)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               _loc4_ = param2 ? 0 : 1;
               OutyardManager.instance.OperateTitan(2,_loc4_);
            }
         }
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleBmp);
         _titleBmp = null;
         ObjectUtils.disposeObject(_challengeBmp);
         _challengeBmp = null;
         ObjectUtils.disposeObject(_playerView4);
         _playerView4 = null;
         ObjectUtils.disposeObject(_playerView3);
         _playerView3 = null;
         ObjectUtils.disposeObject(_playerView2);
         _playerView2 = null;
         ObjectUtils.disposeObject(_playerView1);
         _playerView1 = null;
         ObjectUtils.disposeObject(_playerView0);
         _playerView0 = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeViolentMc(_progressMc);
         _progressMc = null;
         ObjectUtils.disposeObject(_progressBmp);
         _progressBmp = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_container1);
         _container1 = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         super.dispose();
      }
   }
}

