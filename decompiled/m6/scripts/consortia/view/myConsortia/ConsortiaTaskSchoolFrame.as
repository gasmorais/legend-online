package consortia.view.myConsortia
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.myConsortia.item.ConsortiaTaskItem;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import utils.LogicUtils;
   import yishi.datas.templates.ConsortiaQuestTempInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.MsgMan;
   
   public class ConsortiaTaskSchoolFrame extends Frame implements IManualSize
   {
      
      private var _consortiaWeekText:FilterFrameText;
      
      private var _dayActiveText:FilterFrameText;
      
      private var _border:ScaleBitmapImage;
      
      private var _taskItem:ConsortiaTaskItem;
      
      private var _bottomBg:MutipleImage;
      
      private var _btnHbox:HBox;
      
      private var _taskBtn:SelectedIconButton;
      
      private var _newbieBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _itemPanel:ScrollPanel;
      
      private var _itemVbox:VBox;
      
      private var itemList:Vector.<ConsortiaTaskItem>;
      
      private var _isShow:Boolean = false;
      
      private var _openFromConsortiaFrame:int;
      
      public function ConsortiaTaskSchoolFrame()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,740,515);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _consortiaWeekText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskSchoolFrame.consortiaWeekText");
         _dayActiveText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskSchoolFrame.dayActiveText");
         _border = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskSchoolFrame.border");
         _bottomBg = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaTaskSchoolFrame.bottomBg");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaTaskSchoolFrame.btnHbox");
         _taskBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaTaskSchoolView.taskBtn");
         _newbieBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaTaskSchoolView.newbieBtn");
         _itemPanel = ComponentFactory.Instance.creatComponentByStylename("ConsortiaTaskSchoolView.itemPanel");
         _itemVbox = ComponentFactory.Instance.creatComponentByStylename("ConsortiaTaskSchoolView.itemVbox");
         addToContent(_border);
         addToContent(_bottomBg);
         addToContent(_btnHbox);
         addToContent(_itemPanel);
         addToContent(_dayActiveText);
         addToContent(_consortiaWeekText);
         _itemPanel.setView(_itemVbox);
         _btnHbox.addChild(_taskBtn);
         _btnHbox.addChild(_newbieBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_taskBtn);
         _btnGroup.addSelectItem(_newbieBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("UPDATE_QUEST_INFO",this,__updateQuestHandler);
         model.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         MsgMan.removeObserver("UPDATE_QUEST_INFO",this,__updateQuestHandler);
         model.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
      }
      
      private function __onConsortiaInfoUpdata(param1:ConsortiaEvent) : void
      {
         _dayActiveText.text = model.consortiaInfo.consortiaActivePoint + "";
         _consortiaWeekText.text = model.consortiaInfo.consortiaWeeklyActivePoint + "";
      }
      
      private function __updateQuestHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ConsortiaTaskItem = null;
         _itemPanel.beginChanges();
         _itemVbox.removeAllChild();
         itemList = new Vector.<ConsortiaTaskItem>();
         var _loc2_:Array = showData;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("Consortia.ConsortiaTaskSchoolFrame.taskItem");
            _itemVbox.addChild(_loc3_);
            itemList.push(_loc3_);
            _loc4_++;
         }
         _itemPanel.invalidateViewport();
         _itemPanel.commitChanges();
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ConsortiaTaskItem = null;
         _dayActiveText.text = model.consortiaInfo.consortiaActivePoint + "";
         _consortiaWeekText.text = model.consortiaInfo.consortiaWeeklyActivePoint + "";
         var _loc1_:Array = showData;
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            _loc2_ = itemList[_loc3_];
            _loc2_.tempInfo = _loc3_ < _loc1_.length ? _loc1_[_loc3_] : null;
            _loc2_.setIndex(_loc3_ + 1);
            _loc3_++;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _isShow = true;
               dispose();
         }
      }
      
      public function show(param1:int) : void
      {
         _openFromConsortiaFrame = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ConsortiaFacilitiesView.warriorCampText.text");
      }
      
      private function get showData() : Array
      {
         var _loc1_:Array = model.taskTempDic[_btnGroup.selectIndex + 2];
         _loc1_.sort(sortFun);
         return _loc1_;
      }
      
      private function sortFun(param1:ConsortiaQuestTempInfo, param2:ConsortiaQuestTempInfo) : int
      {
         var _loc4_:int = int(model.getRewardState(param1,true));
         var _loc3_:int = int(model.getRewardState(param2,true));
         if(_loc4_ > _loc3_)
         {
            return -1;
         }
         if(_loc4_ < _loc3_)
         {
            return 1;
         }
         return param1.Sort < param2.Sort ? -1 : 1;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_consortiaWeekText);
         _consortiaWeekText = null;
         ObjectUtils.disposeObject(_dayActiveText);
         _dayActiveText = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_taskItem);
         _taskItem = null;
         ObjectUtils.disposeObject(_bottomBg);
         _bottomBg = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_taskBtn);
         _taskBtn = null;
         ObjectUtils.disposeObject(_newbieBtn);
         _newbieBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_itemPanel);
         _itemPanel = null;
         ObjectUtils.disposeObject(_itemVbox);
         _itemVbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
         FrameControllerManager.instance.consortiaController.closeSkillFrame(_openFromConsortiaFrame,_isShow);
      }
   }
}

