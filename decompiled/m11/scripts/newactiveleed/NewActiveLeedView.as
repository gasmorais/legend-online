package newactiveleed
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.NewActiveLeedManager;
   import mvc.module.newactiveleed.NewActiveLeedModel;
   import yishi.datas.templates.NewActiveLeedInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class NewActiveLeedView extends Sprite implements Disposeable
   {
      
      private var _progress:MovieClip;
      
      private var _dayBoxArr:Array;
      
      private var _dayIcon:Bitmap;
      
      private var _dayNumTxt:FilterFrameText;
      
      private var _dayDescTxt:FilterFrameText;
      
      private var _weekBoxArr:Array;
      
      private var _weekIcon:Bitmap;
      
      private var _weekNumTxt:FilterFrameText;
      
      private var _weekDescTxt:FilterFrameText;
      
      private var _dailyBtn:SelectedIconButton;
      
      private var _singleBtn:SelectedIconButton;
      
      private var _mutiBtn:SelectedIconButton;
      
      private var _mutiPkBtn:SelectedIconButton;
      
      private var _consortiaBtn:SelectedIconButton;
      
      private var _petAndChildBtn:SelectedIconButton;
      
      private var _hBox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _sonTypeArr:Array;
      
      public function NewActiveLeedView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _progress = ComponentFactory.Instance.creatCustomObject("NewActiveLeedView.Progress");
         _dayIcon = ComponentFactory.Instance.creatBitmap("asset.NewActiveLeedFrame.iconImg");
         _dayNumTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.dayNumTxt");
         _dayDescTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.dayDescTxt");
         _weekIcon = ComponentFactory.Instance.creatBitmap("asset.NewActiveLeedFrame.iconImg");
         _weekNumTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.weekNumTxt");
         _weekDescTxt = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.weekDescTxt");
         _dailyBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.dailyBtn");
         _singleBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.singleBtn");
         _mutiBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.mutiBtn");
         _mutiPkBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.mutiPkBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.consortiaBtn");
         _petAndChildBtn = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.petAndChildBtn");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.hBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.scrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("NewActiveLeedView.vBox");
         addChild(_progress);
         addChild(_dayIcon);
         addChild(_dayNumTxt);
         addChild(_dayDescTxt);
         addChild(_weekIcon);
         addChild(_weekNumTxt);
         addChild(_weekDescTxt);
         addChild(_hBox);
         addChild(_scrollPanel);
         _scrollPanel.setView(_vBox);
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
         _progress.gotoAndStop(1);
         _dayIcon.x = 112;
         _dayIcon.y = 85;
         _weekIcon.x = 143;
         _weekIcon.y = 382;
         _dayDescTxt.text = LanguageMgr.GetTranslation("NewActiveLeedView.dayDescTxt.text");
         _weekDescTxt.text = LanguageMgr.GetTranslation("NewActiveLeedView.weekDescTxt.text");
         _btnGroup = new SelectedButtonGroup();
         initDayItem();
         initWeekItem();
      }
      
      private function refreshBtn() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         var _loc1_:Array = [_dailyBtn,_singleBtn,_mutiBtn,_mutiPkBtn,_consortiaBtn,_petAndChildBtn];
         _sonTypeArr = [];
         _hBox.removeAllChild();
         _btnGroup.removeAllItem();
         _btnGroup.selectIndex = -1;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = TempleteManager.instance.newActiveLeedCate.getInfoArrByType(model.masterType,_loc3_ + 1);
            _loc2_ = int(_loc4_.length);
            if(_loc2_ > 0)
            {
               _hBox.addChild(_loc1_[_loc3_]);
               _btnGroup.addSelectItem(_loc1_[_loc3_]);
               _sonTypeArr.push(_loc3_ + 1);
            }
            _loc3_++;
         }
         _btnGroup.selectIndex = 0;
      }
      
      private function initDayItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NewActiveBoxItem = null;
         _dayBoxArr = [];
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new NewActiveBoxItem();
            _loc1_.x = 80 + _loc2_ * 90;
            _loc1_.y = 5;
            _loc1_.state = 1;
            _loc1_.updateView(_loc2_,false);
            _dayBoxArr.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function initWeekItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NewActiveBoxItem = null;
         _weekBoxArr = [];
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new NewActiveBoxItem();
            _loc1_.x = 260 + _loc2_ * 110;
            _loc1_.y = 368;
            _loc1_.state = 1;
            _loc1_.updateView(_loc2_,true);
            _weekBoxArr.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshActiveItem() : void
      {
         var _loc4_:int = 0;
         var _loc6_:NewActiveLeedInfo = null;
         var _loc2_:NewActiveLeedItem = null;
         _vBox.removeAllChild();
         var _loc1_:int = int(_sonTypeArr[_btnGroup.selectIndex]);
         var _loc5_:Array = TempleteManager.instance.newActiveLeedCate.getInfoArrByType(model.masterType,_loc1_);
         var _loc3_:int = int(_loc5_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = _loc5_[_loc4_];
            if(!(_loc6_.TaskType == 98 && model.vipNum == 0))
            {
               _loc2_ = new NewActiveLeedItem();
               _loc2_.data = _loc6_;
               _vBox.addChild(_loc2_);
            }
            _loc4_++;
         }
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function refreshBoxItem() : void
      {
         for each(var _loc2_:NewActiveBoxItem in _dayBoxArr)
         {
            _loc2_.refreshView();
         }
         for each(var _loc1_:NewActiveBoxItem in _weekBoxArr)
         {
            _loc1_.refreshView();
         }
      }
      
      private function addEvent() : void
      {
         _btnGroup.addEventListener("change",__btnChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__btnChangeHandler);
      }
      
      private function __btnChangeHandler(param1:Event) : void
      {
         _scrollPanel.scrollToTop();
         refreshActiveItem();
      }
      
      public function refreshView() : void
      {
         refreshBtn();
         refreshBoxItem();
         _dayNumTxt.text = model.dailyNum.toString();
         _weekNumTxt.text = model.weekNum.toString();
         var _loc3_:SimpleDictionary = TempleteManager.instance.newActiveLeedDailyCate.getDropGoods(model.masterType);
         var _loc1_:Array = _loc3_.slice();
         _loc1_.sortOn("key",16);
         var _loc2_:Object = _loc1_[_loc1_.length - 1];
         var _loc5_:int = int(_loc2_.key);
         var _loc4_:int = model.dailyNum / _loc5_ * 100;
         _progress.gotoAndStop(_loc4_);
      }
      
      private function get model() : NewActiveLeedModel
      {
         return NewActiveLeedManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_dayIcon);
         _dayIcon = null;
         ObjectUtils.disposeObject(_dayNumTxt);
         _dayNumTxt = null;
         ObjectUtils.disposeObject(_dayDescTxt);
         _dayDescTxt = null;
         ObjectUtils.disposeObject(_weekIcon);
         _weekIcon = null;
         ObjectUtils.disposeObject(_weekNumTxt);
         _weekNumTxt = null;
         ObjectUtils.disposeObject(_weekDescTxt);
         _weekDescTxt = null;
         ObjectUtils.disposeObject(_dailyBtn);
         _dailyBtn = null;
         ObjectUtils.disposeObject(_singleBtn);
         _singleBtn = null;
         ObjectUtils.disposeObject(_mutiBtn);
         _mutiBtn = null;
         ObjectUtils.disposeObject(_mutiPkBtn);
         _mutiPkBtn = null;
         ObjectUtils.disposeObject(_consortiaBtn);
         _consortiaBtn = null;
         ObjectUtils.disposeObject(_petAndChildBtn);
         _petAndChildBtn = null;
         for each(var _loc1_:NewActiveBoxItem in _dayBoxArr)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         for each(var _loc2_:NewActiveBoxItem in _weekBoxArr)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         for each(var _loc3_:NewActiveLeedItem in _vBox)
         {
            ObjectUtils.disposeObject(_loc3_);
            _loc3_ = null;
         }
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

