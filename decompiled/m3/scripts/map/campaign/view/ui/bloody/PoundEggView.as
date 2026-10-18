package map.campaign.view.ui.bloody
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.bloodyrealm.EggStateMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.mediator.bloody.BloodyManager;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.timer.TimerTicker;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   
   public class PoundEggView extends Frame
   {
      
      private var _countDownValue:Sprite;
      
      private var _shaiziContainer:Sprite;
      
      private var _timer:TimerTicker;
      
      private var _totalTime:Number = 30;
      
      private var _isClosing:Boolean = false;
      
      private var _bg:DisplayObject;
      
      private var _poundEggDesc:FilterFrameText;
      
      private var _myEggIndex:int = -1;
      
      private var _eggs:Vector.<EggItemView>;
      
      public function PoundEggView()
      {
         super();
         _eggs = new Vector.<EggItemView>();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:DisplayObject = ComponentFactory.Instance.creatComponentByStylename("bloody.countDownTxt");
         addToContent(_loc1_);
         _poundEggDesc = ComponentFactory.Instance.creatComponentByStylename("bloody.poundEggDesc");
         _poundEggDesc.text = LanguageMgr.GetTranslation("poundEggView.desc");
         addToContent(_poundEggDesc);
         _countDownValue = new Sprite();
         _countDownValue.x = 231;
         _countDownValue.y = 309;
         addToContent(_countDownValue);
         CampaignManager.instance.mapModel.rollInfos = null;
         _timer = new TimerTicker(1000);
         _timer.addEventListener("timer",timeHandler);
         _timer.start();
         if(BloodyManager.instance.reconnectedInfo && BloodyManager.instance.reconnectedInfo.stateTm > 0)
         {
            _totalTime = (BloodyManager.instance.reconnectedInfo.stateTm - (getTimer() - BloodyManager.instance.startTimeAcceptMolongInfo)) / 1000;
         }
         else
         {
            _totalTime -= int((getTimer() - BloodyManager.instance.startTimeShaizi) / 1000);
         }
         if(_totalTime > 30)
         {
            _totalTime = 30;
         }
         updateCountDown();
         addEggs();
      }
      
      private function addEggs() : void
      {
         var _loc2_:int = 0;
         var _loc1_:EggItemView = null;
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = new EggItemView(_loc2_);
            _loc1_.x = _loc2_ % 4 * 94 + 83;
            _loc1_.y = int(_loc2_ / 4) * 90 + 54;
            addToContent(_loc1_);
            _eggs.push(_loc1_);
            _loc2_++;
         }
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
            setTimeout(dispose,3000);
         }
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("map.campaign.view.ui.bloody.GET_EGG_INFO",this,getEggsInfo);
         MsgMan.addObserver("map.campaign.view.ui.bloody.FALL_BOXES",this,autoCloseWin);
         _closeButton && _closeButton.addEventListener("click",dispose);
      }
      
      private function autoCloseWin(param1:String, param2:Object) : void
      {
         _isClosing = true;
         setTimeout(dispose,3000);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("map.campaign.view.ui.bloody.GET_EGG_INFO",this,getEggsInfo);
         MsgMan.removeObserver("map.campaign.view.ui.bloody.FALL_BOXES",this,autoCloseWin);
         _closeButton && _closeButton.removeEventListener("click",dispose);
      }
      
      private function getEggsInfo(param1:String, param2:Array) : void
      {
         var _loc4_:int = 0;
         if(!param2)
         {
            return;
         }
         for each(var _loc3_:EggStateMsg in param2)
         {
            if(_loc3_.state > 0)
            {
               if(BloodyManager.instance.getPosByUserId(_loc3_.userId) == -1)
               {
                  if(CampaignManager.instance.mapModel.selfMemberData.userId == _loc3_.userId && BloodyManager.instance.myClickEggIndex != -1)
                  {
                     _loc4_ = BloodyManager.instance.myClickEggIndex;
                  }
                  else
                  {
                     _loc4_ = BloodyManager.instance.getRandomEmptyPos();
                  }
                  BloodyManager.instance.posInfo[_loc4_] = _loc3_.userId;
                  _eggs[_loc4_].playEggByType(_loc3_.state);
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
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         super.__onCloseClick(param1);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
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

