package theseusCollention.pro
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.raveparty.RavePartyRewardInfo;
   import mvc.module.theseus.TheseusCollenTionModel;
   import utils.LogicUtils;
   import yishi.datas.templates.CollectionRewardTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   
   public class TheseusCollProView extends Component
   {
      
      private var levelImage:Bitmap;
      
      private var numberBitmap:BitmapData;
      
      private var levelContnier:Component;
      
      private var gradeBar:ProgressCommon;
      
      private var scoreAlertText:FilterFrameText;
      
      private var itemPanel:ScrollPanel;
      
      private var itemVbox:VBox;
      
      private var itemList:Vector.<TheseusCollProItem>;
      
      private var _bg:Bitmap;
      
      private var _bossNameBgImage2:Image;
      
      private var _bossNameTxt:GradientText;
      
      private var _bossNameBgImage:Image;
      
      private var _box:ScaleFrameImage;
      
      private var showType:int;
      
      private var curLevel:int;
      
      private var curScore:int;
      
      private var curShowList:Array;
      
      protected var _allnumTxt:FilterFrameText;
      
      protected var _leftbg:Bitmap;
      
      public function TheseusCollProView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _leftbg = ComponentFactory.Instance.creatBitmap("theseusCollection_leftBg2");
         addChild(_leftbg);
         _leftbg.x = -225;
         _leftbg.width = 855;
         _leftbg.height = 468;
         _bg = ComponentFactory.Instance.creatBitmap("theseusCollection_collectbg");
         addChild(_bg);
         _bg.x = -220;
         _bg.y = 15;
         _allnumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollentionBox.numTxt");
         addChild(_allnumTxt);
         _allnumTxt.x = -179;
         _allnumTxt.y = 252;
         levelImage = ComponentFactory.Instance.creatBitmap("asset.RavePartyScoreView.levelImage");
         numberBitmap = ComponentFactory.Instance.creatBitmapData("asset.RavePartyBoxImage.numberBitmap");
         levelContnier = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.levelContnier");
         gradeBar = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.gradeBar");
         scoreAlertText = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.scoreAlertText");
         itemPanel = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.itemPanel");
         itemVbox = ComponentFactory.Instance.creatComponentByStylename("RavePartyScoreView.itemVbox");
         _box = ComponentFactory.Instance.creatComponentByStylename("theseuscollection.buyResultMcbox");
         _bossNameTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameTxt1");
         _bossNameBgImage2 = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameBgImage21");
         addChild(_bossNameBgImage2);
         addChild(_bossNameTxt);
         addChild(_box);
         _box.setFrame(1);
         _box.scaleX = _box.scaleY = 0.8;
         _box.x = -205;
         _box.y = 105;
         _bossNameBgImage2.x = -220;
         _bossNameTxt.x = -195;
         _bossNameBgImage2.y = 20;
         _bossNameTxt.y = 27;
         _bossNameBgImage2.width = 225;
         _bossNameBgImage2.height = 39;
         _bossNameTxt.text = LanguageMgr.GetTranslation("theseuscollectbox.txt1");
         addChild(scoreAlertText);
         addChild(levelImage);
         addChild(levelContnier);
         addChild(gradeBar);
         addChild(itemPanel);
         itemPanel.beginChanges();
         itemPanel.setView(itemVbox);
         itemPanel.invalidateViewport();
         itemPanel.commitChanges();
         setShowType();
      }
      
      private function refresListView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:RavePartyRewardInfo = null;
         var _loc1_:TheseusCollProItem = null;
         itemVbox.removeAllChild();
         itemList = new Vector.<TheseusCollProItem>();
         _loc2_ = 0;
         while(_loc2_ < curShowList.length)
         {
            _loc3_ = curShowList[_loc2_];
            _loc1_ = new TheseusCollProItem();
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
         TheseussoulManager.Instance.addEventListener("OP_COLLECTION_UPGRADETASK",updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         TheseussoulManager.Instance.removeEventListener("OP_COLLECTION_UPGRADETASK",updateViewHandler);
      }
      
      private function updateViewHandler(param1:Event) : void
      {
         setShowType();
      }
      
      public function setShowType() : void
      {
         scoreAlertText.text = LanguageMgr.GetTranslation("theseus.scoreAlertText.text");
         curScore = model.myTotalScore;
         curShowList = model.playerScoreRewardList;
         _allnumTxt.text = model.allTotallevel + "";
         refresListView();
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:CollectionRewardTemplateInfo = TempleteManager.instance.collectionRewardTempCate.getTemplateByID(model.myTotalid);
         curLevel = _loc2_.Level;
         NumberViewUtils.refreshValue(curLevel,levelContnier,numberBitmap,12,18,10,12,"0123456789");
         if(curScore >= _loc2_.NeedNum)
         {
            gradeBar.value = 1;
            gradeBar.text = "max";
         }
         else
         {
            gradeBar.value = curScore / _loc2_.NeedNum;
            gradeBar.text = curScore + "/" + _loc2_.NeedNum;
         }
         _loc1_ = 0;
         while(_loc1_ < curShowList.length)
         {
            itemList[_loc1_].data = curShowList[_loc1_] ? curShowList[_loc1_] : null;
            _loc1_++;
         }
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      override public function dispose() : void
      {
         removeEvent();
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

