package theseuspvp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.TheseusPvpManager;
   import mvc.module.theseuspvp.TheseusPvpRewardInfo;
   import mvc.module.theseuspvp.TheseusPvpUserInfo;
   import theseuspvp.item.TheseusPvpRewardItem;
   import yishi.datas.templates.TheseusPvpTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class TheseusPvpRewardFrame extends Frame implements IManualSize
   {
      
      public var _rewardBg:Bitmap;
      
      public var _rewardVbox:VBox;
      
      public var _rewardScoreTxt:FilterFrameText;
      
      public var _rewardStepTxt:FilterFrameText;
      
      public var _rewardSortTxt:FilterFrameText;
      
      private var _rewardSpanel:ScrollPanel;
      
      private var _tabBtn1:SelectedIconButton;
      
      private var _tabBtn2:SelectedIconButton;
      
      private var _tabBtn3:SelectedIconButton;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _itemList:Array = [];
      
      private var _dataList:Dictionary = new Dictionary();
      
      private var _currItemList:Array = [];
      
      public function TheseusPvpRewardFrame()
      {
         super();
         initView();
         initEvent();
         _tabGroup.selectIndex = 0;
         TheseusPvpManager.Instance.doSomething(13);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,583,652);
      }
      
      private function initView() : void
      {
         _rewardBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.rewardBg");
         _rewardVbox = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.rewardVbox");
         _rewardScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rewardScoreTxt");
         _rewardStepTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rewardStepTxt");
         _rewardSortTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rewardSortTxt");
         _rewardSpanel = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rewardSpanel");
         _tabBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rewardTab1");
         _tabBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rewardTab2");
         _tabBtn3 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.rewardTab3");
         addToContent(_rewardBg);
         addToContent(_rewardScoreTxt);
         addToContent(_rewardStepTxt);
         addToContent(_rewardSortTxt);
         addToContent(_rewardSpanel);
         addToContent(_tabBtn1);
         addToContent(_tabBtn2);
         addToContent(_tabBtn3);
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_tabBtn1);
         _tabGroup.addSelectItem(_tabBtn2);
         _tabGroup.addSelectItem(_tabBtn3);
         _rewardSpanel.setView(_rewardVbox);
         var _loc1_:TheseusPvpUserInfo = TheseusPvpManager.Instance.model.selfUserInfo;
         _rewardScoreTxt.text = LanguageMgr.GetTranslation("theseuspvp.currScoreTitle",_loc1_.integral);
         var _loc2_:TheseusPvpTempInfo = TempleteManager.instance.theseusPvpTempCate.getTempById(_loc1_.pvpId);
         _rewardStepTxt.text = LanguageMgr.GetTranslation("theseuspvp.currStepTitle",_loc2_.Name);
         _loc2_ = TempleteManager.instance.theseusPvpTempCate.getTempById(_loc1_.maxPvpId);
         _rewardSortTxt.text = LanguageMgr.GetTranslation("theseuspvp.maxStepName",_loc2_.Name);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tabGroup.addEventListener("change",__tabChangeHandler);
         NotificationManager.instance.addEventListener("theseuspvpRewardEvent",updateRewardHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _tabGroup.removeEventListener("change",__tabChangeHandler);
         NotificationManager.instance.removeEventListener("theseuspvpRewardEvent",updateRewardHandler);
      }
      
      private function updateRewardHandler(param1:NotificationEvent) : void
      {
         var _loc3_:Array = param1.data as Array;
         for each(var _loc4_:TheseusPvpRewardInfo in _loc3_)
         {
            _dataList[_loc4_.templateId] = _loc4_;
            for each(var _loc2_:TheseusPvpRewardItem in _itemList)
            {
               if(_loc2_.parent && _loc2_.temp && _loc2_.temp.Id == _loc4_.templateId)
               {
                  _loc2_.data = _loc4_;
               }
            }
         }
         sortItemList();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         var _loc2_:TheseusPvpRewardItem = null;
         var _loc4_:int = 0;
         _currItemList.length = 0;
         var _loc5_:Array = TempleteManager.instance.theseusPvpTaskCate.getListByArea(_tabGroup.selectIndex + 1);
         var _loc3_:int = int(_loc5_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc4_ >= _itemList.length)
            {
               _loc2_ = new TheseusPvpRewardItem();
               _itemList.push(_loc2_);
            }
            else
            {
               _loc2_ = _itemList[_loc4_];
            }
            _loc2_.temp = _loc5_[_loc4_];
            _loc2_.data = _dataList[_loc2_.temp.Id];
            _currItemList.push(_loc2_);
            _loc4_++;
         }
         sortItemList();
      }
      
      private function sortItemList() : void
      {
         var _loc1_:TheseusPvpRewardItem = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(_currItemList.length);
         var _loc5_:Array = [];
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = _currItemList[_loc4_];
            if(_loc1_.data && _loc1_.data.state == 2)
            {
               _loc3_.push(_loc1_);
            }
            else
            {
               _loc5_.push(_loc1_);
            }
            _loc4_++;
         }
         var _loc6_:Array = _loc5_.concat(_loc3_);
         _loc2_ = int(_loc6_.length);
         _rewardVbox.beginChanges();
         _rewardVbox.removeAllChild();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = _loc6_[_loc4_];
            _rewardVbox.addChild(_loc1_);
            _loc4_++;
         }
         _rewardVbox.commitChanges();
         _rewardSpanel.invalidateViewport();
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
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP","TREASURE_MAP_GROUP"];
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("theseuspvp.rewardFTitle");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseusPvpRewardItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_rewardVbox);
         _rewardVbox = null;
         ObjectUtils.disposeObject(_rewardSpanel);
         _rewardSpanel = null;
         ObjectUtils.disposeObject(_rewardScoreTxt);
         _rewardScoreTxt = null;
         ObjectUtils.disposeObject(_rewardStepTxt);
         _rewardStepTxt = null;
         ObjectUtils.disposeObject(_rewardSortTxt);
         _rewardSortTxt = null;
         ObjectUtils.disposeObject(_tabBtn1);
         _tabBtn1 = null;
         ObjectUtils.disposeObject(_tabBtn2);
         _tabBtn2 = null;
         ObjectUtils.disposeObject(_tabBtn3);
         _tabBtn3 = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         super.dispose();
         _dataList = null;
         _currItemList = null;
      }
   }
}

