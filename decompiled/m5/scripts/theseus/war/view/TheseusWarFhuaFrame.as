package theseus.war.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulHatchInfo;
   import theseus.war.item.TheseusWarFuhuCell;
   
   public class TheseusWarFhuaFrame extends Frame
   {
      
      private var _hbox:VBox;
      
      private var _itemList:Vector.<TheseusWarFuhuCell> = new Vector.<TheseusWarFuhuCell>();
      
      public function TheseusWarFhuaFrame()
      {
         super();
         initView();
         initEvent();
         refreshDataView();
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusWarFuhuCell = null;
         var _loc2_:int = 0;
         titleText = LanguageMgr.GetTranslation("theseus.war.fuhuaTitle");
         _hbox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warFhuaFrameVbox");
         addToContent(_hbox);
         _hbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new TheseusWarFuhuCell(_loc2_ + 1);
            _hbox.addChild(_loc1_);
            _itemList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _hbox.commitChanges();
      }
      
      private function refreshDataView() : void
      {
         var _loc1_:TheseusWarFuhuCell = null;
         var _loc3_:TheseusWarsoulHatchInfo = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = TheseussoulManager.Instance.warsoulModel.getHatchInfo(_loc2_ + 1);
            _loc1_ = _itemList[_loc2_];
            _loc1_.data = _loc3_;
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EGG",eggListHandler);
      }
      
      private function removeEvent() : void
      {
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EGG",eggListHandler);
      }
      
      private function eggListHandler(param1:Event) : void
      {
         refreshDataView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseusWarFuhuCell in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         super.dispose();
      }
   }
}

