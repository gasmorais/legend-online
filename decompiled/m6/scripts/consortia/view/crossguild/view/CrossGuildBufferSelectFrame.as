package consortia.view.crossguild.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.crossguild.CrossGuildModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.CrossGuildManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.PageBar;
   
   public class CrossGuildBufferSelectFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _itemBox:VBox;
      
      private var _pageBar:PageBar;
      
      private var itemList:Vector.<CrossGuildBufferSelectItem>;
      
      private var pageCount:int = 5;
      
      public function CrossGuildBufferSelectFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferSelectFrame.back");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferSelectFrame.itemBox");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("CrossGuildBufferSelectFrame.pageBar");
         addToContent(_back);
         addToContent(_itemBox);
         addToContent(_pageBar);
      }
      
      private function initListView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:CrossGuildBufferSelectItem = null;
         _pageBar.setAutoPagingData(model.guildSkillTempAry,pageCount);
         _pageBar.setCurPage(1);
         var _loc1_:Array = _pageBar.getCurPageDatas();
         itemList = new Vector.<CrossGuildBufferSelectItem>();
         _loc3_ = 1;
         while(_loc3_ <= pageCount)
         {
            _loc2_ = new CrossGuildBufferSelectItem(_loc3_);
            _loc2_.data = _loc1_[_loc3_ - 1];
            _loc2_.setPage(_pageBar.getCurPage());
            _itemBox.addChild(_loc2_);
            itemList.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _pageBar.addEventListener("change",_pageChangeHandler);
         MsgMan.addObserver("CROSS_GUILD_MAIN_CHANGE",this,__updateMainInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",_pageChangeHandler);
         }
         MsgMan.removeObserver("CROSS_GUILD_MAIN_CHANGE",this,__updateMainInfoHandler);
      }
      
      private function __updateMainInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function _pageChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:CrossGuildBufferSelectItem = null;
         var _loc1_:Array = _pageBar.getCurPageDatas();
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            _loc2_ = itemList[_loc3_];
            _loc2_.data = _loc1_[_loc3_];
            _loc2_.setPage(_pageBar.getCurPage());
            _loc3_++;
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
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("CrossGuildBufferSelectFrame.titleText.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

