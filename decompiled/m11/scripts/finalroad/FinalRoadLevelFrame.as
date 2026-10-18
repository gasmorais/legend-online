package finalroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.finalroad.FinalRoadEventRspMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.finalroad.FinalRoadGroupInfo;
   import mvc.module.finalroad.FinalRoadModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.FinalRoadGroupTempInfo;
   import yishi.manager.FinalRoadManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class FinalRoadLevelFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _titleImg:ScaleFrameImage;
      
      private var _titleTxt:GradientText;
      
      private var _back:ScaleFrameImage;
      
      private var _buffBtn:IconButton;
      
      private var _rewardsImg:Bitmap;
      
      private var _numTxt:GradientText;
      
      private var _progressMc:MovieClip;
      
      private var _challengeBtn:IconButton;
      
      private var _againBtn:IconButton;
      
      private var _giveUpBtn:IconButton;
      
      private var _lastNumTxt:FilterFrameText;
      
      private var _pointImg:Image;
      
      private var _pointTxt:FilterFrameText;
      
      private var _group:SelectedButtonGroup;
      
      private var _hBox:HBox;
      
      private var _sprite:Sprite;
      
      private var _bossIcon:Image;
      
      public function FinalRoadLevelFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,890,755);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("finalRoadLevelFrame.titleText" + model.currentChapter);
         _bg = ComponentFactory.Instance.creatBitmap("asset.finalRoadLevelFrame.bg");
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.titleImg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.titleTxt");
         _back = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.back");
         _buffBtn = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.buffBtn");
         _rewardsImg = ComponentFactory.Instance.creatBitmap("asset.finalRoadLevelFrame.rewardsImg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.numTxt");
         _progressMc = ComponentFactory.Instance.creatCustomObject("finalRoadLevelFrame.progressMc");
         _challengeBtn = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.challengeBtn");
         _againBtn = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.againBtn");
         _giveUpBtn = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.giveUpBtn");
         _lastNumTxt = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.lastNumTxt");
         _pointImg = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.pointImg");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.pointTxt");
         _hBox = ComponentFactory.Instance.creatCustomObject("finalRoadLevelFrame.hBox");
         _sprite = new Sprite();
         _bossIcon = ComponentFactory.Instance.creatComponentByStylename("finalRoadLevelFrame.bossIcon");
         addToContent(_bg);
         addToContent(_titleImg);
         addToContent(_titleTxt);
         addToContent(_back);
         addToContent(_buffBtn);
         addToContent(_rewardsImg);
         addToContent(_numTxt);
         addToContent(_progressMc);
         addToContent(_challengeBtn);
         addToContent(_sprite);
         addToContent(_hBox);
         addToContent(_bossIcon);
         _sprite.addChild(_againBtn);
         _sprite.addChild(_giveUpBtn);
         _sprite.addChild(_lastNumTxt);
         _sprite.addChild(_pointImg);
         _sprite.addChild(_pointTxt);
         _group = new SelectedButtonGroup();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("FINALROAD_GROUP_UPDATE",this,__finalRoadGroupHandler);
         _challengeBtn.addEventListener("click",__challengeBtnClickHandler);
         _againBtn.addEventListener("click",__againBtnClickHandler);
         _giveUpBtn.addEventListener("click",__giveUpBtnClickHandler);
         _buffBtn.addEventListener("click",__buffBtnClickHandler);
         MsgMan.addObserver("FINALROAD_CHAPTER_UPDATE",this,__finalRoadChapterHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("FINALROAD_GROUP_UPDATE",this,__finalRoadGroupHandler);
         _challengeBtn.removeEventListener("click",__challengeBtnClickHandler);
         _againBtn.removeEventListener("click",__againBtnClickHandler);
         _giveUpBtn.removeEventListener("click",__giveUpBtnClickHandler);
         _buffBtn.removeEventListener("click",__buffBtnClickHandler);
         MsgMan.removeObserver("FINALROAD_CHAPTER_UPDATE",this,__finalRoadChapterHandler);
      }
      
      private function __finalRoadChapterHandler(param1:String, param2:Object) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function __buffBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         if(data.levelSkills == "")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("finalRoadLevelFrame.levelSkills.text"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("finalroad",2);
      }
      
      private function __challengeBtnClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            return;
         }
         var _loc2_:FinalRoadEventRspMsg = data.events[_group.selectIndex];
         if(_loc2_)
         {
            FinalRoadManager.instance.send(2,_loc2_.monster);
         }
      }
      
      private function __againBtnClickHandler(param1:MouseEvent) : void
      {
         if(data.surplusLevelTimes == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("finalRoadLevelFrame.againBtn.text"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("finalRoadLevelFrame.againChallenge.content",point);
         SharedManagerHelper.ins.needAlert("finalroad.FinalRoadLevelFrame.againBtnClick",againCallBack,_loc2_,_loc3_);
      }
      
      private function againCallBack() : void
      {
         if(playerInfo.point < point)
         {
            RechargeAlertMannager.show();
            return;
         }
         FinalRoadManager.instance.send(3);
      }
      
      private function __giveUpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("finalRoadLevelFrame.giveUpChallenge.content");
         SharedManagerHelper.ins.needAlert("finalroad.FinalRoadLevelFrame.giveUp",giveUpCallBack,_loc2_,_loc3_);
      }
      
      private function giveUpCallBack() : void
      {
         FinalRoadManager.instance.send(4);
         FrameControllerManager.instance.openControllerByInfo("finalroad");
      }
      
      private function __finalRoadGroupHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(!data)
         {
            return;
         }
         _titleImg.setFrame(data.chapter);
         _back.setFrame(data.chapter);
         var _loc1_:int = int(TempleteManager.instance.finalRoadGroupTempCate.getMaxByChapter(data.chapter));
         _titleTxt.text = LanguageMgr.GetTranslation("finalRoadLevelFrame.titleTxt.text",data.level,_loc1_);
         var _loc2_:int = 5 - data.groupLevel + 1;
         _numTxt.text = _loc2_.toString();
         _progressMc.gotoAndStop(data.groupLevel);
         _lastNumTxt.text = LanguageMgr.GetTranslation("finalRoadLevelFrame.lastNumTxt.text",data.surplusLevelTimes);
         _pointTxt.text = point.toString();
         refreshItem();
         if(data.state == 0)
         {
            _challengeBtn.visible = true;
            _sprite.visible = false;
         }
         else if(data.state == 1)
         {
            _challengeBtn.visible = false;
            _sprite.visible = true;
         }
         refreshTip();
      }
      
      private function refreshTip() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:GoodsInfo = null;
         var _loc1_:String = LanguageMgr.GetTranslation("gamehall.GameHallRewardTipView.textFiledTitle");
         var _loc7_:int = Math.ceil(data.level / 5);
         var _loc4_:FinalRoadGroupTempInfo = TempleteManager.instance.finalRoadGroupTempCate.getTempInfoByChapterLevel(data.chapter,_loc7_);
         if(_loc4_)
         {
            _loc2_ = _loc4_.Reward.split("|");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               _loc5_ = _loc2_[_loc3_].split(",");
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc5_[0];
               _loc6_.count = _loc5_[1];
               _loc1_ += "\n" + LanguageMgr.GetTranslation("gamehall.GameHallRewardTipView.textFiledTxt",_loc6_.templateInfo.TemplateName,_loc6_.count);
               _loc3_++;
            }
         }
         _bossIcon.tipData = _loc1_;
      }
      
      private function refreshItem() : void
      {
         var _loc2_:FinalRoadLevelItem = null;
         var _loc3_:int = 0;
         var _loc1_:FinalRoadEventRspMsg = null;
         _hBox.removeAllChild();
         _group.removeAllItem();
         _loc3_ = 0;
         while(_loc3_ < data.events.length)
         {
            _loc2_ = new FinalRoadLevelItem();
            _loc1_ = data.events[_loc3_];
            _loc2_.data = _loc1_;
            _hBox.addChild(_loc2_);
            _group.addSelectItem(_loc2_);
            _loc3_++;
         }
         _group.selectIndex = 0;
         _hBox.x = 45 + (3 - _hBox.numChildren) * 133;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : FinalRoadModel
      {
         return FinalRoadManager.instance.model;
      }
      
      private function get data() : FinalRoadGroupInfo
      {
         return model.groupInfo;
      }
      
      private function get point() : int
      {
         return ConfigInfoManager.instance.finalRoadRepeatChallengePrice;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_buffBtn);
         _buffBtn = null;
         ObjectUtils.disposeObject(_rewardsImg);
         _rewardsImg = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeViolentMc(_progressMc);
         _progressMc = null;
         ObjectUtils.disposeObject(_challengeBtn);
         _challengeBtn = null;
         ObjectUtils.disposeObject(_againBtn);
         _againBtn = null;
         ObjectUtils.disposeObject(_giveUpBtn);
         _giveUpBtn = null;
         ObjectUtils.disposeObject(_lastNumTxt);
         _lastNumTxt = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeAllChildren(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

