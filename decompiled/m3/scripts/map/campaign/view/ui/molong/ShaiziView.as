package map.campaign.view.ui.molong
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.RollInfoMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.mediator.molong.MolongManager;
   import map.campaign.mediator.randomboss.RandomShaiziManager;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.timer.TimerTicker;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   
   public class ShaiziView extends Frame
   {
      
      private var _countDownValue:Sprite;
      
      private var _shaiziContainer:Sprite;
      
      private var _timer:TimerTicker;
      
      private var _totalTime:int = 30;
      
      private var _isClosing:Boolean = false;
      
      private var _bg:DisplayObject;
      
      public function ShaiziView()
      {
         MolongManager.instance.isShowShaiziView = true;
         RandomShaiziManager.instance.isShowShaiziView = true;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc7_:int = 0;
         var _loc1_:CampaignArmy = null;
         var _loc3_:ShaiziComp = null;
         _titleText = LanguageMgr.GetTranslation("map.campaign.view.ui.molong.shaiziViewTitle");
         _bg = ComponentFactory.Instance.creatComponentByStylename("molong.bg");
         this.addToContent(_bg);
         var _loc5_:DisplayObject = ComponentFactory.Instance.creatComponentByStylename("molong.numDownBg");
         this.addToContent(_loc5_);
         _countDownValue = new Sprite();
         _countDownValue.x = 47;
         _countDownValue.y = 2;
         this.addToContent(_countDownValue);
         _shaiziContainer = new Sprite();
         _shaiziContainer.x = -8;
         _shaiziContainer.y = 44;
         this.addToContent(_shaiziContainer);
         var _loc4_:int = 1;
         for each(var _loc2_:RollInfoMsg in CampaignManager.instance.mapModel.rollInfos)
         {
            if(CampaignManager.instance.mapModel.selfMemberData.userId != _loc2_.userId)
            {
               _loc1_ = CampaignManager.instance.mapModel.getUserArmyByUserId(_loc2_.userId);
               if(_loc1_)
               {
                  _loc3_ = new ShaiziComp(_loc1_.baseHero.headId,_loc1_.baseHero.nickName,_loc1_.baseHero.userId,_loc2_.rollNum,_loc2_.isRoll);
                  _loc3_.x = _loc4_ * 132;
                  _shaiziContainer.addChild(_loc3_);
                  _loc4_++;
               }
            }
            else
            {
               _loc7_ = int(_loc2_.rollNum);
            }
         }
         var _loc6_:ShaiziComp = new ShaiziComp(CampaignManager.instance.mapModel.selfMemberData.baseHero.headId,CampaignManager.instance.mapModel.selfMemberData.baseHero.nickName,CampaignManager.instance.mapModel.selfMemberData.userId,_loc7_,false,1);
         _loc6_.x = 0;
         _loc6_.y = 0;
         _shaiziContainer.addChild(_loc6_);
         CampaignManager.instance.mapModel.rollInfos = null;
         _timer = new TimerTicker(1000);
         _timer.addEventListener("timer",timeHandler);
         _timer.start();
         if(MolongManager.instance.reconnectedInfo && MolongManager.instance.reconnectedInfo.stateTm > 0)
         {
            _totalTime = (MolongManager.instance.reconnectedInfo.stateTm - (getTimer() - MolongManager.instance.startTimeAcceptMolongInfo)) / 1000;
         }
         else
         {
            _totalTime -= int((getTimer() - MolongManager.instance.startTimeShaizi) / 1000);
         }
         if(_totalTime > 30)
         {
            _totalTime = 30;
         }
         updateCountDown();
      }
      
      protected function timeHandler(param1:TimerEvent) : void
      {
         _totalTime = _totalTime - 1;
         if(_totalTime <= 0)
         {
            _totalTime = 0;
         }
         updateCountDown();
         if(_totalTime == 0 && !_isClosing)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
            dispose();
         }
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("map.campaign.view.ui.molong.GET_SHAIZI_INFO",this,getShaiziInfo);
         MsgMan.addObserver("map.campaign.view.ui.molong.FALL_BOXES",this,autoCloseWin);
      }
      
      private function autoCloseWin(param1:String, param2:Object) : void
      {
         _isClosing = true;
         setTimeout(dispose,3000);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("map.campaign.view.ui.molong.GET_SHAIZI_INFO",this,getShaiziInfo);
         MsgMan.removeObserver("map.campaign.view.ui.molong.FALL_BOXES",this,autoCloseWin);
      }
      
      private function getShaiziInfo(param1:String, param2:Array) : void
      {
         for each(var _loc3_:RollInfoMsg in param2)
         {
            if(CampaignManager.instance.mapModel.selfMemberData.userId != _loc3_.userId)
            {
               if(_loc3_.isRoll)
               {
                  MsgMan.notifyObserver("map.campaign.view.ui.molong.UPDATE_SHAIZI_INFO" + _loc3_.userId,_loc3_.rollNum);
               }
            }
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function updateCountDown() : void
      {
         var _loc1_:Bitmap = null;
         ObjectUtils.removeChildAllChildren(_countDownValue);
         _loc1_ = ComponentFactory.Instance.creatBitmap("asset.molong.num");
         NumberViewUtils.getNumberView(_totalTime,_countDownValue,_loc1_.bitmapData,28,30,25,28,"0123456789.",1);
         ObjectUtils.disposeObject(_loc1_);
         _loc1_ = null;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         MolongManager.instance.isShowShaiziView = false;
         RandomShaiziManager.instance.isShowShaiziView = false;
         removeEvent();
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         _bg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

