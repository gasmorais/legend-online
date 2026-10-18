package alchemical.makeview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.alchemical.AlchemicalModel;
   import utils.LogicUtils;
   import yishi.manager.AlchemicalManager;
   import yishi.utils.MsgMan;
   
   public class AlchemicalMakeNoteBookView extends Component
   {
      
      private var aboveBack:Bitmap;
      
      private var scoreText:FilterFrameText;
      
      private var descText:FilterFrameText;
      
      private var lookRewardText:FilterFrameText;
      
      private var rewardView:AlchemicalScoreRewardView;
      
      private var singleBtn:SelectedIconTextButton;
      
      private var cooperationBtn:SelectedIconTextButton;
      
      private var btnGroup:SelectedButtonGroup;
      
      private var btnItemVBox:VBox;
      
      private var btnItemPanel:ScrollPanel;
      
      private var itemList:Vector.<AlchemicalMakeFormulaBtnItem>;
      
      private var _currentSelected:SelectedButton;
      
      private var formulaItemList:Object = {};
      
      private var typeCount:int = 6;
      
      public function AlchemicalMakeNoteBookView()
      {
         super();
         initView();
         initListView();
         addEvent();
         refreshDataView();
         model.selectFormulaType = 1;
      }
      
      private function initView() : void
      {
         aboveBack = ComponentFactory.Instance.creatBitmap("asset.AlchemicalMakeNoteBookView.aboveBack");
         scoreText = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeNoteBookView.scoreText");
         descText = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeNoteBookView.descText");
         lookRewardText = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeNoteBookView.lookRewardText");
         cooperationBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeNoteBookView.cooperationBtn");
         singleBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeNoteBookView.singleBtn");
         btnItemVBox = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeNoteBookView.btnItemVBox");
         btnItemPanel = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeNoteBookView.btnItemPanel");
         addChild(aboveBack);
         addChild(scoreText);
         addChild(descText);
         addChild(lookRewardText);
         addChild(cooperationBtn);
         addChild(singleBtn);
         addChild(btnItemPanel);
         btnItemPanel.setView(btnItemVBox);
         btnItemPanel.invalidateViewport();
         btnItemPanel.commitChanges();
         lookRewardText.htmlText = LanguageMgr.GetTranslation("AlchemicalMakeNoteBookView.lookRewardText.text");
         lookRewardText.mouseEnabled = true;
         singleBtn.text = LanguageMgr.GetTranslation("AlchemicalMakeNoteBookView.singleBtn.text");
         cooperationBtn.text = LanguageMgr.GetTranslation("AlchemicalMakeNoteBookView.cooperationBtn.text");
         btnGroup = new SelectedButtonGroup();
         btnGroup.addSelectItem(cooperationBtn);
         btnGroup.addSelectItem(singleBtn);
         btnGroup.selectIndex = 0;
         model.modelType = btnGroup.selectIndex + 1;
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AlchemicalMakeFormulaBtnItem = null;
         itemList = new Vector.<AlchemicalMakeFormulaBtnItem>();
         _loc2_ = 0;
         while(_loc2_ < typeCount)
         {
            _loc1_ = new AlchemicalMakeFormulaBtnItem(_loc2_ + 1);
            btnItemVBox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         btnItemVBox.commitChanges();
         btnItemPanel.invalidateViewport();
         btnItemPanel.commitChanges();
      }
      
      private function addEvent() : void
      {
         lookRewardText.addEventListener("click",__lookRewardHandler);
         btnGroup.addEventListener("change",__selectedChangHandler);
         MsgMan.addObserver("ALCHEMICAL_SELFINFO_UPGATE",this,__updateSelfDataChange);
         MsgMan.addObserver("SELECT_BTNTYPE_CHANGE",this,__updateFormulaChange);
         MsgMan.addObserver("SELECT_MODELTYPE_CHANGE",this,__updateFormulaChange);
         MsgMan.addObserver("FORMULA_LISTVIEW_UPDATE",this,__updateListViewHandler);
      }
      
      private function removeEvent() : void
      {
         lookRewardText.removeEventListener("click",__lookRewardHandler);
         btnGroup.removeEventListener("change",__selectedChangHandler);
         MsgMan.removeObserver("ALCHEMICAL_SELFINFO_UPGATE",this,__updateSelfDataChange);
         MsgMan.removeObserver("SELECT_BTNTYPE_CHANGE",this,__updateFormulaChange);
         MsgMan.removeObserver("SELECT_MODELTYPE_CHANGE",this,__updateFormulaChange);
         MsgMan.removeObserver("FORMULA_LISTVIEW_UPDATE",this,__updateListViewHandler);
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         model.selectFormulaInfo = null;
         model.modelType = btnGroup.selectIndex + 1;
      }
      
      private function __updateListViewHandler(param1:String, param2:Object) : void
      {
         btnItemVBox.commitChanges();
         btnItemPanel.invalidateViewport();
         btnItemPanel.commitChanges();
      }
      
      private function __lookRewardHandler(param1:MouseEvent) : void
      {
         if(rewardView && !rewardView.isDie)
         {
            ObjectUtils.disposeObject(rewardView);
            rewardView = null;
            return;
         }
         rewardView = new AlchemicalScoreRewardView();
         var _loc2_:Point = new Point();
         _loc2_ = lookRewardText.localToGlobal(_loc2_);
         rewardView.x = _loc2_.x - rewardView.displayWidth - 10;
         rewardView.y = _loc2_.y - 254;
         if(rewardView.y < 0)
         {
            rewardView.y = 20;
         }
         rewardView.show();
         param1.stopPropagation();
      }
      
      private function __updateSelfDataChange(param1:String, param2:Object) : void
      {
         refreshDataView();
         refreshFormulaView();
      }
      
      private function __updateFormulaChange(param1:String, param2:Object) : void
      {
         refreshFormulaView();
      }
      
      private function refreshDataView() : void
      {
         if(!model.nextSocreUpgradeTemp)
         {
            scoreText.htmlText = LanguageMgr.GetTranslation("AlchemicalMakeNoteBookView.scoreText.text2",model.cycleScore,model.cycleMaxScore);
            descText.text = LanguageMgr.GetTranslation("AlchemicalMakeNoteBookView.descText.text",model.cycleRewardCount);
         }
         else
         {
            scoreText.text = LanguageMgr.GetTranslation("AlchemicalMakeNoteBookView.scoreText.text1",model.curScore,model.nextSocreUpgradeTemp.Data);
            descText.text = model.nextSocreUpgradeTemp.TemplateName;
         }
         descText.y = scoreText.y + scoreText.textHeight + 10;
      }
      
      private function refreshFormulaView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < itemList.length)
         {
            if(itemList[_loc1_])
            {
               if(itemList[_loc1_].btnType == model.selectFormulaType)
               {
                  itemList[_loc1_].selected = true;
                  itemList[_loc1_].selectState = true;
               }
               else
               {
                  itemList[_loc1_].selected = false;
                  itemList[_loc1_].selectState = false;
               }
            }
            _loc1_++;
         }
         __updateListViewHandler("",null);
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(aboveBack);
         aboveBack = null;
         ObjectUtils.disposeObject(scoreText);
         scoreText = null;
         ObjectUtils.disposeObject(descText);
         descText = null;
         ObjectUtils.disposeObject(lookRewardText);
         lookRewardText = null;
         ObjectUtils.disposeObject(btnItemVBox);
         btnItemVBox = null;
         ObjectUtils.disposeObject(btnItemPanel);
         btnItemPanel = null;
         ObjectUtils.disposeObject(rewardView);
         rewardView = null;
         ObjectUtils.disposeObject(singleBtn);
         singleBtn = null;
         ObjectUtils.disposeObject(cooperationBtn);
         cooperationBtn = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         btnGroup = null;
         model.selectFormulaType = -1;
         model.selectFormulaInfo = null;
         model.modelType = 1;
         super.dispose();
      }
   }
}

