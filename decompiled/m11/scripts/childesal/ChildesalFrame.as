package childesal
{
   import childesal.view.ChildesalItemView;
   import childesal.view.ChildesalRewardItemView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ChildesalEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildesalManager;
   import mvc.module.childseal.ChildesalModel;
   import mvc.module.childseal.ChildesalRewardInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class ChildesalFrame extends Frame implements IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _topHbox:HBox;
      
      private var _centerHbox:Sprite;
      
      private var _downHbox:HBox;
      
      private var _countNumTxt01:FilterFrameText;
      
      private var _countNumTxt02:FilterFrameText;
      
      private var _refreshRewardBtn:IconButton;
      
      private var _refreshIconBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _Progress:Bitmap;
      
      private var _ProgressRec:Sprite;
      
      private var _topItemList:Array;
      
      private var _centerItemList:Array;
      
      private var _downItemList:Array;
      
      private var maxWidth:int = 430;
      
      public function ChildesalFrame()
      {
         super();
         initView();
         addEvent();
         initInfo();
         ChildesalManager.instance.sendChildsealInfo(0);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,545,518);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("childesal.back");
         _topHbox = ComponentFactory.Instance.creatCustomObject("childesal.topHbox");
         _centerHbox = ComponentFactory.Instance.creatCustomObject("childesal.centerHbox");
         _downHbox = ComponentFactory.Instance.creatCustomObject("childesal.downHbox");
         _countNumTxt01 = ComponentFactory.Instance.creatComponentByStylename("childesal.countNumTxt01");
         _countNumTxt02 = ComponentFactory.Instance.creatComponentByStylename("childesal.countNumTxt02");
         _refreshIconBtn = ComponentFactory.Instance.creatComponentByStylename("childesal.refreshIconBtn");
         _refreshRewardBtn = ComponentFactory.Instance.creatComponentByStylename("childesal.refreshRewardBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("childesal.helpBtn2");
         _Progress = ComponentFactory.Instance.creatBitmap("asset.childesal.progressShow");
         _ProgressRec = new Sprite();
         _ProgressRec.graphics.beginFill(16711680);
         _ProgressRec.graphics.drawRect(0,0,maxWidth,_Progress.height);
         addToContent(_back);
         addToContent(_countNumTxt01);
         addToContent(_countNumTxt02);
         addToContent(_topHbox);
         addToContent(_centerHbox);
         addToContent(_downHbox);
         addToContent(_refreshIconBtn);
         addToContent(_refreshRewardBtn);
         addToContent(_Progress);
         addToContent(_ProgressRec);
         addToContent(_helpBtn);
         _ProgressRec.x = 45;
         _ProgressRec.y = 143;
         _Progress.mask = _ProgressRec;
         _helpBtn.tipData = LanguageMgr.GetTranslation("childseal.refreshTips03");
         creatTopItemList();
         creatCenterRewardlist();
         creatDownItemList();
      }
      
      private function creatTopItemList() : void
      {
         var _loc1_:ChildesalItemView = null;
         var _loc2_:int = 0;
         _topItemList = [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new ChildesalItemView();
            _topHbox.addChild(_loc1_);
            _topItemList.push(_loc1_);
            _loc2_ += 1;
         }
      }
      
      private function creatCenterRewardlist() : void
      {
         var _loc1_:ChildesalRewardItemView = null;
         var _loc2_:int = 0;
         _centerItemList = [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new ChildesalRewardItemView();
            _loc1_.x = 100 + _loc2_ * 70;
            _centerHbox.addChild(_loc1_);
            _centerItemList.push(_loc1_);
            _loc2_ += 1;
         }
      }
      
      private function creatDownItemList() : void
      {
         var _loc1_:ChildesalItemView = null;
         var _loc2_:int = 0;
         _downItemList = [];
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new ChildesalItemView();
            _loc1_.openClick = true;
            _loc1_.cell = cellItemClick;
            _downHbox.addChild(_loc1_);
            _downItemList.push(_loc1_);
            _loc1_.isChose = false;
            _loc2_ += 1;
         }
      }
      
      private function initInfo() : void
      {
         var _loc1_:ChildesalItemView = null;
         var _loc5_:ChildesalRewardItemView = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(_topItemList.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _topItemList[_loc3_];
            if(_loc3_ < model.sealsList.length)
            {
               _loc4_ = int(model.sealsList[_loc3_]);
               _loc1_.indexId = _loc4_;
               _loc1_.isChose = model.isInviteByIndexId(_loc4_);
            }
            _loc3_ += 1;
         }
         _loc2_ = int(_downItemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _downItemList[_loc3_];
            if(_loc3_ < model.choseList.length)
            {
               _loc4_ = int(model.choseList[_loc3_]);
               _loc1_.indexId = _loc4_;
               _loc1_.isChose = model.isHaveIndexId(_loc4_);
            }
            _loc3_ += 1;
         }
         _loc2_ = int(_centerItemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = _centerItemList[_loc3_];
            if(_loc3_ < model.rewardList.length)
            {
               _loc5_.info = model.rewardList[_loc3_];
            }
            _loc3_ += 1;
         }
         changeProgress();
      }
      
      private function changeProgress() : void
      {
         var _loc9_:ChildesalRewardInfo = null;
         var _loc5_:int = int(model.maxStarNum);
         var _loc1_:int = int(model.starCount);
         var _loc2_:int = int(model.countNum);
         _countNumTxt01.text = _loc1_ + "/" + _loc5_;
         if(_loc2_ >= model.maxCount)
         {
            _countNumTxt02.htmlText = "<font color=\'#ff0000\'>" + model.maxCount + "</font>" + "/" + model.maxCount;
         }
         else
         {
            _countNumTxt02.htmlText = _loc2_ + "/" + model.maxCount;
         }
         var _loc4_:Array = [121,191,261,331,401,430];
         var _loc6_:int = -1;
         var _loc3_:int = int(_centerItemList.length);
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc3_)
         {
            _loc9_ = model.rewardList[_loc7_];
            if(_loc1_ < _loc9_.starNum)
            {
               break;
            }
            _loc6_ = _loc7_;
            _loc7_ += 1;
         }
         var _loc8_:Number = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(_loc6_ == -1)
         {
            _loc10_ = int(model.rewardList[0].starNum);
            _loc11_ = _loc1_;
            _loc8_ = _loc11_ / _loc10_ * (121 / maxWidth);
         }
         else if(_loc6_ == 4)
         {
            _loc10_ = _loc5_ - model.rewardList[_loc6_].starNum;
            _loc11_ = _loc1_ - model.rewardList[_loc6_].starNum;
            if(_loc11_ == _loc10_)
            {
               _loc8_ = 1;
            }
            else
            {
               _loc8_ = _loc11_ / _loc10_ * (29 / maxWidth) + 401 / maxWidth;
            }
         }
         else
         {
            _loc10_ = model.rewardList[_loc6_ + 1].starNum - model.rewardList[_loc6_].starNum;
            _loc11_ = _loc1_ - model.rewardList[_loc6_].starNum;
            _loc8_ = _loc11_ / _loc10_ * ((_loc4_[_loc6_ + 1] - _loc4_[_loc6_]) / maxWidth) + _loc4_[_loc6_] / maxWidth;
         }
         _ProgressRec.scaleX = _loc8_;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _refreshIconBtn.addEventListener("click",__refreshIconOnClick);
         _refreshRewardBtn.addEventListener("click",__refreshRewardOnClick);
         model.addEventListener("CHILDSEAL_INFO_UP_DATA",__infoUpdata);
         _helpBtn.addEventListener("click",__onHelperBtnClick);
      }
      
      private function __infoUpdata(param1:ChildesalEvent) : void
      {
         initInfo();
      }
      
      private function __refreshIconOnClick(param1:MouseEvent) : void
      {
         var _loc5_:TodayNotAlertFrame = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = Boolean(SharedManager.instance.needAlertRefreshIcon);
         if(!_loc3_)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc4_ = LanguageMgr.GetTranslation("childseal.refreshTips01",model.refreshIconNeedGold);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc5_.show(_loc4_,_loc2_,refreshIconRefresh,null,"center",2,true);
         }
         else
         {
            refreshIconRefresh();
         }
      }
      
      private function refreshIconRefresh(param1:Boolean = false) : void
      {
         if(param1)
         {
            SharedManager.instance.needAlertRefreshIcon = true;
         }
         if(hasMoney(model.refreshIconNeedGold))
         {
            ChildesalManager.instance.sendChildsealInfo(2,0,1);
         }
      }
      
      private function __refreshRewardOnClick(param1:MouseEvent) : void
      {
         var _loc5_:TodayNotAlertFrame = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = Boolean(SharedManager.instance.needAlertRefreshReward);
         if(!_loc3_)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc4_ = LanguageMgr.GetTranslation("childseal.refreshTips02",model.refreshRewardNeedGold);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc5_.show(_loc4_,_loc2_,refreshRewardRefresh,null,"center",2,true);
         }
         else
         {
            refreshRewardRefresh();
         }
      }
      
      private function refreshRewardRefresh(param1:Boolean = false) : void
      {
         if(param1)
         {
            SharedManager.instance.needAlertRefreshReward = true;
         }
         if(hasMoney(model.refreshRewardNeedGold))
         {
            ChildesalManager.instance.sendChildsealInfo(3,0,1);
         }
      }
      
      private function __onHelperBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("childesal.ChildesalHelperFrame");
         _loc2_.show();
      }
      
      private function hasMoney(param1:int) : Boolean
      {
         var _loc2_:int = int(playerInfo.point);
         if(param1 > _loc2_)
         {
            RechargeAlertMannager.show();
            return false;
         }
         return true;
      }
      
      private function cellItemClick(param1:int) : void
      {
         ChildesalManager.instance.sendChildsealInfo(1,param1);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_refreshIconBtn)
         {
            _refreshIconBtn.removeEventListener("click",__refreshIconOnClick);
         }
         if(_refreshRewardBtn)
         {
            _refreshRewardBtn.removeEventListener("click",__refreshRewardOnClick);
         }
         model.removeEventListener("CHILDSEAL_INFO_UP_DATA",__infoUpdata);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__onHelperBtnClick);
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
      
      public function show() : void
      {
         this.titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_childseal");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : ChildesalModel
      {
         return ChildesalManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function disposeListItem() : void
      {
         var _loc1_:ChildesalItemView = null;
         var _loc5_:ChildesalRewardItemView = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(_topItemList.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _topItemList[_loc3_];
            _loc1_.dispose();
            _loc3_ += 1;
         }
         _loc2_ = int(_downItemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _downItemList[_loc3_];
            _loc1_.dispose();
            _loc3_ += 1;
         }
         _loc2_ = int(_centerItemList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = _centerItemList[_loc3_];
            _loc5_.dispose();
            _loc3_ += 1;
         }
         _topItemList = null;
         _centerItemList = null;
         _downItemList = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         disposeListItem();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_countNumTxt01);
         _countNumTxt01 = null;
         ObjectUtils.disposeObject(_countNumTxt02);
         _countNumTxt02 = null;
         ObjectUtils.disposeObject(_topHbox);
         _topHbox = null;
         ObjectUtils.disposeObject(_centerHbox);
         _centerHbox = null;
         ObjectUtils.disposeObject(_downHbox);
         _downHbox = null;
         ObjectUtils.disposeObject(_refreshIconBtn);
         _refreshIconBtn = null;
         ObjectUtils.disposeObject(_refreshRewardBtn);
         _refreshRewardBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_Progress);
         _Progress = null;
         ObjectUtils.disposeObject(_ProgressRec);
         _ProgressRec = null;
         super.dispose();
      }
   }
}

