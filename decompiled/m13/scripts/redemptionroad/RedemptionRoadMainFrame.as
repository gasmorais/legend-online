package redemptionroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.RedemptionRoadManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.redemptionroad.RedemptionRoadModel;
   import redemptionroad.item.RedemptionRoadDiffItem;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class RedemptionRoadMainFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _mainBg:MutipleImage;
      
      private var _diffImage:ScaleFrameImage;
      
      private var _processText:FilterFrameText;
      
      private var _rewardBox:HBox;
      
      private var _startBtn:IconButton;
      
      private var _diffBox:VBox;
      
      private var diffList:Vector.<RedemptionRoadDiffItem>;
      
      private var _tipTxt:FilterFrameText;
      
      public function RedemptionRoadMainFrame()
      {
         super();
         initView();
         initDiffView();
         addEvent();
         RedemptionRoadManager.instance.sendRedemptionRoadRequest(0);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,760,565);
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadMainFrame.border");
         _mainBg = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadMainFrame.mainBg");
         _diffImage = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadMainFrame.diffImage");
         _processText = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadMainFrame.processText");
         _rewardBox = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadMainFrame.rewardBox");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadMainFrame.startBtn");
         _diffBox = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadMainFrame.diffBox");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("RedemptionRoadMainFrame.refreshTipTxt");
         _tipTxt.text = LanguageMgr.GetTranslation("RedemptionRoadChapterFrame.refreshTip");
         addToContent(_border);
         addToContent(_mainBg);
         addToContent(_diffBox);
         addToContent(_diffImage);
         addToContent(_processText);
         addToContent(_rewardBox);
         addToContent(_startBtn);
         addToContent(_tipTxt);
      }
      
      private function initDiffView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RedemptionRoadDiffItem = null;
         diffList = new Vector.<RedemptionRoadDiffItem>();
         _loc2_ = int(model.maxDiffCount);
         while(_loc2_ > 0)
         {
            _loc1_ = new RedemptionRoadDiffItem(_loc2_);
            _diffBox.addChild(_loc1_);
            diffList.push(_loc1_);
            _loc2_--;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _startBtn.addEventListener("click",__startClickHandler);
         MsgMan.addObserver("USER_INFO_CHANGE",this,__userInfoBackHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__startClickHandler);
         }
         MsgMan.removeObserver("USER_INFO_CHANGE",this,__userInfoBackHandler);
      }
      
      private function __startClickHandler(param1:MouseEvent) : void
      {
         if(model.isCding)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("redemptionRoad.challenge.cdAlert"));
            return;
         }
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("redemptionroad","CHAPTER_FRAME");
      }
      
      private function __userInfoBackHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:RedemptionRoadDiffItem = null;
         var _loc6_:int = 0;
         var _loc3_:BaseItemView = null;
         _diffImage.setFrame(model.difficulty);
         if(model.difficulty == 2)
         {
            _diffImage.x = 558;
         }
         else
         {
            _diffImage.x = 568;
         }
         var _loc1_:int = model.curLayer - 1;
         _processText.text = _loc1_ + "/" + model.maxLayer;
         _startBtn.enable = !model.isClearance;
         _loc4_ = 0;
         while(_loc4_ < model.maxDiffCount)
         {
            _loc2_ = diffList[_loc4_];
            _loc2_.refreshView();
            _loc4_++;
         }
         _rewardBox.removeAllChild();
         var _loc5_:Array = getRewardsAry();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("RedemptionRoadMainFrame.rewardItem");
            _loc3_.data = _loc5_[_loc6_];
            _rewardBox.addChild(_loc3_);
            _loc6_++;
         }
      }
      
      private function getRewardsAry() : Array
      {
         if(model.difficulty == 1)
         {
            return ConfigInfoManager.instance.getRedemptionRoadReward1();
         }
         if(model.difficulty == 2)
         {
            return ConfigInfoManager.instance.getRedemptionRoadReward2();
         }
         if(model.difficulty == 3)
         {
            return ConfigInfoManager.instance.getRedemptionRoadReward3();
         }
         return [];
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
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : RedemptionRoadModel
      {
         return RedemptionRoadManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         this.titleText = LanguageMgr.GetTranslation("RedemptionRoadMainFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_mainBg);
         _mainBg = null;
         ObjectUtils.disposeObject(_diffImage);
         _diffImage = null;
         ObjectUtils.disposeObject(_processText);
         _processText = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_diffBox);
         _diffBox = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         LogicUtils.disposeDisplayCollection(diffList);
         diffList = null;
         super.dispose();
      }
   }
}

