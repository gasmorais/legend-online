package map.campaign.view.ui.deepprison
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import map.campaign.CampaignManager;
   import map.campaign.data.DeepPrisonModel;
   import utils.LogicUtils;
   import yishi.manager.PlayerManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.view.base.Progress;
   
   public class DeepPrisonUIView extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _openBg1:Image;
      
      private var _openBg2:Image;
      
      private var _totalScoreTxt:FilterFrameText;
      
      private var _selfScoreTxt:FilterFrameText;
      
      private var _openNextNeedScoreTxt:FilterFrameText;
      
      private var _progressBg1:MutipleImage;
      
      private var _progressBg2:MutipleImage;
      
      private var _totalProgress:Progress;
      
      private var _selfProgress:Progress;
      
      private var _totalSprite:Sprite;
      
      private var _selfSprite:Sprite;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _timer:TimerTicker;
      
      private var _vBox:VBox;
      
      private var _totalBoxList:Array;
      
      private var _selfBoxList:Array;
      
      public function DeepPrisonUIView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.back");
         _totalScoreTxt = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.totalScoreTxt");
         _selfScoreTxt = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.selfScoreTxt");
         _openNextNeedScoreTxt = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.openNextNeedScoreTxt");
         _progressBg1 = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.progressBg1");
         _progressBg2 = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.progressBg2");
         _totalProgress = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.totalProgress");
         _selfProgress = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.selfProgress");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.leftTimeTxt");
         _openBg1 = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.openBg1");
         _openBg2 = ComponentFactory.Instance.creatComponentByStylename("deepPrisonUIView.openBg2");
         _timer = new TimerTicker(1000);
         _timer.start();
         _vBox = new VBox();
         _vBox.x = 5;
         _vBox.y = 323;
         _vBox.spacing = -1;
         _totalSprite = new Sprite();
         _selfSprite = new Sprite();
         _totalSprite.x = 0;
         _totalSprite.y = 85;
         _selfSprite.x = 0;
         _selfSprite.y = 215;
         addChild(_back);
         addChild(_totalScoreTxt);
         addChild(_selfScoreTxt);
         addChild(_openNextNeedScoreTxt);
         addChild(_progressBg1);
         addChild(_progressBg2);
         addChild(_totalProgress);
         addChild(_selfProgress);
         addChild(_totalSprite);
         addChild(_selfSprite);
         addChild(_vBox);
         addChild(_leftTimeTxt);
         addChild(_openBg1);
         addChild(_openBg2);
         _totalBoxList = [];
         _selfBoxList = [];
         createBox(1);
         createBox(2);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_totalScoreTxt);
         _totalScoreTxt = null;
         ObjectUtils.disposeObject(_selfScoreTxt);
         _selfScoreTxt = null;
         ObjectUtils.disposeObject(_openNextNeedScoreTxt);
         _openNextNeedScoreTxt = null;
         ObjectUtils.disposeObject(_totalProgress);
         _totalProgress = null;
         ObjectUtils.disposeObject(_selfProgress);
         _selfProgress = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_totalSprite);
         _totalSprite = null;
         ObjectUtils.disposeObject(_selfSprite);
         _selfSprite = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         ObjectUtils.disposeObject(_openBg1);
         _openBg1 = null;
         ObjectUtils.disposeObject(_openBg2);
         _openBg2 = null;
         ObjectUtils.disposeObject(_progressBg1);
         _progressBg1 = null;
         ObjectUtils.disposeObject(_progressBg2);
         _progressBg2 = null;
         LogicUtils.disposeDisplayCollection(_selfBoxList);
         _selfBoxList = null;
         LogicUtils.disposeDisplayCollection(_totalBoxList);
         _totalBoxList = null;
         _timer = null;
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("DEEP_PRISION_UPDATE",this,__updateInfoHandler);
         if(_timer)
         {
            _timer.addEventListener("timer",__timerHandler);
         }
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("DEEP_PRISION_UPDATE",this,__updateInfoHandler);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      private function createBox(param1:int) : void
      {
         var _loc4_:DeepPrisonBoxItem = null;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:int = int(model.allRewardArray.length);
         var _loc7_:Array = model.allRewardArray;
         var _loc6_:Array = model.personalRewardArray;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new DeepPrisonBoxItem();
            _loc4_.type = param1;
            _loc4_.index = _loc5_;
            if(param1 == 1)
            {
               _loc3_ = model.allRewardArray[_loc5_].split(",");
               _loc4_.x = 184 * parseInt(_loc3_[0]) / parseInt(_loc7_[_loc2_ - 1]);
               _loc4_.data = model.allRewardArray[_loc5_];
               _totalSprite.addChild(_loc4_);
               _totalBoxList.push(_loc4_);
            }
            else
            {
               _loc3_ = model.personalRewardArray[_loc5_].split(",");
               _loc4_.x = 184 * parseInt(_loc3_[0]) / parseInt(_loc6_[_loc2_ - 1]);
               _loc4_.data = model.personalRewardArray[_loc5_];
               _totalSprite.addChild(_loc4_);
               _selfSprite.addChild(_loc4_);
               _selfBoxList.push(_loc4_);
            }
            _loc5_++;
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _leftTimeTxt.text = leftTime;
      }
      
      private function __updateInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:DeepPrisonBoxItem = null;
         var _loc3_:int = 0;
         _totalScoreTxt.text = model.allScore.toString();
         _selfScoreTxt.text = model.selfScore.toString();
         _openNextNeedScoreTxt.text = model.waveScore.toString();
         _leftTimeTxt.text = leftTime;
         var _loc4_:Array = model.allRewardArray;
         var _loc7_:Array = model.personalRewardArray;
         var _loc2_:int = int(_loc4_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _totalBoxList[_loc3_] as DeepPrisonBoxItem;
            _loc1_.data = _loc4_[_loc3_];
            _loc1_ = _selfBoxList[_loc3_] as DeepPrisonBoxItem;
            _loc1_.data = _loc7_[_loc3_];
            _loc3_++;
         }
         var _loc6_:String = _loc4_[_loc2_ - 1];
         var _loc5_:String = _loc7_[_loc2_ - 1];
         _totalProgress.setData(model.allScore,_loc6_.split(",")[0]);
         _selfProgress.setData(model.selfScore,_loc5_.split(",")[0]);
         model.selfMaxScore = _loc5_.split(",")[0];
         if(model.waveScore == -1)
         {
            _openBg2.visible = true;
            _openBg1.visible = false;
            _openNextNeedScoreTxt.visible = false;
         }
         else
         {
            _openBg2.visible = false;
            _openBg1.visible = true;
            _openNextNeedScoreTxt.visible = true;
         }
         initMemberVbox();
      }
      
      private function initMemberVbox() : void
      {
         var _loc2_:DeepPrisonScoreInfoItem = null;
         var _loc3_:int = 0;
         if(_vBox)
         {
            _vBox.removeAllChild();
         }
         var _loc4_:Array = model.scoreString.split("|");
         var _loc1_:int = int(_loc4_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = new DeepPrisonScoreInfoItem();
            _loc2_.index = _loc3_ + 1;
            _loc2_.data = _loc4_[_loc3_];
            _vBox.addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function get leftTime() : String
      {
         var _loc1_:String = "";
         var _loc3_:int = parseInt(model.endTime);
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.nowDate);
         if(_loc3_ > _loc2_)
         {
            _loc1_ = DateFormatter.getCountDateByMS((_loc3_ - _loc2_) / 1000);
         }
         return _loc1_;
      }
      
      private function get model() : DeepPrisonModel
      {
         return CampaignManager.instance.deepPrisonModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

