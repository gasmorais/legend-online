package artifact
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.artifactgiftactivity.ArtifactGiftActivityMsg;
   import com.road.yishi.proto.artifactgiftactivity.ArtifactGiftActivityResMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.ArtifactManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.TurnControlII;
   import yishi.view.tips.MessageTipManager;
   
   public class ArtifactBoxView extends Component
   {
      
      private var _lotteryBtn:IconButton;
      
      private var _treasureNum:FilterFrameText;
      
      private var _note1:Bitmap;
      
      private var _list:Array = [];
      
      private var _lockBg:Bitmap;
      
      private var _openMc:MovieClip;
      
      private var _receiveBtn:IconButton;
      
      private var _lotteryBtnStrip:StripView;
      
      private var _receiveStrip:StripView;
      
      private var _rewardId:int;
      
      private var _rewardCount:int;
      
      private var _turnControl:TurnControlII;
      
      private var _posArr:Array = [[128,163],[188,203],[210,272],[189,341],[131,385],[57,383],[-1,340],[-23,273],[-2,205],[56,164]];
      
      private var _activityMsg:ArtifactGiftActivityMsg;
      
      private const NUM:int = 10;
      
      private var _canClose:Boolean = false;
      
      private var _filter:IFilterFormat;
      
      private var flickerArr:Array = [];
      
      private var _timeId:int;
      
      public function ArtifactBoxView()
      {
         super();
         initView();
         initList();
         initEvent();
      }
      
      private function initView() : void
      {
         _lotteryBtn = ComponentFactory.Instance.creatComponentByStylename("artifact.lotteryBtn");
         _note1 = ComponentFactory.Instance.creatBitmap("asset.artifact.artifactBoxNote1");
         _treasureNum = ComponentFactory.Instance.creatComponentByStylename("artifact.treasureNum");
         _lockBg = ComponentFactory.Instance.creatBitmap("asset.artifact.artifactLockBg");
         _openMc = ComponentFactory.Instance.creatCustomObject("artifact.artifactOpenMc");
         _receiveBtn = ComponentFactory.Instance.creatComponentByStylename("artifact.receiveBtn");
         _lotteryBtnStrip = ComponentFactory.Instance.creatCustomObject("artifact.lotteryBtnStrip");
         _receiveStrip = ComponentFactory.Instance.creatCustomObject("artifact.receiveStrip");
         addChild(_lockBg);
         addChild(_openMc);
         addChild(_note1);
         addChild(_lotteryBtnStrip);
         addChild(_receiveStrip);
         addChild(_receiveBtn);
         _lotteryBtnStrip.addChild(_lotteryBtn);
         _lotteryBtnStrip.addChild(_treasureNum);
         _receiveStrip.setHitArea(0,0,340,130);
         _lotteryBtnStrip.tipData = LanguageMgr.GetTranslation("artifact.ArtifactBoxView.lotteryBtnStrip");
         _filter = new UIFilter();
      }
      
      private function initEvent() : void
      {
         _receiveBtn.addEventListener("click",__receiveBtnHandler);
         _lotteryBtn.addEventListener("click",__lotteryBtnHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_MSG_RECORD",__activityMsgHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_MSG_RESULT",__activityResultHandler);
         NotificationManager.instance.addEventListener("ARTIFACT_BOX_FLICHER",__alertMessage);
         __activityMsgHandler(null);
      }
      
      private function removeEvent() : void
      {
         _receiveBtn.removeEventListener("click",__receiveBtnHandler);
         _lotteryBtn.removeEventListener("click",__lotteryBtnHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_MSG_RECORD",__activityMsgHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_MSG_RESULT",__activityResultHandler);
         NotificationManager.instance.removeEventListener("ARTIFACT_BOX_FLICHER",__alertMessage);
      }
      
      private function initList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:ArtifactBoxItem = null;
         var _loc4_:GoodsInfo = null;
         var _loc2_:Array = ArtifactManager.instance.boxTempArr;
         if(!_loc2_ || _loc2_ && _loc2_.length == 0)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("artifact.ArtifactBoxItem");
            _loc1_.x = _posArr[_loc3_][0];
            _loc1_.y = _posArr[_loc3_][1];
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[_loc3_].itemId;
            _loc1_.count = _loc2_[_loc3_].itemCount;
            _loc1_.Index = _loc2_[_loc3_].pos;
            _loc1_.data = _loc4_;
            addChild(_loc1_);
            _list.push(_loc1_);
            _loc3_++;
         }
         _turnControl = new TurnControlII();
      }
      
      private function __activityMsgHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc5_:int = 0;
         _activityMsg = ArtifactManager.instance.activityMsg;
         if(!_activityMsg)
         {
            return;
         }
         _treasureNum.text = String(_activityMsg.lotteryNum);
         _openMc.gotoAndStop("c" + _activityMsg.lotteryItems.length);
         if(!param1)
         {
            _loc2_ = LanguageMgr.GetTranslation("artifact.ArtifactBoxView.receiveStrip") + "\n";
            _loc3_ = ArtifactManager.instance.rewardTempArr;
            if(!_loc3_ || _loc3_ && _loc3_.length == 0)
            {
               return;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_[_loc5_].itemId);
               if(_loc4_)
               {
                  _loc2_ += _loc4_.TemplateName + " x" + _loc3_[_loc5_].itemCount;
                  _loc2_ += "\n";
               }
               _loc5_++;
            }
            _receiveStrip.tipData = _loc2_;
            closeEnable = true;
            setFilter();
         }
         if(_canClose)
         {
            _lotteryBtn.enable = _activityMsg.lotteryNum > 0;
            _receiveBtn.visible = _activityMsg.lotteryItems.length == ArtifactManager.instance.boxTempArr.length && !_activityMsg.rewarded;
            _receiveBtn.enable = _receiveBtn.visible;
         }
      }
      
      private function __alertMessage(param1:NotificationEvent) : void
      {
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_rewardId);
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("artifact.ArtifactBoxView.alertRewardTxt",_loc2_.TemplateName,_rewardCount),true,null,true);
         closeEnable = true;
         _lotteryBtn.enable = _activityMsg.lotteryNum > 0;
         _receiveBtn.visible = _activityMsg.lotteryItems.length == ArtifactManager.instance.boxTempArr.length && !_activityMsg.rewarded;
         _receiveBtn.enable = _receiveBtn.visible;
         setFilter();
      }
      
      private function __activityResultHandler(param1:NotificationEvent) : void
      {
         var evt:NotificationEvent = param1;
         _timeId = setTimeout(function():void
         {
            var _loc3_:int = 0;
            var _loc1_:ArtifactBoxItem = null;
            clearTimeout(_timeId);
            var _loc2_:ArtifactGiftActivityResMsg = evt.data as ArtifactGiftActivityResMsg;
            if(_loc2_.op == 0 && Boolean(_loc2_.result))
            {
               setFilter();
            }
            else if(_loc2_.op == 1 && Boolean(_loc2_.result))
            {
               _rewardId = _loc2_.item[0].itemId;
               _rewardCount = _loc2_.item[0].itemCount;
               _loc3_ = 0;
               while(_loc3_ < flickerArr.length)
               {
                  _loc1_ = flickerArr[_loc3_] as ArtifactBoxItem;
                  if(_loc1_.Index == _loc2_.lotteryPos)
                  {
                     _turnControl.turnPlate(_loc3_ + 1);
                  }
                  _loc3_++;
               }
            }
         },200);
      }
      
      private function setFilter() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ArtifactBoxItem = null;
         flickerArr = [];
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = _list[_loc2_] as ArtifactBoxItem;
            _loc1_.clearFlicker();
            _filter.setNormalFilter(_loc1_);
            if(_activityMsg.lotteryItems.indexOf(_loc1_.Index) != -1)
            {
               _filter.setGrayFilter(_loc1_);
            }
            else
            {
               flickerArr.push(_loc1_);
            }
            _loc2_++;
         }
         if(flickerArr.length != 0)
         {
            _turnControl.defaultTurn(flickerArr);
         }
         else
         {
            _turnControl.dispose();
            _turnControl = null;
            _turnControl = new TurnControlII();
         }
      }
      
      private function __receiveBtnHandler(param1:MouseEvent) : void
      {
         ArtifactManager.instance.OperateArtifact(2);
         _receiveBtn.enable = false;
      }
      
      private function __lotteryBtnHandler(param1:MouseEvent) : void
      {
         _lotteryBtn.enable = false;
         closeEnable = false;
         ArtifactManager.instance.OperateArtifact(1);
      }
      
      private function getArr(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function set closeEnable(param1:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.artifactControler.artifactOpen = false;
            KeyBoardRegister.instance.keyEnable = true;
            _canClose = true;
         }
         else
         {
            FrameControllerManager.instance.artifactControler.artifactOpen = true;
            KeyBoardRegister.instance.keyEnable = false;
            _canClose = false;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         clearTimeout(_timeId);
         if(_turnControl)
         {
            _turnControl.dispose();
         }
         _turnControl = null;
         closeEnable = true;
         removeEvent();
         if(_list)
         {
            while(_list.length)
            {
               ObjectUtils.disposeObject(_list.pop());
            }
            _list = null;
         }
         ObjectUtils.disposeObject(_lotteryBtn);
         _lotteryBtn = null;
         ObjectUtils.disposeObject(_treasureNum);
         _treasureNum = null;
         ObjectUtils.disposeObject(_note1);
         _note1 = null;
         ObjectUtils.disposeObject(_lockBg);
         _lockBg = null;
         ObjectUtils.disposeViolentMc(_openMc);
         _openMc = null;
         ObjectUtils.disposeObject(_receiveBtn);
         _receiveBtn = null;
         ObjectUtils.disposeObject(_lotteryBtnStrip);
         _lotteryBtnStrip = null;
         ObjectUtils.disposeObject(_receiveStrip);
         _receiveStrip = null;
         _posArr = null;
         _activityMsg = null;
         _filter = null;
         flickerArr.length = 0;
         super.dispose();
      }
   }
}

