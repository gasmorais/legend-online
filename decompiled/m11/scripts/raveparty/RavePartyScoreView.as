package raveparty
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.RavePartyManager;
   import mvc.module.raveparty.RavePartyModel;
   import mvc.module.raveparty.RavePartyRewardInfo;
   import raveparty.sort.RavePartyScoreSortFrame;
   import utils.LogicUtils;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   
   public class RavePartyScoreView extends Component
   {
      
      private var curScoreImage:ScaleFrameImage;
      
      private var curScoreText:FilterFrameText;
      
      private var levelImage:Bitmap;
      
      private var numberBitmap:BitmapData;
      
      private var levelContnier:Component;
      
      private var gradeBar:ProgressCommon;
      
      private var scoreAlertText:FilterFrameText;
      
      private var itemPanel:ScrollPanel;
      
      private var itemVbox:VBox;
      
      private var itemList:Vector.<RavePartyScoreItemView>;
      
      private var guildScoreBtn:IconButton;
      
      private var serverScoreBtn:IconButton;
      
      private var showType:int;
      
      private var curLevel:int;
      
      private var curScore:int;
      
      private var curShowList:Array;
      
      public function RavePartyScoreView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         guildScoreBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.guildScoreBtn");
         serverScoreBtn = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.serverScoreBtn");
         curScoreImage = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.curScoreImage");
         curScoreText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.curScoreText");
         levelImage = ComponentFactory.Instance.creatBitmap("asset.RavePartyScoreView.levelImage");
         numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.RavePartyBoxImage.numberBitmap");
         levelContnier = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.levelContnier");
         gradeBar = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.gradeBar");
         scoreAlertText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.scoreAlertText");
         itemPanel = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.itemPanel");
         itemVbox = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.itemVbox");
         addChild(guildScoreBtn);
         guildScoreBtn.visible = false;
         addChild(serverScoreBtn);
         serverScoreBtn.visible = false;
         addChild(curScoreImage);
         addChild(curScoreText);
         addChild(scoreAlertText);
         addChild(levelImage);
         addChild(levelContnier);
         addChild(gradeBar);
         addChild(itemPanel);
         itemPanel.beginChanges();
         itemPanel.setView(itemVbox);
         itemPanel.invalidateViewport();
         itemPanel.commitChanges();
      }
      
      private function refresListView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:RavePartyRewardInfo = null;
         var _loc1_:RavePartyScoreItemView = null;
         itemVbox.removeAllChild();
         itemList = new Vector.<RavePartyScoreItemView>();
         _loc2_ = 0;
         while(_loc2_ < curShowList.length)
         {
            _loc3_ = curShowList[_loc2_];
            _loc1_ = new RavePartyScoreItemView();
            itemVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         itemPanel.beginChanges();
         itemPanel.invalidateViewport();
         itemPanel.commitChanges();
      }
      
      private function addEvent() : void
      {
         guildScoreBtn.addEventListener("click",__onSortClickHandler);
         serverScoreBtn.addEventListener("click",__onSortClickHandler);
         MsgMan.addObserver("RAVE_PARTY_TEMP_UPDTAE",this,__updateRavePartyTempHandler);
         MsgMan.addObserver("RAVE_PARTY_USERINFO_UPDTAE",this,__updateRavePartyUserInfoHandler);
      }
      
      private function removeEvent() : void
      {
         if(guildScoreBtn)
         {
            guildScoreBtn.removeEventListener("click",__onSortClickHandler);
         }
         if(serverScoreBtn)
         {
            serverScoreBtn.removeEventListener("click",__onSortClickHandler);
         }
         MsgMan.removeObserver("RAVE_PARTY_TEMP_UPDTAE",this,__updateRavePartyTempHandler);
         MsgMan.removeObserver("RAVE_PARTY_USERINFO_UPDTAE",this,__updateRavePartyUserInfoHandler);
      }
      
      private function __onSortClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = showType + 2;
         var _loc3_:RavePartyScoreSortFrame = ComponentFactory.Instance.creatComponentByStylename("raveparty.RavePartyScoreSortFrame",[_loc2_]);
         _loc3_.show();
      }
      
      private function __updateRavePartyTempHandler(param1:String, param2:Object) : void
      {
         setShowType(showType);
      }
      
      private function __updateRavePartyUserInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function setShowType(param1:int) : void
      {
         showType = param1;
         curScoreImage.setFrame(showType - 3);
         scoreAlertText.text = LanguageMgr.GetTranslation("RavePartyScoreView.scoreAlertText.text" + showType);
         if(showType == 4)
         {
            curScore = model.myTotalScore;
            curShowList = model.playerScoreRewardList;
         }
         else if(showType == 5)
         {
            curScore = model.myGuildScore;
            curShowList = model.guildScoreRewardList;
         }
         else if(showType == 6)
         {
            curScore = model.myServerScore;
            curShowList = model.serverScoreRewardList;
         }
         refresListView();
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         refreshBtnState();
         var _loc1_:Array = model.getCurGradeAndMaxData(curScore,curShowList);
         curLevel = _loc1_[0];
         curScoreText.text = curScore + "";
         curScoreText.x = curScoreImage.x + curScoreImage.getFrameImage(showType - 4).width + 4;
         NumberViewUtils.refreshValue(curLevel,levelContnier,numberBitmap,12,18,10,12,"0123456789");
         if(curScore >= curShowList[curShowList.length - 1].needValue)
         {
            gradeBar.value = 1;
            gradeBar.text = _loc1_[1];
         }
         else
         {
            gradeBar.value = curScore / _loc1_[1];
            gradeBar.text = curScore + "/" + _loc1_[1];
         }
         _loc2_ = 0;
         while(_loc2_ < curShowList.length)
         {
            itemList[_loc2_].data = curShowList[_loc2_] ? curShowList[_loc2_] : null;
            _loc2_++;
         }
      }
      
      private function refreshBtnState() : void
      {
         if(showType == 4)
         {
            guildScoreBtn.visible = false;
            serverScoreBtn.visible = false;
         }
         else if(showType == 5)
         {
            guildScoreBtn.visible = false;
            serverScoreBtn.visible = false;
         }
         else if(showType == 6)
         {
            guildScoreBtn.visible = false;
            serverScoreBtn.visible = false;
         }
      }
      
      private function get model() : RavePartyModel
      {
         return RavePartyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(guildScoreBtn)
         {
            ObjectUtils.disposeObject(guildScoreBtn);
         }
         guildScoreBtn = null;
         if(serverScoreBtn)
         {
            ObjectUtils.disposeObject(serverScoreBtn);
         }
         serverScoreBtn = null;
         if(curScoreImage)
         {
            ObjectUtils.disposeObject(curScoreImage);
         }
         curScoreImage = null;
         if(curScoreText)
         {
            ObjectUtils.disposeObject(curScoreText);
         }
         curScoreText = null;
         if(levelImage)
         {
            ObjectUtils.disposeObject(levelImage);
         }
         levelImage = null;
         if(numberBitmap)
         {
            ObjectUtils.disposeObject(numberBitmap);
         }
         numberBitmap = null;
         if(levelContnier)
         {
            ObjectUtils.disposeObject(levelContnier);
         }
         levelContnier = null;
         if(gradeBar)
         {
            ObjectUtils.disposeObject(gradeBar);
         }
         gradeBar = null;
         if(itemVbox)
         {
            ObjectUtils.disposeObject(itemVbox);
         }
         itemVbox = null;
         if(itemPanel)
         {
            ObjectUtils.disposeObject(itemPanel);
         }
         itemPanel = null;
         if(scoreAlertText)
         {
            ObjectUtils.disposeObject(scoreAlertText);
         }
         scoreAlertText = null;
         LogicUtils.disposeDisplayCollection(itemList);
         super.dispose();
      }
   }
}

