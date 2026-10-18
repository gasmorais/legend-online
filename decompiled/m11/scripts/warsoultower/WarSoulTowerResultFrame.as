package warsoultower
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.warsoultower.WarSoulTowerModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.WarSoulTowerLevelTempInfo;
   import yishi.datas.templates.WarSoulTowerStageTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.manager.WarSoulTowerManager;
   
   public class WarSoulTowerResultFrame extends Frame implements IManualSize
   {
      
      private var _bg:MovieClip;
      
      private var _btn:IconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _repeatBtn:SelectedButton;
      
      private var _passBtn:SelectedButton;
      
      private var _stageBtn:SelectedButton;
      
      private var _border:ScaleBitmapImage;
      
      private var _itemVBox:VBox;
      
      private var _spanel:ScrollPanel;
      
      private var _titleTxt:GradientText;
      
      private var _startTxt:GradientText;
      
      private var _endTxt:GradientText;
      
      private var _highestTxt:GradientText;
      
      private var _recordImg:Bitmap;
      
      public function WarSoulTowerResultFrame()
      {
         super();
         initView();
         addEvent();
         _group.selectIndex = 0;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,789,314);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatCustomObject("warSoulTowerResultFrame.bg");
         _btn = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.btn");
         _repeatBtn = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.repeatBtn");
         _passBtn = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.passBtn");
         _stageBtn = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.stageBtn");
         _group = new SelectedButtonGroup();
         _border = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.border");
         _itemVBox = ComponentFactory.Instance.creatCustomObject("warSoulTowerResultFrame.itemVBox");
         _spanel = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.spanel");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.titleTxt");
         _startTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.startTxt");
         _endTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.endTxt");
         _highestTxt = ComponentFactory.Instance.creatComponentByStylename("warSoulTowerResultFrame.highestTxt");
         _recordImg = ComponentFactory.Instance.creatBitmap("asset.warSoulTowerResultFrame.recordImg");
         addToContent(_bg);
         addToContent(_btn);
         addToContent(_repeatBtn);
         addToContent(_passBtn);
         addToContent(_stageBtn);
         addToContent(_border);
         addToContent(_spanel);
         addToContent(_titleTxt);
         addToContent(_startTxt);
         addToContent(_endTxt);
         addToContent(_highestTxt);
         addToContent(_recordImg);
         _group.addSelectItem(_repeatBtn);
         _group.addSelectItem(_passBtn);
         _group.addSelectItem(_stageBtn);
         _spanel.setView(_itemVBox);
         _titleTxt.text = LanguageMgr.GetTranslation("warSoulTowerResultFrame.titleTxt.text");
         _startTxt.text = model.startLevel.toString();
         _endTxt.text = model.overLevel.toString();
         _highestTxt.text = model.highestUnLockLevel.toString();
         _recordImg.visible = model.isNewRecord;
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__btnClickHandler);
         _group.addEventListener("change",__selectedHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__btnClickHandler);
         _group.removeEventListener("change",__selectedHandler);
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc3_:WarSoulTowerResultItem = null;
         var _loc2_:WarSoulTowerLevelTempInfo = null;
         var _loc6_:WarSoulTowerStageTempInfo = null;
         var _loc4_:int = int(_group.selectIndex);
         var _loc1_:Array = [];
         if(_loc4_ == 0)
         {
            _loc1_ = model.repeatRewardsArr;
         }
         else if(_loc4_ == 1)
         {
            _loc1_ = model.passRewardsArr;
         }
         else
         {
            _loc1_ = model.stageRewardsArr;
         }
         _itemVBox.removeAllChild();
         _itemVBox.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc3_ = new WarSoulTowerResultItem(_loc4_);
            if(_loc4_ <= 1)
            {
               _loc2_ = TempleteManager.instance.warSoulTowerLevelTempCate.getTempInfoByLevelId(_loc1_[_loc5_]);
               if(_loc2_)
               {
                  _loc3_.data = _loc2_;
               }
            }
            else
            {
               _loc6_ = TempleteManager.instance.warSoulTowerStageTempCate.getTempInfoByLevelId(_loc1_[_loc5_]);
               if(_loc6_)
               {
                  _loc3_.data = _loc6_;
               }
            }
            _itemVBox.addChild(_loc3_);
            _loc5_++;
         }
         _itemVBox.commitChanges();
         _spanel.invalidateViewport();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : WarSoulTowerModel
      {
         return WarSoulTowerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_repeatBtn);
         _repeatBtn = null;
         ObjectUtils.disposeObject(_passBtn);
         _passBtn = null;
         ObjectUtils.disposeObject(_stageBtn);
         _stageBtn = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_startTxt);
         _startTxt = null;
         ObjectUtils.disposeObject(_endTxt);
         _endTxt = null;
         ObjectUtils.disposeObject(_highestTxt);
         _highestTxt = null;
         ObjectUtils.disposeObject(_recordImg);
         _recordImg = null;
         ObjectUtils.disposeAllChildren(_itemVBox);
         _itemVBox = null;
         super.dispose();
      }
   }
}

